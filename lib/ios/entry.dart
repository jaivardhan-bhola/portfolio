import 'package:flutter/material.dart';
import 'package:portfolio/ios/home.dart';
import 'package:portfolio/utils/image_utils.dart';

class IosEntry extends StatefulWidget {
  const IosEntry({super.key});

  @override
  State<IosEntry> createState() => _IosEntryState();
}

class _IosEntryState extends State<IosEntry> {
  bool _isVisible = true;
  bool _backgroundLoaded = false;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    Future.delayed(const Duration(milliseconds: 0), () {
      if (!mounted) {
        return;
      }
      setState(() {
        _isVisible = false;
      });
    });

    await ImageUtils.precacheImageSafe(
      const AssetImage('assets/mac/bg_optimized.jpg'),
      context,
    );

    if (!mounted) {
      return;
    }

    setState(() {
      _backgroundLoaded = true;
    });

    await Future.delayed(const Duration(milliseconds: 320));

    if (!mounted) {
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute<void>(
          builder: (BuildContext context) => const IosHome()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      color: Colors.black,
      child: AnimatedOpacity(
        opacity: _isVisible ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 500),
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/mac/logo.png',
                  width: screenWidth * 0.32,
                  height: screenWidth * 0.32,
                ),
                if (!_backgroundLoaded) ...<Widget>[
                  SizedBox(height: screenHeight * 0.03),
                  const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.2,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
