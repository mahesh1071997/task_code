import 'package:flutter/material.dart';
import 'menu.dart';
import 'move.dart';
// import 'package:move_demo/move.dart';
// import 'package:move_demo/reorder.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Navigation Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigate to Details Page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  SquareAnimation()),
                );
              },
              child: const Text("task 2 Square Animation"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to User Page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  AnimatedReorderableList()),
                );
              },
              child: const Text("task 1 MacOS Dock"),
            ),
          ],
        ),
      ),
    );
  }
}
