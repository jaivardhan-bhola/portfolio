import 'package:flutter/material.dart';
import 'package:portfolio/macOS/home.dart';


class MacEntry extends StatefulWidget {
  const MacEntry({super.key});

  @override
  State<MacEntry> createState() => _MacEntryState();
}

class _MacEntryState extends State<MacEntry> {
  bool _isVisible = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 0), () {
      setState(() {
        _isVisible = false;
      });
      precacheImage(const AssetImage('assets/mac/bg.png'), context);
      Future.delayed(const Duration(milliseconds: 500), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MacHome()),
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
              'assets/mac/logo.png',
              height: MediaQuery.of(context).size.height * 0.15,
              width: MediaQuery.of(context).size.width * 0.15,
            ),
          ),
        ),
      ),
    );
  }
}
