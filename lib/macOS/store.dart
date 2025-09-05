import 'dart:async';
import 'dart:html' as html;
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/utils/image_utils.dart';

class MacStore extends StatefulWidget {
  final String active;
  final Function(dynamic newActive) onActiveChanged;
  const MacStore({super.key, required this.active, required this.onActiveChanged});

  @override
  State<MacStore> createState() => _MacStoreState();
}

class _MacStoreState extends State<MacStore> {
  List<dynamic> _projects = [];
  bool _isLoading = true;
  int _loadedImages = 0;
  int _totalImages = 0;

  Future<void> _loadProjects() async {
    final String response =
        await rootBundle.loadString('assets/data/projects.json');
    final data = await json.decode(response);
    setState(() {
      _projects = data;
      _totalImages = data.length * 2; // Each project has img and cover
    });
    
    // Load images in parallel with progress tracking
    final List<Future<void>> futures = [];
    for (var i = 0; i < data.length; i++) {
      futures.add(_precacheImageWithProgress(AssetImage(data[i]['img'])));
      futures.add(_precacheImageWithProgress(AssetImage(data[i]['cover'])));
    }
    
    await Future.wait(futures);
  }

  Future<void> _precacheImageWithProgress(AssetImage image) async {
    await ImageUtils.precacheImageSafe(image, context);
    setState(() {
      _loadedImages++;
    });
  }

  @override
  void initState() {
    super.initState();
    _startLoading();
  }

