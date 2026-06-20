import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => Studentprovider(),
      child: StudentApp(),
    ),
  );
}

// Model class
class Student {
  String Id;
  String Name;
  String program;
  String cgpa;

  Student({
    required this.Id,
    required this.Name,
    required this.program,
    required this.cgpa,
  });
}

class Studentprovider extends ChangeNotifier {
  List<Student> _stdList = [];

  List<Student> get students => _stdList;

  void addStudent(Student std) {
    _stdList.add(std);
    notifyListeners();
  }

  void updateStudent(Student ostd, Student nstd) {
    int index = _stdList.indexOf(ostd);
    if (index != -1) {
      _stdList[index] = nstd;
      notifyListeners();
    }
  }

  void removeStudent(Student std) {
    _stdList.remove(std);
    notifyListeners();
  }

  void clearStudent() {
    _stdList.clear();
    notifyListeners();
  }
}

class StudentApp extends StatelessWidget {
  final TextEditingController txtID = TextEditingController();
  final TextEditingController txtName = TextEditingController();
  final TextEditingController txtCgpa = TextEditingController();
  final TextEditingController txtProgram = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Studentprovider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Add Student')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: txtID,
              decoration: InputDecoration(labelText: 'Enter Id'),
            ),
            TextField(
              controller: txtName,
              decoration: InputDecoration(labelText: 'Enter Name'),
            ),
            TextField(
              controller: txtCgpa,
              decoration: InputDecoration(labelText: 'Enter CGPA'),
            ),
            TextField(
              controller: txtProgram,
              decoration: InputDecoration(labelText: 'Enter Program'),
            ),
            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                provider.addStudent(
                  Student(
                    Id: txtID.text,
                    Name: txtName.text,
                    program: txtProgram.text,
                    cgpa: txtCgpa.text,
                  ),
                );
                txtID.clear();
                txtName.clear();
                txtCgpa.clear();
                txtProgram.clear();
              },
              child: Text('Add Record'),
            ),
              Expanded(child: ListView.builder(
                itemCount: provider.students.length,
                itemBuilder:(context , index){
                  final std= provider.students[index];
                  return ListTile(
                    title: Text(std.Id),
                    subtitle: Text(std.Name),
                    onTap: (){
                    Navigator.push(context,MaterialPageRoute(builder:(_)=> EditStudent(stud:std),),);
                    },
                  );
                }
              )
            ),
          ],
        ),
      ),
    );
  }

}

class EditStudent extends StatefulWidget {
  final Student stud ;
  // can we use primary key instead of superkey?
  EditStudent({super.key, required this.stud});
  @override
  StudentState  createState ()=>  StudentState();

   }
   class StudentState extends State<EditStudent> {
     late TextEditingController txtId;
     late TextEditingController txtName;
     late TextEditingController txtcgpa;
     late TextEditingController txtprogram;

     @override
     void initState() {
       super.initState();
       txtId = TextEditingController(text: widget.stud.Id);
       txtName = TextEditingController(text: widget.stud.Name);
       txtcgpa = TextEditingController(text: widget.stud.cgpa);
       txtprogram = TextEditingController(text: widget.stud.program);
     }

     @override
     void dispose() {
       txtId.dispose();
       txtName.dispose();
       txtcgpa.dispose();
       txtprogram.dispose();
     }

     @override
     Widget build(BuildContext context) {
       final provider = Provider.of<Studentprovider>(context);
       return Scaffold(
         appBar: AppBar(title: Text("Edit student")),
         body: Padding(padding: EdgeInsets.all(15.5),
           child: Column(
             children: [
               TextField(
                 controller: txtId,
                 decoration: InputDecoration(labelText: "enter name"),
               ),
               TextField(
                 controller: txtName,
                 decoration: InputDecoration(labelText: "enter name"),
               ),
               TextField(
                 controller: txtcgpa,
                 decoration: InputDecoration(labelText: "enter name"),
               ),
               TextField(
                 controller: txtcgpa,
                 decoration: InputDecoration(labelText: "enter name"),
               ),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 children: [
                   ElevatedButton(onPressed: () {
                     provider.updateStudent(
                         widget.stud,
                         Student(
                           Id: txtId.text,
                           Name: txtName.text,
                           program: txtprogram.text,
                           cgpa: txtcgpa.text,
                         )
                     );
                     Navigator.pop(context);
                   }, child: Text("update ")),
                 ],
               )x
             ],
           ),
         ),

       );
     }
   }