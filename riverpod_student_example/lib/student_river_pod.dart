import "package:flutter_riverpod/flutter_riverpod.dart";
final studentprovider = StateNotifierProvider < StudentProvider ,  List<Student> > (
    (_)=>StudentProvider(),
);
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

class StudentProvider extends StateNotifier<List<Student>> {
  StudentProvider():super([]);
  List<Student> _stdList = [];

  List<Student> get students => _stdList;

  void addStudent(Student std) {
    state.add(std);
  }



  void removeStudent(Student std) {
   state.remove(std);

  }

  void clearStudent() {
    state.clear();
  }
}

