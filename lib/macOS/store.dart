import 'dart:convert';
import 'dart:html' as html;
import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/utils/image_utils.dart';

class MacStore extends StatefulWidget {
  final String active;
  final Function(dynamic newActive) onActiveChanged;

  const MacStore({
    super.key,
    required this.active,
    required this.onActiveChanged,
  });

  @override
  State<MacStore> createState() => _MacStoreState();
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
      title: (json['title'] ?? 'Untitled Project').toString(),
      subtitle: (json['description'] ?? json['subtitle'] ?? '').toString(),
      href: (json['href'] ?? json['url'] ?? '').toString(),
      icon: icon,
      cover: (json['cover'] ?? icon).toString(),
      category: (json['category'] ?? 'Projects').toString(),
      badge: (json['badge'] ?? '').toString(),
      featured: json['featured'] == true,
    );
  }
}

class _MacStoreState extends State<MacStore> {
  static const Color _bg = Color(0xFF111318);
  static const Color _surface = Color(0xFF1A1E26);
  static const Color _surfaceAlt = Color(0xFF202633);
  static const Color _stroke = Color(0xFF2C3445);
  static const Color _textPrimary = Color(0xFFF3F4F6);
  static const Color _textSecondary = Color(0xFF94A3B8);
  static const Color _accent = Color(0xFF0EA5E9);

