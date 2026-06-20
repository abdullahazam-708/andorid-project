import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(TimerApp());
}

class TimerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Stopwatch',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.grey[100],
        textTheme: TextTheme(
          bodyLarge: TextStyle(fontFamily: 'Roboto'),
        ),
      ),
      home: TimerHome(),
    );
  }
}

class TimerHome extends StatefulWidget {
  @override
  _TimerHomeState createState() => _TimerHomeState();
}

class _TimerHomeState extends State<TimerHome> {
  int seconds = 0;
  Timer? timer;
  bool isRunning = false;

  void startTimer() {
    if (!isRunning) {
      isRunning = true;
      timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
        setState(() {
          seconds++;
        });
      });
    }
  }

  void stopTimer() {
    timer?.cancel();
    isRunning = false;
  }

  void restartTimer() {
    stopTimer();
    setState(() {
      seconds = 0;
    });
  }

  String formattedTime(int numSeconds) {
    int hrs = numSeconds ~/ 3600;
    int mins = (numSeconds % 3600) ~/ 60;
    int secs = numSeconds % 60;

    String hoursStr = hrs.toString().padLeft(2, '0');
    String minsStr = mins.toString().padLeft(2, '0');
    String secsStr = secs.toString().padLeft(2, '0');

    return '$hoursStr:$minsStr:$secsStr';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Stopwatch'),
        centerTitle: true,
        elevation: 4,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.teal, Colors.tealAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Center(
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          margin: EdgeInsets.symmetric(horizontal: 40),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            alignment: Alignment.center,
            child: Text(
              formattedTime(seconds),
              style: TextStyle(
                fontSize: 70,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
                color: Colors.teal[800],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: startTimer,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
              ),
              child: Text('Start', style: TextStyle(fontSize: 18)),
            ),
            ElevatedButton(
              onPressed: stopTimer,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: Colors.redAccent,
                elevation: 4,
              ),
              child: Text('Stop', style: TextStyle(fontSize: 18)),
            ),
            ElevatedButton(
              onPressed: restartTimer,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: Colors.orangeAccent,
                elevation: 4,
              ),
              child: Text('Reset', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}