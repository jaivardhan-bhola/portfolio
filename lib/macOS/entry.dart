import 'package:flutter/material.dart';
import 'package:portfolio/macOS/home.dart';
import 'package:portfolio/utils/image_utils.dart';


class MacEntry extends StatefulWidget {
  const MacEntry({super.key});

  @override
  State<MacEntry> createState() => _MacEntryState();
}

class _MacEntryState extends State<MacEntry> {
  bool _isVisible = true;
  bool _backgroundLoaded = false;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    // Start the fade out animation
    Future.delayed(const Duration(milliseconds: 0), () {
      setState(() {
        _isVisible = false;
      });
    });

    // Wait for background to load
    await ImageUtils.precacheImageSafe(
      const AssetImage('assets/mac/bg_optimized.jpg'), 
      context
    );
    setState(() {
      _backgroundLoaded = true;
    });

    // Small delay to ensure smooth transition
    await Future.delayed(const Duration(milliseconds: 300));
    
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MacHome()),
      );
    }
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/mac/logo.png',
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: MediaQuery.of(context).size.width * 0.15,
                ),
                if (!_backgroundLoaded) ...[
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white54,
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
