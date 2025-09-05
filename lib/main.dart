import 'package:flutter/material.dart';
import 'package:portfolio/macOS/entry.dart';
import 'package:portfolio/windows/entry.dart';
import 'package:portfolio/platform_detector.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Jaivardhan Bhola',
      home: HomeScreen(),
      
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: isMacOSPlatform()
            ? const MacEntry()
            : const WindowsEntry(),
    );
  }
}
