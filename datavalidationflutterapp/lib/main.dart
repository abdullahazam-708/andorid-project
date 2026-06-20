import 'package:flutter/material.dart';

void main() {
  runApp(LoginApp());
}

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Validation App',
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final txtEmail = TextEditingController();
  final txtPassword = TextEditingController();
  final formKey = GlobalKey<FormState>();

  voi d login() {
    if (formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login successful')),
      );

      txtEmail.clear();
      txtPassword.clear();

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => QuizScreen()),
      );
    }
  }

  @override
  void dispose() {
    txtEmail.dispose();
    txtPassword.dispose();
    super.dispose();
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter email';
    } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter password';
    } else if (value.length < 8) {
      return 'Password should be at least 8 characters';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login App'),

      ),
      body: Padding(
        padding: EdgeInsets.all(14.5),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: txtEmail,
                decoration: InputDecoration(labelText: 'Enter Email'),
                keyboardType: TextInputType.emailAddress,
                validator: validateEmail,
              ),
              TextFormField(
                controller: txtPassword,
                decoration: InputDecoration(labelText: 'Enter Password'),
                obscureText: true,
                validator: validatePassword,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: login,
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class QuizScreen extends StatefulWidget {
  @override
  QuizScreenState createState() => QuizScreenState();
}

class QuizScreenState extends State<QuizScreen> {
  final String question = "What is my name?";
  final List<String> options = ["Karachi", "Abdullah"];
  final String correctAns = "Abdullah";

  String? selectedOption;
  String result = "";

  void checkAnswer() {
    if (selectedOption == null) {
      setState(() {
        result = "Please select an option";
      });
      return;
    }

    setState(() {
      result = selectedOption == correctAns
          ? "Correct Option"
          : "Wrong Option";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz App"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 20),

            Column(
              children: options.map((option) {
                return RadioListTile<String>(
                  title: Text(option),
                  value: option,
                  groupValue: selectedOption,
                  onChanged: (value) {
                    setState(() {
                      selectedOption = value;
                    });
                  },
                );
              }).toList(),
            ),

            ElevatedButton(
              onPressed: checkAnswer,
              child: Text("Submit"),
            ),

            SizedBox(height: 20),

            Text(
              result,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}