  void _startLoading() async {
    await Future.wait([
      _loadProjects(),
    ]);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double Screenwidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Dialog(
      backgroundColor: Colors.grey[900],
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(screenHeight * 0.02),
          side: BorderSide(color: Colors.white12, width: screenHeight * 0.002)),
      child: Builder(builder: (context) {
        return SizedBox(
          height: screenHeight * 0.8,
          width: Screenwidth * 0.8,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        widget.onActiveChanged('Finder');
                        Navigator.pop(context);
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.redAccent,
                        radius: screenHeight * 0.01,
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: Screenwidth * 0.005,
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.grey[600],
                          radius: screenHeight * 0.01,
                        ),
                        SizedBox(
                          width: Screenwidth * 0.005,
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.grey[600],
                          radius: screenHeight * 0.01,
                        ),
                      ],
                    ),
                  ],
                ),
                if (_isLoading) const Spacer(),
                _isLoading
                    ? Column(
                        children: [
                          const CupertinoActivityIndicator(),
                          SizedBox(height: screenHeight * 0.01),
                          Text(
                            "Loading Projects...",
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: screenHeight * 0.02),
                          ),
                          if (_totalImages > 0) ...[
                            SizedBox(height: screenHeight * 0.01),
                            Container(
                              width: Screenwidth * 0.3,
                              height: screenHeight * 0.005,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(screenHeight * 0.0025),
                                color: Colors.grey[700],
                              ),
                              child: FractionallySizedBox(
                                alignment: Alignment.centerLeft,
                                widthFactor: _loadedImages / _totalImages,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(screenHeight * 0.0025),
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.005),
                            Text(
                              "${_loadedImages}/${_totalImages} images loaded",
                              style: GoogleFonts.poppins(
                                  color: Colors.white60,
                                  fontSize: screenHeight * 0.015),
                            ),
                          ],
                        ],
                      )
                    : Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(Screenwidth * 0.01),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            screenHeight * 0.02),
                                      ),
                                      height: screenHeight * 0.5,
                                      width: Screenwidth * 0.7,
                                      child: ImageSlideshow(
                                        autoPlayInterval: 5000,
                                        isLoop: true,
                                        children: [
                                          for (var i = 0; i < 5; i++)
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        screenHeight * 0.02),
                                                color: Colors.grey[900],
                                              ),
                                              child: Stack(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            screenHeight *
                                                                0.02),
                                                    child: Image(
                                                      image: AssetImage(
                                                          _projects[i]
                                                              ['cover']),
                                                      height:
                                                          screenHeight * 0.5,
                                                      width: Screenwidth * 0.7,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.2),
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    screenHeight *
                                                                        0.01),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsets.only(
                                                                      left: Screenwidth *
                                                                          0.01),
                                                                  child: Text(
                                                                    "${_projects[i]['title']}",
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          screenHeight *
                                                                              0.03,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsets.only(
                                                                      left: Screenwidth *
                                                                          0.01),
                                                                  child: Text(
                                                                    "${_projects[i]['description']}",
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          screenHeight *
                                                                              0.02,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                          height: screenHeight *
                                                              0.02),
                                                      Padding(
                                                        padding: EdgeInsets.only(
                                                            left: Screenwidth *
                                                                0.01),
                                                        child: ElevatedButton(
                                                          onPressed: () {
                                                            html.window.open(
                                                                _projects[i]
                                                                    ['href'],
                                                                'new tab');
                                                          },
                                                          style: ButtonStyle(
                                                            backgroundColor:
                                                                WidgetStateProperty
                                                                    .all(Colors
                                                                        .blue
                                                                        .withOpacity(
                                                                            0.05)),
                                                            padding: WidgetStateProperty.all(
                                                                EdgeInsets.symmetric(
                                                                    horizontal:
                                                                        Screenwidth *
                                                                            0.02,
                                                                    vertical:
                                                                        screenHeight *
                                                                            0.02)),
                                                            shape:
                                                                WidgetStateProperty
                                                                    .all(
                                                              RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                        screenHeight *
                                                                            0.01),
                                                              ),
                                                            ),
                                                          ),
                                                          child: Text(
                                                            "See More",
                                                            style: GoogleFonts.poppins(
                                                                color: Colors
                                                                    .white,
                                                                fontSize:
                                                                    screenHeight *
                                                                        0.02),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(Screenwidth * 0.02),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(
                                            screenHeight * 0.01),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Top Projects",
                                          style: GoogleFonts.poppins(
                                              color: Colors.white,
                                              fontSize: screenHeight * 0.03),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: screenHeight * 0.02),
                              Padding(
                                padding: EdgeInsets.all(screenHeight * 0.01),
                                child: Text(
                                  "All Projects",
                                  style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: screenHeight * 0.03),
                                ),
                              ),
                              SizedBox(
                                width: Screenwidth * 0.72,
                                child: GridView.builder(
                                  shrinkWrap: true,
                                  itemCount: _projects.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: screenHeight * 0.01,
                                    mainAxisSpacing: screenHeight * 0.01,
                                    childAspectRatio:
                                        Screenwidth / (screenHeight * 0.6),
                                  ),
                                  itemBuilder: (context, index) {
                                    return Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.05),
                                          borderRadius: BorderRadius.circular(
                                              screenHeight * 0.01),
                                        ),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: CircleAvatar(
                                                radius: screenHeight * 0.04,
                                                backgroundColor: Colors.white,
                                                child: ClipOval(
                                                  child: Image(
                                                    image: AssetImage(
                                                        _projects[index]['img']),
                                                    width: screenHeight * 0.05,
                                                    height: screenHeight * 0.05,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Spacer(),
                                                Text(
                                                  "${_projects[index]['title']}",
                                                  style: GoogleFonts.poppins(
                                                      color: Colors.white,
                                                      fontSize:
                                                          screenHeight * 0.02),
                                                ),
                                                SizedBox(
                                                    height:
                                                        screenHeight * 0.01),
                                                Text(
                                                  "${_projects[index]['description']}",
                                                  style: GoogleFonts.poppins(
                                                      color: Colors.white,
                                                      fontSize:
                                                          screenHeight * 0.015),
                                                ),
                                                SizedBox(
                                                    height:
                                                        screenHeight * 0.01),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    html.window.open(
                                                        _projects[index]
                                                            ['href'],
                                                        'new tab');
                                                  },
                                                  style: ButtonStyle(
                                                    backgroundColor:
                                                        WidgetStateProperty.all(
                                                            Colors.black
                                                                .withOpacity(
                                                                    0.05)),
                                                    padding: WidgetStateProperty
                                                        .all(EdgeInsets.symmetric(
                                                            horizontal:
                                                                Screenwidth *
                                                                    0.02,
                                                            vertical:
                                                                screenHeight *
                                                                    0.02)),
                                                    shape:
                                                        WidgetStateProperty.all(
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                screenHeight *
                                                                    0.01),
                                                      ),
                                                    ),
                                                  ),
                                                  child: Text(
                                                    "See More",
                                                    style: GoogleFonts.poppins(
                                                        color: Colors.white,
                                                        fontSize: screenHeight *
                                                            0.02),
                                                  ),
                                                ),
                                                const Spacer(),
                                              ],
                                            ),
                                          ],
                                        ));
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                if (_isLoading) const Spacer(),
              ],
            ),
          ),
        );
      }),
    );
  }
}
