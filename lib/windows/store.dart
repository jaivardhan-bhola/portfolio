import 'dart:convert';
import 'dart:html' as html;
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:portfolio/utils/image_utils.dart';

class WindowsStore extends StatefulWidget {
  const WindowsStore({super.key});

  @override
  State<WindowsStore> createState() => _WindowsStoreState();
}

class _StoreProject {
  final String title;
  final String subtitle;
  final String href;
  final String icon;
  final String cover;
  final String category;
  final String badge;
  final bool featured;

  const _StoreProject({
    required this.title,
    required this.subtitle,
    required this.href,
    required this.icon,
    required this.cover,
    required this.category,
    required this.badge,
    required this.featured,
  });

  factory _StoreProject.fromJson(Map<String, dynamic> json) {
    final String icon = (json['img'] ?? json['icon'] ?? '').toString();
    return _StoreProject(
      title: (json['title'] ?? 'Untitled App').toString(),
      subtitle: (json['description'] ?? json['subtitle'] ?? '').toString(),
      href: (json['href'] ?? json['url'] ?? '').toString(),
      icon: icon,
      cover: (json['cover'] ?? icon).toString(),
      category: (json['category'] ?? 'Apps').toString(),
      badge: (json['badge'] ?? '').toString(),
      featured: json['featured'] == true,
    );
  }
}

class _WindowsStoreState extends State<WindowsStore> {
  static const Color _bg = Color(0xFF0F1115);
  static const Color _surface = Color(0xFF181B22);
  static const Color _surfaceAlt = Color(0xFF212733);
  static const Color _stroke = Color(0xFF2A3242);
  static const Color _textPrimary = Color(0xFFF3F6FA);
  static const Color _textSecondary = Color(0xFF98A4B8);
  static const Color _accent = Color(0xFF60A5FA);

  final List<_StoreProject> _projects = <_StoreProject>[];
  bool _isLoading = true;
  int _loadedImages = 0;
  int _totalImages = 0;

  TextStyle _style(
    double size,
    FontWeight weight,
    Color color,
  ) {
    return TextStyle(
      fontSize: size,
      fontWeight: weight,
      color: color,
      fontFamily: 'Segoe UI',
    );
  }

  Future<void> _loadProjects() async {
    final String response =
        await rootBundle.loadString('assets/data/projects.json');
    final List<dynamic> decoded = json.decode(response) as List<dynamic>;

    final List<_StoreProject> parsed = decoded
        .whereType<Map<String, dynamic>>()
        .map(_StoreProject.fromJson)
        .toList();

    setState(() {
      _projects
        ..clear()
        ..addAll(parsed);
      _loadedImages = 0;
      _totalImages = parsed.length * 2;
    });

    final List<Future<void>> preload = <Future<void>>[];
    for (final _StoreProject project in parsed) {
      if (project.icon.isNotEmpty) {
        preload.add(_precacheImage(AssetImage(project.icon)));
      }
      if (project.cover.isNotEmpty) {
        preload.add(_precacheImage(AssetImage(project.cover)));
      }
    }
    await Future.wait(preload);
  }

  Future<void> _precacheImage(AssetImage image) async {
    await ImageUtils.precacheImageSafe(image, context);
    if (!mounted) {
      return;
    }
    setState(() {
      _loadedImages++;
    });
  }

  @override
  void initState() {
    super.initState();
    _startLoading();
  }

