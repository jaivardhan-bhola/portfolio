import 'package:flutter/material.dart';
import 'package:portfolio/windows/home.dart';

class WindowsEntry extends StatefulWidget {
  const WindowsEntry({super.key});

  @override
  State<WindowsEntry> createState() => _WindowsEntryState();
}

class _WindowsEntryState extends State<WindowsEntry> {
  bool _isVisible = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 0), () {
      setState(() {
        _isVisible = false;
      });
      precacheImage(const AssetImage('assets/windows/bg.jpg'), context);
      Future.delayed(const Duration(milliseconds: 500), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const WindowsHome()),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: AnimatedOpacity(
        opacity: _isVisible ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 500),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.black,
          child: Center(
            child: Image.asset(
              'assets/windows/logo.png',
              height: MediaQuery.of(context).size.height * 0.15,
              width: MediaQuery.of(context).size.width * 0.15,
            ),
          ),
        ),
      ),
    );
  }
}
