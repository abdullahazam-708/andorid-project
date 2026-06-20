import 'package:flutter/material.dart';

void main(){
  runApp(EmployeeApp());
}

class Employee {  // For data Handling.
  String name;
  String designation;
  double salary;

  Employee(this.name, this.designation, this.salary);
}

class EmployeeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Employee App',
      home: EmployeeScreen(),
    );
  }
}

class EmployeeScreen extends StatefulWidget {
  @override
  _EmployeeScreenState createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  final txtName = TextEditingController();
  final txtDesignation = TextEditingController();
  final txtSalary = TextEditingController();

  List<Employee> empList = [];

  void addEmployee() {
    String name = txtName.text;
    String designation = txtDesignation.text;
    double salary = double.parse(txtSalary.text);

    setState(() {
      empList.add(Employee(name, designation, salary));
    });

    txtName.clear();
    txtDesignation.clear();
    txtSalary.clear();
  }

  void showEmployee() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => EmployeeListScreen(empList)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Employee'),),
      body: Padding(padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: txtName,
              decoration: InputDecoration(labelText: "Employee Name:"),
            ),
            TextField(
              controller: txtDesignation,
              decoration: InputDecoration(labelText: "Employee Designation:"),
            ),
            TextField(
              controller: txtSalary,
              decoration: InputDecoration(labelText: "Employee Salary:"),
            ),

            SizedBox(height: 20),
            ElevatedButton(
                onPressed: addEmployee,
                child: Text('Add Employee Record')),
            SizedBox(height: 15),
            ElevatedButton(
                onPressed: showEmployee,
                child: Text('Show Employee Records')),
          ],
        ),
      ),
    );
  }
}

class EmployeeListScreen extends StatelessWidget {
  final List<Employee> employees;

  EmployeeListScreen(this.employees);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Employee Records.'),),
      body: ListView.builder(
        itemCount: employees.length,
        itemBuilder: (context, index) {
          final emp = employees[index];
          return Card(
            margin: EdgeInsets.all(12),
            elevation: 5,
            child: ListTile(
              title: Text(emp.name),
              subtitle: Text('Designation: ${emp.designation}\nSalary: \$${emp.salary.toStringAsFixed(2)}'),
              trailing: Text("Rs ${emp.salary}"),
            ),
          );
        },
      ),
    );
  }
}