  Future<void> _startLoading() async {
    await _loadProjects();
    if (!mounted) {
      return;
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _openProject(_StoreProject project) {
    if (project.href.trim().isEmpty) {
      return;
    }
    html.window.open(project.href, 'new tab');
  }

  List<_StoreProject> get _featured {
    final List<_StoreProject> explicit =
        _projects.where((_StoreProject item) => item.featured).toList();
    if (explicit.isNotEmpty) {
      return explicit;
    }
    return _projects.take(math.min(4, _projects.length)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Dialog(
      backgroundColor: _bg,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(screenHeight * 0.012),
        side: BorderSide(color: _stroke, width: 1.2),
      ),
      child: SizedBox(
        height: screenHeight * 0.84,
        width: screenWidth * 0.84,
        child: Padding(
          padding: EdgeInsets.all(screenHeight * 0.014),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(screenHeight, screenWidth),
              SizedBox(height: screenHeight * 0.012),
              if (_isLoading) const Spacer(),
              if (_isLoading) _buildLoading(screenHeight, screenWidth),
              if (_isLoading) const Spacer(),
              if (!_isLoading)
                Expanded(
                  child: _projects.isEmpty
                      ? Center(
                          child: Text(
                            'No apps available',
                            style: _style(
                              screenHeight * 0.025,
                              FontWeight.w700,
                              _textPrimary,
                            ),
                          ),
                        )
                      : SingleChildScrollView(
                          padding:
                              EdgeInsets.only(bottom: screenHeight * 0.022),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildTabs(screenHeight, screenWidth),
                              SizedBox(height: screenHeight * 0.015),
                              _buildHero(screenHeight, screenWidth),
                              SizedBox(height: screenHeight * 0.022),
                              Text(
                                'Top free apps',
                                style: _style(
                                  screenHeight * 0.03,
                                  FontWeight.w700,
                                  _textPrimary,
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.01),
                              _buildTopFreeStrip(screenHeight, screenWidth),
                              SizedBox(height: screenHeight * 0.022),
                              Text(
                                'All apps',
                                style: _style(
                                  screenHeight * 0.03,
                                  FontWeight.w700,
                                  _textPrimary,
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.01),
                              _buildAppGrid(screenHeight, screenWidth),
                            ],
                          ),
                        ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(double screenHeight, double screenWidth) {
    return Row(
      children: [
        Image(
          image: const AssetImage('assets/windows/store.png'),
          height: screenHeight * 0.04,
        ),
        SizedBox(width: screenWidth * 0.006),
        Text(
          'Microsoft Store',
          style: _style(screenHeight * 0.026, FontWeight.w700, _textPrimary),
        ),
        SizedBox(width: screenWidth * 0.012),
        Expanded(
          child: Container(
            height: screenHeight * 0.048,
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
            decoration: BoxDecoration(
              color: _surface,
              borderRadius: BorderRadius.circular(screenHeight * 0.006),
              border: Border.all(color: _stroke),
            ),
            child: Row(
              children: [
                const Icon(Icons.search_rounded,
                    color: Color(0xFF8EA0BC), size: 18),
                SizedBox(width: screenWidth * 0.005),
                Text(
                  'Search apps, games, movies and more',
                  style: _style(
                    screenHeight * 0.015,
                    FontWeight.w500,
                    _textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: screenWidth * 0.01),
        IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            Icons.close,
            color: _textSecondary,
            size: screenHeight * 0.028,
          ),
          tooltip: 'Close',
        ),
      ],
    );
  }

  Widget _buildTabs(double screenHeight, double screenWidth) {
    final List<String> tabs = <String>['Home', 'Apps', 'Gaming', 'Library'];
    return Wrap(
      spacing: screenWidth * 0.012,
      runSpacing: screenHeight * 0.006,
      children: tabs.map((String tab) {
        final bool isActive = tab == 'Apps';
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.01,
            vertical: screenHeight * 0.007,
          ),
          decoration: BoxDecoration(
            color: isActive ? _surfaceAlt : _surface,
            borderRadius: BorderRadius.circular(screenHeight * 0.006),
            border: Border.all(color: isActive ? _accent : _stroke),
          ),
          child: Text(
            tab,
            style: _style(
              screenHeight * 0.016,
              isActive ? FontWeight.w700 : FontWeight.w600,
              isActive ? _textPrimary : _textSecondary,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildHero(double screenHeight, double screenWidth) {
    if (_featured.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      height: screenHeight * 0.4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(screenHeight * 0.01),
        border: Border.all(color: _stroke),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(screenHeight * 0.01),
        child: ImageSlideshow(
          autoPlayInterval: 4500,
          isLoop: true,
          indicatorColor: Colors.white,
          indicatorBackgroundColor: Colors.white.withOpacity(0.35),
          children: _featured.map((_StoreProject project) {
            return Stack(
              fit: StackFit.expand,
              children: [
                Image(
                  image: AssetImage(project.cover),
                  fit: BoxFit.cover,
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: <Color>[
                        Colors.black.withOpacity(0.82),
                        Colors.black.withOpacity(0.2),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(screenHeight * 0.02),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.008,
                          vertical: screenHeight * 0.004,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.18),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          project.category.toUpperCase(),
                          style: _style(
                            screenHeight * 0.012,
                            FontWeight.w700,
                            Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.008),
                      Text(
                        project.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: _style(
                          screenHeight * 0.04,
                          FontWeight.w800,
                          Colors.white,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.004),
                      Text(
                        project.subtitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: _style(
                          screenHeight * 0.02,
                          FontWeight.w600,
                          Colors.white.withOpacity(0.9),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.012),
                      ElevatedButton(
                        onPressed: () => _openProject(project),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _accent,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(screenHeight * 0.005),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.01,
                            vertical: screenHeight * 0.01,
                          ),
                        ),
                        child: Text(
                          'Get',
                          style: _style(
                            screenHeight * 0.016,
                            FontWeight.w700,
                            Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildTopFreeStrip(double screenHeight, double screenWidth) {
    return SizedBox(
      height: screenHeight * 0.2,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _projects.length,
        separatorBuilder: (_, __) => SizedBox(width: screenWidth * 0.009),
        itemBuilder: (BuildContext context, int index) {
          final _StoreProject project = _projects[index];
          return Container(
            width: screenWidth * 0.26,
            decoration: BoxDecoration(
              color: _surface,
              borderRadius: BorderRadius.circular(screenHeight * 0.008),
              border: Border.all(color: _stroke),
            ),
            padding: EdgeInsets.all(screenHeight * 0.012),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(screenHeight * 0.007),
                  child: Image(
                    image: AssetImage(project.icon),
                    width: screenHeight * 0.06,
                    height: screenHeight * 0.06,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: screenWidth * 0.007),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        project.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: _style(
                          screenHeight * 0.017,
                          FontWeight.w700,
                          _textPrimary,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.003),
                      Text(
                        project.category,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: _style(
                          screenHeight * 0.013,
                          FontWeight.w600,
                          _textSecondary,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.007),
                      TextButton(
                        onPressed: () => _openProject(project),
                        style: TextButton.styleFrom(
                          backgroundColor: _surfaceAlt,
                          foregroundColor: _textPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(screenHeight * 0.004),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.006,
                            vertical: screenHeight * 0.007,
                          ),
                        ),
                        child: Text(
                          'Install',
                          style: _style(
                            screenHeight * 0.013,
                            FontWeight.w700,
                            _textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildAppGrid(double screenHeight, double screenWidth) {
    final int columns = screenWidth > 1800
        ? 4
        : screenWidth > 1300
            ? 3
            : 2;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _projects.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        crossAxisSpacing: screenHeight * 0.012,
        mainAxisSpacing: screenHeight * 0.012,
        childAspectRatio: 2.45,
      ),
      itemBuilder: (BuildContext context, int index) {
        final _StoreProject project = _projects[index];
        return Container(
          decoration: BoxDecoration(
            color: _surface,
            borderRadius: BorderRadius.circular(screenHeight * 0.008),
            border: Border.all(color: _stroke),
          ),
          padding: EdgeInsets.all(screenHeight * 0.011),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(screenHeight * 0.007),
                child: Image(
                  image: AssetImage(project.icon),
                  width: screenHeight * 0.065,
                  height: screenHeight * 0.065,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: screenWidth * 0.006),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      project.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: _style(
                        screenHeight * 0.017,
                        FontWeight.w700,
                        _textPrimary,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.003),
                    Text(
                      project.subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: _style(
                        screenHeight * 0.013,
                        FontWeight.w500,
                        _textSecondary,
                      ),
                    ),
                    if (project.badge.isNotEmpty) ...[
                      SizedBox(height: screenHeight * 0.005),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.004,
                          vertical: screenHeight * 0.003,
                        ),
                        decoration: BoxDecoration(
                          color: _surfaceAlt,
                          borderRadius: BorderRadius.circular(3),
                          border: Border.all(color: _stroke),
                        ),
                        child: Text(
                          project.badge,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: _style(
                            screenHeight * 0.011,
                            FontWeight.w700,
                            const Color(0xFF93C5FD),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              SizedBox(width: screenWidth * 0.005),
              FilledButton(
                onPressed: () => _openProject(project),
                style: FilledButton.styleFrom(
                  backgroundColor: _accent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(screenHeight * 0.004),
                  ),
                ),
                child: Text(
                  'Get',
                  style: _style(
                    screenHeight * 0.013,
                    FontWeight.w700,
                    Colors.white,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLoading(double screenHeight, double screenWidth) {
    final double progress =
        _totalImages == 0 ? 0 : (_loadedImages / _totalImages).clamp(0.0, 1.0);

    return Column(
      children: [
        Image(
          image: const AssetImage('assets/windows/store.png'),
          height: screenHeight * 0.09,
        ),
        SizedBox(height: screenHeight * 0.02),
        Text(
          'Loading Microsoft Store',
          style: _style(screenHeight * 0.024, FontWeight.w700, _textPrimary),
        ),
        SizedBox(height: screenHeight * 0.014),
        Container(
          width: screenWidth * 0.34,
          height: screenHeight * 0.008,
          decoration: BoxDecoration(
            color: _surface,
            borderRadius: BorderRadius.circular(999),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: progress,
            child: Container(
              decoration: BoxDecoration(
                color: _accent,
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          ),
        ),
        SizedBox(height: screenHeight * 0.008),
        Text(
          '$_loadedImages/$_totalImages assets loaded',
          style: _style(screenHeight * 0.014, FontWeight.w600, _textSecondary),
        ),
      ],
    );
  }
}
