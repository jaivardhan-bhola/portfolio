import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:portfolio/ios/entry.dart';
import 'package:portfolio/macOS/entry.dart';
import 'package:portfolio/windows/entry.dart';

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
  bool get _isMobileBrowser {
    if (!kIsWeb) {
      return false;
    }
    return defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: defaultTargetPlatform == TargetPlatform.macOS
          ? const MacEntry()
          : _isMobileBrowser
              ? const IosEntry()
              : const WindowsEntry(),
    );
  }
}
