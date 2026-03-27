import 'dart:convert';
import 'dart:html' as html;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class IosStore extends StatefulWidget {
  const IosStore({super.key});

  @override
  State<IosStore> createState() => _IosStoreState();
}

class _StoreProject {
  final String title;
  final String subtitle;
  final String href;
  final String icon;

  const _StoreProject({
    required this.title,
    required this.subtitle,
    required this.href,
    required this.icon,
  });

  factory _StoreProject.fromJson(Map<String, dynamic> json) {
    return _StoreProject(
      title: (json['title'] ?? 'Untitled Project').toString(),
      subtitle: (json['description'] ?? '').toString(),
      href: (json['href'] ?? '').toString(),
      icon: (json['img'] ?? json['icon'] ?? '').toString(),
    );
  }
}

class _IosStoreState extends State<IosStore> {
  final List<_StoreProject> _projects = <_StoreProject>[];
  bool _isLoading = true;

  static const Color _surface = Color(0xFF0F1116);
  static const Color _card = Color(0xFF171A22);
  static const Color _title = Color(0xFFF6F7FA);
  static const Color _subtitle = Color(0xFFA0A9B8);
  static const Color _stroke = Color(0xFF2A3140);
  static const Color _accent = Color(0xFF0A84FF);

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final String response =
        await rootBundle.loadString('assets/data/projects.json');
    final List<dynamic> decoded = json.decode(response) as List<dynamic>;
    final List<_StoreProject> parsed = decoded
        .whereType<Map<String, dynamic>>()
        .map(_StoreProject.fromJson)
        .toList();

    if (!mounted) {
      return;
    }

    setState(() {
      _projects
        ..clear()
        ..addAll(parsed);
      _isLoading = false;
    });
  }

  void _openProject(String href) {
    if (href.trim().isEmpty) {
      return;
    }
    html.window.open(href, 'new tab');
  }

  List<_StoreProject> get _featured {
    return _projects.take(3).toList();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final _StoreProject? hero = _projects.isEmpty ? null : _projects.first;

    return Container(
      height: screenHeight * 0.9,
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                top: screenHeight * 0.012,
                left: screenWidth * 0.05,
                right: screenWidth * 0.05,
              ),
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: screenWidth * 0.14,
                      height: 5,
                      decoration: BoxDecoration(
                        color: const Color(0xFF4A5262),
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.018),
                  Row(
                    children: <Widget>[
                      Text(
                        'App Store',
                        style: TextStyle(
                          color: _title,
                          fontSize: screenHeight * 0.038,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.4,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(CupertinoIcons.xmark_circle_fill,
                            color: Color(0xFF8B94A3)),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.002),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Discover the latest work',
                      style: TextStyle(
                        color: _subtitle,
                        fontSize: screenHeight * 0.019,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.012),
            Expanded(
              child: _isLoading
                  ? Center(
                      child: CupertinoActivityIndicator(
                        radius: screenHeight * 0.015,
                        color: _accent,
                      ),
                    )
                  : ListView(
                      padding: EdgeInsets.only(
                        left: screenWidth * 0.05,
                        right: screenWidth * 0.05,
                        bottom: screenHeight * 0.025,
                      ),
                      children: <Widget>[
                        if (hero != null)
                          _buildHeroCard(
                            hero,
                            screenHeight,
                            screenWidth,
                          ),
                        SizedBox(height: screenHeight * 0.024),
                        _buildSectionHeader(
                          'Top Picks',
                          'Editor\'s choice',
                          screenHeight,
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        ..._featured.map(
                          (_StoreProject project) => _buildAppRow(
                            project,
                            screenHeight,
                            screenWidth,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.018),
                        _buildSectionHeader(
                          'All Projects',
                          'Everything in your portfolio store',
                          screenHeight,
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        ..._projects.map(
                          (_StoreProject project) => _buildAppRow(
                            project,
                            screenHeight,
                            screenWidth,
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroCard(
    _StoreProject project,
    double screenHeight,
    double screenWidth,
  ) {
    return GestureDetector(
      onTap: () => _openProject(project.href),
      child: Container(
        height: screenHeight * 0.265,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          image: DecorationImage(
            image: AssetImage(
              project.icon.isEmpty
                  ? 'assets/mac/bg_optimized.jpg'
                  : project.icon,
            ),
            fit: BoxFit.cover,
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(screenWidth * 0.05),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: <Color>[
                Colors.black.withOpacity(0.58),
                Colors.black.withOpacity(0.08),
              ],
            ),
          ),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'FEATURED',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: screenHeight * 0.014,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: screenHeight * 0.004),
                Text(
                  project.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenHeight * 0.036,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.5,
                  ),
                ),
                SizedBox(height: screenHeight * 0.004),
                Text(
                  project.subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.92),
                    fontSize: screenHeight * 0.018,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(
    String title,
    String subtitle,
    double screenHeight,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            color: _title,
            fontSize: screenHeight * 0.032,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.4,
          ),
        ),
        Text(
          subtitle,
          style: TextStyle(
            color: _subtitle,
            fontSize: screenHeight * 0.017,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildAppRow(
    _StoreProject project,
    double screenHeight,
    double screenWidth,
  ) {
    return GestureDetector(
      onTap: () => _openProject(project.href),
      child: Container(
        margin: EdgeInsets.only(bottom: screenHeight * 0.012),
        padding: EdgeInsets.all(screenHeight * 0.011),
        decoration: BoxDecoration(
          color: _card,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: _stroke),
        ),
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                project.icon.isEmpty ? 'assets/mac/logo.png' : project.icon,
                width: screenHeight * 0.078,
                height: screenHeight * 0.078,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: screenWidth * 0.03),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    project.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: _title,
                      fontSize: screenHeight * 0.021,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.2,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.003),
                  Text(
                    project.subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: _subtitle,
                      fontSize: screenHeight * 0.016,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: screenWidth * 0.02),
            Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.04,
                    vertical: screenHeight * 0.008,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF23344F),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    'GET',
                    style: TextStyle(
                      color: _accent,
                      fontSize: screenHeight * 0.015,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.004),
                Text(
                  'Portfolio',
                  style: TextStyle(
                    color: _subtitle,
                    fontSize: screenHeight * 0.012,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