  final List<_StoreProject> _projects = <_StoreProject>[];
  bool _isLoading = true;
  int _loadedImages = 0;
  int _totalImages = 0;

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
      _totalImages = parsed.length * 2;
      _loadedImages = 0;
    });

    final List<Future<void>> futures = <Future<void>>[];
    for (final _StoreProject project in parsed) {
      if (project.icon.isNotEmpty) {
        futures.add(_precacheImageWithProgress(AssetImage(project.icon)));
      }
      if (project.cover.isNotEmpty) {
        futures.add(_precacheImageWithProgress(AssetImage(project.cover)));
      }
    }

    await Future.wait(futures);
  }

  Future<void> _precacheImageWithProgress(AssetImage image) async {
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

  List<_StoreProject> get _featuredProjects {
    final List<_StoreProject> explicit =
        _projects.where((_StoreProject project) => project.featured).toList();
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
        borderRadius: BorderRadius.circular(screenHeight * 0.02),
        side: BorderSide(
          color: _stroke,
          width: screenHeight * 0.0015,
        ),
      ),
      child: SizedBox(
        height: screenHeight * 0.84,
        width: screenWidth * 0.82,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.015,
            vertical: screenHeight * 0.015,
          ),
          child: Column(
            children: [
              _buildWindowControls(screenHeight, screenWidth),
              if (_isLoading) const Spacer(),
              if (_isLoading) _buildLoadingState(screenHeight, screenWidth),
              if (!_isLoading)
                Expanded(
                  child: _projects.isEmpty
                      ? Center(
                          child: Text(
                            'No projects found',
                            style: GoogleFonts.nunitoSans(
                              color: _textPrimary,
                              fontSize: screenHeight * 0.024,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        )
                      : SingleChildScrollView(
                          padding: EdgeInsets.only(bottom: screenHeight * 0.03),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildStoreHeader(screenHeight, screenWidth),
                              SizedBox(height: screenHeight * 0.02),
                              _buildFeaturedShowcase(screenHeight, screenWidth),
                              SizedBox(height: screenHeight * 0.025),
                              _buildSectionTitle(
                                title: 'Curated Picks',
                                subtitle: 'Highlighted work from the catalog',
                                screenHeight: screenHeight,
                              ),
                              SizedBox(height: screenHeight * 0.014),
                              _buildHorizontalCards(screenHeight, screenWidth),
                              SizedBox(height: screenHeight * 0.025),
                              _buildSectionTitle(
                                title: 'All Apps',
                                subtitle:
                                    'Every project available in the store',
                                screenHeight: screenHeight,
                              ),
                              SizedBox(height: screenHeight * 0.014),
                              _buildGrid(screenHeight, screenWidth),
                            ],
                          ),
                        ),
                ),
              if (_isLoading) const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWindowControls(double screenHeight, double screenWidth) {
    return Padding(
      padding: EdgeInsets.only(
        left: screenWidth * 0.003,
        top: screenHeight * 0.004,
        bottom: screenHeight * 0.016,
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                widget.onActiveChanged('Finder');
                Navigator.pop(context);
              },
              child: CircleAvatar(
                backgroundColor: const Color(0xFFFF5F57),
                radius: screenHeight * 0.009,
              ),
            ),
            SizedBox(width: screenWidth * 0.005),
            CircleAvatar(
              backgroundColor: const Color(0xFFFEBB2E),
              radius: screenHeight * 0.009,
            ),
            SizedBox(width: screenWidth * 0.005),
            CircleAvatar(
              backgroundColor: const Color(0xFF28C840),
              radius: screenHeight * 0.009,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingState(double screenHeight, double screenWidth) {
    final double progress =
        _totalImages == 0 ? 0 : (_loadedImages / _totalImages).clamp(0.0, 1.0);

    return Column(
      children: [
        const CupertinoActivityIndicator(radius: 14),
        SizedBox(height: screenHeight * 0.01),
        Text(
          'Loading Store...',
          style: GoogleFonts.nunitoSans(
            color: _textPrimary,
            fontSize: screenHeight * 0.022,
            fontWeight: FontWeight.w700,
          ),
        ),
        if (_totalImages > 0) ...[
          SizedBox(height: screenHeight * 0.01),
          Container(
            width: screenWidth * 0.28,
            height: screenHeight * 0.008,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(999),
              color: _surfaceAlt,
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: progress,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(999),
                  gradient: const LinearGradient(
                    colors: <Color>[Color(0xFF38BDF8), Color(0xFF3B82F6)],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.006),
          Text(
            '$_loadedImages/$_totalImages images loaded',
            style: GoogleFonts.nunitoSans(
              color: _textSecondary,
              fontSize: screenHeight * 0.015,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildStoreHeader(double screenHeight, double screenWidth) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(screenHeight * 0.018),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(screenHeight * 0.018),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[Color(0xFF1A1E26), Color(0xFF202633)],
        ),
        border: Border.all(color: _stroke),
      ),
      child: Row(
        children: [
          Container(
            width: screenHeight * 0.075,
            height: screenHeight * 0.075,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(screenHeight * 0.02),
              gradient: const LinearGradient(
                colors: <Color>[Color(0xFF2563EB), Color(0xFF0EA5E9)],
              ),
            ),
            child: const Icon(CupertinoIcons.bag_fill, color: Colors.white),
          ),
          SizedBox(width: screenWidth * 0.012),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'App Store',
                  style: GoogleFonts.nunitoSans(
                    color: _textPrimary,
                    fontSize: screenHeight * 0.03,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  'Discover polished products and prototypes',
                  style: GoogleFonts.nunitoSans(
                    color: _textSecondary,
                    fontSize: screenHeight * 0.017,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.012,
              vertical: screenHeight * 0.012,
            ),
            decoration: BoxDecoration(
              color: _surfaceAlt,
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: _stroke),
            ),
            child: Row(
              children: [
                const Icon(CupertinoIcons.square_grid_2x2_fill,
                    color: Color(0xFF94A3B8), size: 16),
                SizedBox(width: screenWidth * 0.004),
                Text(
                  '${_projects.length} apps',
                  style: GoogleFonts.nunitoSans(
                    color: _textPrimary,
                    fontSize: screenHeight * 0.015,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedShowcase(double screenHeight, double screenWidth) {
    final List<_StoreProject> featured = _featuredProjects;
    if (featured.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      height: screenHeight * 0.42,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(screenHeight * 0.02),
        border: Border.all(color: _stroke),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(screenHeight * 0.02),
        child: ImageSlideshow(
          autoPlayInterval: 4500,
          isLoop: true,
          indicatorColor: Colors.white,
          indicatorBackgroundColor: Colors.white.withOpacity(0.4),
          children: featured
              .map((project) =>
                  _buildHeroSlide(project, screenHeight, screenWidth))
              .toList(),
        ),
      ),
    );
  }

  Widget _buildHeroSlide(
    _StoreProject project,
    double screenHeight,
    double screenWidth,
  ) {
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
                Colors.black.withOpacity(0.78),
                Colors.black.withOpacity(0.24),
                Colors.transparent,
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(screenHeight * 0.022),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.008,
                  vertical: screenHeight * 0.005,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.22),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  project.category.toUpperCase(),
                  style: GoogleFonts.nunitoSans(
                    color: Colors.white,
                    fontSize: screenHeight * 0.013,
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Text(
                project.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.nunitoSans(
                  color: Colors.white,
                  fontSize: screenHeight * 0.038,
                  height: 1.1,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: screenHeight * 0.006),
              Text(
                project.subtitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.nunitoSans(
                  color: Colors.white.withOpacity(0.92),
                  fontSize: screenHeight * 0.02,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: screenHeight * 0.015),
              ElevatedButton(
                onPressed: () => _openProject(project),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _accent,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.012,
                    vertical: screenHeight * 0.011,
                  ),
                ),
                child: Text(
                  'View',
                  style: GoogleFonts.nunitoSans(
                    fontSize: screenHeight * 0.017,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle({
    required String title,
    required String subtitle,
    required double screenHeight,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.nunitoSans(
            color: _textPrimary,
            fontSize: screenHeight * 0.03,
            fontWeight: FontWeight.w900,
          ),
        ),
        Text(
          subtitle,
          style: GoogleFonts.nunitoSans(
            color: _textSecondary,
            fontSize: screenHeight * 0.016,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildHorizontalCards(double screenHeight, double screenWidth) {
    return SizedBox(
      height: screenHeight * 0.26,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _projects.length,
        separatorBuilder: (_, __) => SizedBox(width: screenWidth * 0.01),
        itemBuilder: (BuildContext context, int index) {
          final _StoreProject project = _projects[index];
          return Container(
            width: screenWidth * 0.26,
            padding: EdgeInsets.all(screenHeight * 0.014),
            decoration: BoxDecoration(
              color: _surface,
              borderRadius: BorderRadius.circular(screenHeight * 0.016),
              border: Border.all(color: _stroke),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.35),
                  blurRadius: 14,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(screenHeight * 0.012),
                      child: Image(
                        image: AssetImage(project.icon),
                        width: screenHeight * 0.06,
                        height: screenHeight * 0.06,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.006),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            project.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.nunitoSans(
                              color: _textPrimary,
                              fontSize: screenHeight * 0.018,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Text(
                            project.category,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.nunitoSans(
                              color: _textSecondary,
                              fontSize: screenHeight * 0.014,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.012),
                Text(
                  project.subtitle,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.nunitoSans(
                    color: _textSecondary,
                    fontSize: screenHeight * 0.015,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    if (project.badge.isNotEmpty)
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.006,
                          vertical: screenHeight * 0.004,
                        ),
                        decoration: BoxDecoration(
                          color: _surfaceAlt,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          project.badge,
                          style: GoogleFonts.nunitoSans(
                            color: const Color(0xFF38BDF8),
                            fontSize: screenHeight * 0.012,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    const Spacer(),
                    TextButton(
                      onPressed: () => _openProject(project),
                      style: TextButton.styleFrom(
                        backgroundColor: _surfaceAlt,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(999),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.008,
                          vertical: screenHeight * 0.008,
                        ),
                      ),
                      child: Text(
                        'Open',
                        style: GoogleFonts.nunitoSans(
                          color: _textPrimary,
                          fontSize: screenHeight * 0.014,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildGrid(double screenHeight, double screenWidth) {
    final int crossAxisCount = screenWidth > 1700
        ? 4
        : screenWidth > 1300
            ? 3
            : 2;

    return GridView.builder(
      shrinkWrap: true,
      itemCount: _projects.length,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: screenHeight * 0.012,
        mainAxisSpacing: screenHeight * 0.012,
        childAspectRatio: 2.2,
      ),
      itemBuilder: (BuildContext context, int index) {
        final _StoreProject project = _projects[index];
        return Container(
          padding: EdgeInsets.all(screenHeight * 0.012),
          decoration: BoxDecoration(
            color: _surface,
            borderRadius: BorderRadius.circular(screenHeight * 0.014),
            border: Border.all(color: _stroke),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(screenHeight * 0.012),
                child: Image(
                  image: AssetImage(project.icon),
                  width: screenHeight * 0.072,
                  height: screenHeight * 0.072,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: screenWidth * 0.008),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      project.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.nunitoSans(
                        color: _textPrimary,
                        fontSize: screenHeight * 0.018,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.004),
                    Text(
                      project.subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.nunitoSans(
                        color: _textSecondary,
                        fontSize: screenHeight * 0.014,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: screenWidth * 0.006),
              ElevatedButton(
                onPressed: () => _openProject(project),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _accent,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.007,
                    vertical: screenHeight * 0.009,
                  ),
                ),
                child: Text(
                  'Get',
                  style: GoogleFonts.nunitoSans(
                    fontSize: screenHeight * 0.014,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
