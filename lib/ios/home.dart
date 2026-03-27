import 'dart:html' as html;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/ios/store.dart';

class IosHome extends StatefulWidget {
  const IosHome({super.key});

  @override
  State<IosHome> createState() => _IosHomeState();
}

class _IosHomeState extends State<IosHome> {
  bool _fullscreen = false;

  static const List<_HomeIcon> _topIcons = <_HomeIcon>[
    _HomeIcon(
      title: 'Calendar',
      badgeText: '28',
      background: Color(0xFFF2F2F7),
      labelColor: Color(0xFF1C1C1E),
    ),
    _HomeIcon(
      title: 'Projects',
      asset: 'assets/mac/store.png',
      background: Color(0xFFFFFFFF),
      opensStore: true,
    ),
    _HomeIcon(
      title: 'GitHub',
      asset: 'assets/icons/github.png',
      link: 'https://github.com/jaivardhan-bhola',
    ),
    _HomeIcon(
      title: 'LinkedIn',
      asset: 'assets/icons/linkedin.png',
      link: 'https://www.linkedin.com/in/jaivardhan-bhola/',
    ),
    _HomeIcon(
      title: 'Resume',
      asset: 'assets/icons/acrobat.png',
      link:
          'https://drive.google.com/file/d/18rltwqG_Tm2paUyemvSNF4HRClGZoYQO/view?usp=sharing',
    ),
    _HomeIcon(
      title: 'Mail',
      systemIcon: CupertinoIcons.mail_solid,
      iconColor: Colors.white,
      background: Color(0xFF0A84FF),
      link: 'mailto:jaivardhan.bhola@gmail.com',
    ),
    _HomeIcon(
      title: 'Fullscreen',
      systemIcon: CupertinoIcons.fullscreen,
      iconColor: Colors.white,
      background: Color(0xFF636366),
      togglesFullscreen: true,
    ),
  ];

  static const List<_HomeIcon> _dockIcons = <_HomeIcon>[
    _HomeIcon(
      title: 'Projects',
      asset: 'assets/mac/store.png',
      background: Color(0xFFFFFFFF),
      opensStore: true,
    ),
    _HomeIcon(
      title: 'GitHub',
      asset: 'assets/icons/github.png',
      link: 'https://github.com/jaivardhan-bhola',
    ),
    _HomeIcon(
      title: 'LinkedIn',
      asset: 'assets/icons/linkedin.png',
      link: 'https://www.linkedin.com/in/jaivardhan-bhola/',
    ),
    _HomeIcon(
      title: 'Resume',
      asset: 'assets/icons/acrobat.png',
      link:
          'https://drive.google.com/file/d/18rltwqG_Tm2paUyemvSNF4HRClGZoYQO/view?usp=sharing',
    ),
  ];

  void _open(String url) {
    html.window.open(url, 'new tab');
  }

  void _toggleFullscreen() {
    setState(() {
      _fullscreen = !_fullscreen;
    });

    if (_fullscreen) {
      html.document.documentElement?.requestFullscreen();
    } else {
      html.document.exitFullscreen();
    }
  }

  void _openStore() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return const IosStore();
      },
    );
  }

  void _onIconTap(_HomeIcon icon) {
    if (icon.opensStore) {
      _openStore();
      return;
    }
    if (icon.togglesFullscreen) {
      _toggleFullscreen();
      return;
    }
    if (icon.link != null) {
      _open(icon.link!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/mac/bg_ios.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.06,
                  vertical: screenHeight * 0.008,
                ),
                child: Row(
                  children: <Widget>[
                    Text(
                      '9:41',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenHeight * 0.022,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      CupertinoIcons.antenna_radiowaves_left_right,
                      color: Colors.white,
                      size: screenHeight * 0.018,
                    ),
                    SizedBox(width: screenWidth * 0.012),
                    Icon(
                      CupertinoIcons.wifi,
                      color: Colors.white,
                      size: screenHeight * 0.018,
                    ),
                    SizedBox(width: screenWidth * 0.012),
                    Icon(
                      CupertinoIcons.battery_100,
                      color: Colors.white,
                      size: screenHeight * 0.02,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Home',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.92),
                      fontSize: screenHeight * 0.03,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.018),
              Expanded(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: screenWidth * 0.055),
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _topIcons.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: screenHeight * 0.02,
                      crossAxisSpacing: screenWidth * 0.03,
                      childAspectRatio: 0.74,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      final _HomeIcon icon = _topIcons[index];
                      return _buildIcon(icon, screenHeight, screenWidth);
                    },
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buildPageDot(active: true),
                  SizedBox(width: screenWidth * 0.015),
                  _buildPageDot(active: false),
                ],
              ),
              SizedBox(height: screenHeight * 0.014),
              Container(
                margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.035,
                  vertical: screenHeight * 0.013,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.24),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.white30),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: _dockIcons
                      .map((_HomeIcon icon) => SizedBox(
                            width: screenWidth * 0.16,
                            child: _buildIcon(icon, screenHeight, screenWidth,
                                inDock: true),
                          ))
                      .toList(),
                ),
              ),
              SizedBox(height: screenHeight * 0.014),
              Container(
                width: screenWidth * 0.32,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(
    _HomeIcon icon,
    double screenHeight,
    double screenWidth, {
    bool inDock = false,
  }) {
    final double iconSize = inDock ? screenWidth * 0.13 : screenWidth * 0.15;
    final BorderRadius squircleRadius = BorderRadius.circular(iconSize * 0.26);

    return GestureDetector(
      onTap: () => _onIconTap(icon),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: iconSize,
            height: iconSize,
            decoration: BoxDecoration(
              color: icon.background,
              borderRadius: squircleRadius,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black.withOpacity(0.22),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: icon.badgeText != null
                ? Center(
                    child: Text(
                      icon.badgeText!,
                      style: TextStyle(
                        color: icon.labelColor,
                        fontSize: screenHeight * 0.03,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  )
                : icon.asset != null
                    ? Image.asset(icon.asset!, fit: BoxFit.cover)
                    : Icon(
                        icon.systemIcon ?? CupertinoIcons.square_grid_2x2_fill,
                        color: icon.iconColor,
                        size: iconSize * 0.52,
                      ),
          ),
          if (!inDock) ...<Widget>[
            SizedBox(height: screenHeight * 0.006),
            Text(
              icon.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
                fontSize: screenHeight * 0.015,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPageDot({required bool active}) {
    return Container(
      width: active ? 8 : 6,
      height: active ? 8 : 6,
      decoration: BoxDecoration(
        color: active ? Colors.white : Colors.white60,
        shape: BoxShape.circle,
      ),
    );
  }
}

class _HomeIcon {
  final String title;
  final String? asset;
  final IconData? systemIcon;
  final Color background;
  final Color iconColor;
  final String? link;
  final bool opensStore;
  final bool togglesFullscreen;
  final String? badgeText;
  final Color labelColor;

  const _HomeIcon({
    required this.title,
    this.asset,
    this.systemIcon,
    this.background = const Color(0xFF1C1C1E),
    this.iconColor = Colors.white,
    this.link,
    this.opensStore = false,
    this.togglesFullscreen = false,
    this.badgeText,
    this.labelColor = Colors.white,
  });
}
