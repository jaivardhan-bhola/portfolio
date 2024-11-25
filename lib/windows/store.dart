import 'dart:async';
import 'dart:html' as html;
import 'dart:convert';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class WindowsStore extends StatefulWidget {
  const WindowsStore({super.key});

  @override
  State<WindowsStore> createState() => _WindowsStoreState();
}

class _WindowsStoreState extends State<WindowsStore> {
  List<dynamic> _projects = [];
  bool _isLoading = true;

  Future<void> _loadProjects() async {
    final String response =
        await rootBundle.loadString('assets/data/projects.json');
    final data = await json.decode(response);
    for (var i = 0; i < data.length; i++) {
      await precacheImage(NetworkImage(data[i]['img']), context);
      await precacheImage(NetworkImage(data[i]['cover']), context);
    }
    setState(() {
      _projects = data;
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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Dialog(
      backgroundColor: Colors.grey[900],
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(screenHeight * 0.02),
          side: BorderSide(color: Colors.white12, width: screenHeight * 0.002)),
      child: Builder(builder: (context) {
        return SizedBox(
          height: screenHeight * 0.8,
          width: screenWidth * 0.8,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: screenHeight * 0.03,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (_isLoading) const Spacer(),
                _isLoading
                    ? Column(
                        children: [
                          Image(
                            image: const AssetImage('assets/windows/store.png'),
                            height: screenHeight * 0.1,
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          const CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.blue),
                          ),
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
                                    padding: EdgeInsets.all(screenWidth * 0.01),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            screenHeight * 0.02),
                                      ),
                                      height: screenHeight * 0.5,
                                      width: screenWidth * 0.7,
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
                                                      image: NetworkImage(
                                                          _projects[i]
                                                              ['cover']),
                                                      height:
                                                          screenHeight * 0.5,
                                                      width: screenWidth * 0.7,
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
                                                                      left: screenWidth *
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
                                                                      left: screenWidth *
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
                                                            left: screenWidth *
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
                                                                        screenWidth *
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
                                    padding: EdgeInsets.all(screenWidth * 0.02),
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
                                width: screenWidth * 0.72,
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
                                        screenWidth / (screenHeight * 0.6),
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
                                                child: Image(
                                                  image: NetworkImage(
                                                      _projects[index]['img']),
                                                  width: screenWidth * 0.05,
                                                  height: screenHeight * 0.05,
                                                  fit: BoxFit.fitHeight,
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
                                                                screenWidth *
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
