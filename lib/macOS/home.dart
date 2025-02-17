import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'package:intl/intl.dart';
import 'package:portfolio/frosted_glass.dart';
import 'package:portfolio/macOS/dock.dart';
import 'package:portfolio/macOS/store.dart';
import 'package:portfolio/windows/entry.dart';
import 'package:google_fonts/google_fonts.dart';

class MacHome extends StatefulWidget {
  const MacHome({super.key});

  @override
  State<MacHome> createState() => _MacHomeState();
}

class _MacHomeState extends State<MacHome> {
  bool _isfullscreen = false;
  String _active = 'Finder';

  @override
  Widget build(BuildContext context) {
    double Screenwidth = MediaQuery.of(context).size.width;
    double Screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/mac/bg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FrostedGlassBox(
                  width: Screenwidth,
                  height: Screenheight * 0.04,
                  sigma: 30,
                  child: Row(
                    children: [
                      SizedBox(
                        width: Screenwidth * 0.02,
                      ),
                      Image(
                        image: const AssetImage(
                          'assets/mac/logo.png',
                        ),
                        width: Screenheight * 0.025,
                        height: Screenheight * 0.025,
                      ),
                      SizedBox(
                        width: Screenwidth * 0.01,
                      ),
                      Text(
                        _active,
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: Screenheight * 0.02,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        width: Screenwidth * 0.01,
                      ),
                      GestureDetector(
                        onTap: () => {
                          setState(() {
                            _active = 'Socials';
                          }),
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) {
                                return Dialog(
                                    backgroundColor: Colors.grey[900],
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            Screenheight * 0.02),
                                        side: BorderSide(
                                            color: Colors.white12,
                                            width: Screenheight * 0.002)),
                                    child: SizedBox(
                                        width: Screenwidth * 0.3,
                                        height: Screenheight * 0.4,
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        _active = 'Finder';
                                                      });
                                                      Navigator.pop(context);
                                                    },
                                                    child: CircleAvatar(
                                                      backgroundColor:
                                                          Colors.redAccent,
                                                      radius:
                                                          Screenheight * 0.01,
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width:
                                                            Screenwidth * 0.005,
                                                      ),
                                                      CircleAvatar(
                                                        backgroundColor:
                                                            Colors.grey[600],
                                                        radius:
                                                            Screenheight * 0.01,
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            Screenwidth * 0.005,
                                                      ),
                                                      CircleAvatar(
                                                        backgroundColor:
                                                            Colors.grey[600],
                                                        radius:
                                                            Screenheight * 0.01,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: Screenheight * 0.02,
                                            ),
                                            Text(
                                              'Socials',
                                              style: GoogleFonts.poppins(
                                                  color: Colors.white,
                                                  fontSize: Screenheight * 0.05,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            SizedBox(
                                              height: Screenheight * 0.02,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                GestureDetector(
                                                  onTap: () => html.window.open(
                                                      'https://www.github.com/jaivardhan-bhola',
                                                      'new tab'),
                                                  child: Image(
                                                    image: const AssetImage(
                                                        'assets/icons/github.png'),
                                                    width: Screenwidth * 0.03,
                                                  ),
                                                ),
                                                SizedBox(
                                                    width: Screenwidth * 0.01),
                                                GestureDetector(
                                                  onTap: () => html.window.open(
                                                      'https://www.linkedin.com/in/jaivardhan-bhola/',
                                                      'new tab'),
                                                  child: Image(
                                                    image: const AssetImage(
                                                        'assets/icons/linkedin.png'),
                                                    width: Screenwidth * 0.03,
                                                  ),
                                                ),
                                                SizedBox(
                                                    width: Screenwidth * 0.01),
                                                GestureDetector(
                                                  onTap: () => html.window.open(
                                                      'https://www.instagram.com/jaivardhan_b/',
                                                      'new tab'),
                                                  child: Image(
                                                    image: const AssetImage(
                                                        'assets/icons/instagram.png'),
                                                    width: Screenwidth * 0.03,
                                                  ),
                                                ),
                                                SizedBox(
                                                    width: Screenwidth * 0.01),
                                                GestureDetector(
                                                  onTap: () => html.window.open(
                                                      'https://www.twitter.com/jaivardhanbhola',
                                                      'new tab'),
                                                  child: Image(
                                                    image: const AssetImage(
                                                        'assets/icons/twitter.jpg'),
                                                    width: Screenwidth * 0.03,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )));
                              })
                        },
                        child: Text('Socials',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: Screenheight * 0.02,
                            )),
                      ),
                      SizedBox(
                        width: Screenwidth * 0.01,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _active = 'Skills';
                          });
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) {
                                return Dialog(
                                    backgroundColor: Colors.grey[900],
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            Screenheight * 0.02),
                                        side: BorderSide(
                                            color: Colors.white12,
                                            width: Screenheight * 0.002)),
                                    child: SizedBox(
                                        width: Screenwidth * 0.3,
                                        height: Screenheight * 0.5,
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        _active = 'Finder';
                                                      });
                                                      Navigator.pop(context);
                                                    },
                                                    child: CircleAvatar(
                                                      backgroundColor:
                                                          Colors.redAccent,
                                                      radius:
                                                          Screenheight * 0.01,
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width:
                                                            Screenwidth * 0.005,
                                                      ),
                                                      CircleAvatar(
                                                        backgroundColor:
                                                            Colors.grey[600],
                                                        radius:
                                                            Screenheight * 0.01,
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            Screenwidth * 0.005,
                                                      ),
                                                      CircleAvatar(
                                                        backgroundColor:
                                                            Colors.grey[600],
                                                        radius:
                                                            Screenheight * 0.01,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: Screenheight * 0.02,
                                            ),
                                            Text(
                                              'Skills',
                                              style: GoogleFonts.poppins(
                                                  color: Colors.white,
                                                  fontSize: Screenheight * 0.05,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            SizedBox(
                                                height: Screenheight * 0.01),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                GestureDetector(
                                                  onTap: () => html.window.open(
                                                      'https://www.typescriptlang.org/',
                                                      'new tab'),
                                                  child: Image(
                                                    image: const AssetImage(
                                                        'assets/icons/typescript.png'),
                                                    width: Screenwidth * 0.03,
                                                  ),
                                                ),
                                                SizedBox(
                                                    width: Screenwidth * 0.01),
                                                GestureDetector(
                                                  onTap: () => html.window.open(
                                                      'https://isocpp.org/',
                                                      'new tab'),
                                                  child: Image(
                                                    image: const AssetImage(
                                                        'assets/icons/cpp.png'),
                                                    width: Screenwidth * 0.03,
                                                  ),
                                                ),
                                                SizedBox(
                                                    width: Screenwidth * 0.01),
                                                GestureDetector(
                                                  onTap: () => html.window.open(
                                                      'https://developer.mozilla.org/en-US/docs/Web/HTML',
                                                      'new tab'),
                                                  child: Image(
                                                    image: const AssetImage(
                                                        'assets/icons/html.png'),
                                                    width: Screenwidth * 0.03,
                                                  ),
                                                ),
                                                SizedBox(
                                                    width: Screenwidth * 0.01),
                                                GestureDetector(
                                                  onTap: () => html.window.open(
                                                      'https://developer.mozilla.org/en-US/docs/Web/CSS',
                                                      'new tab'),
                                                  child: Image(
                                                    image: const AssetImage(
                                                        'assets/icons/css.png'),
                                                    width: Screenwidth * 0.03,
                                                  ),
                                                ),
                                                SizedBox(
                                                    width: Screenwidth * 0.01),
                                                GestureDetector(
                                                  onTap: () => html.window.open(
                                                      'https://www.markdownguide.org/',
                                                      'new tab'),
                                                  child: Image(
                                                    image: const AssetImage(
                                                        'assets/icons/markdown.png'),
                                                    width: Screenwidth * 0.03,
                                                  ),
                                                ),
                                                SizedBox(
                                                    width: Screenwidth * 0.01),
                                                GestureDetector(
                                                  onTap: () => html.window.open(
                                                      'https://developer.mozilla.org/en-US/docs/Web/JavaScript',
                                                      'new tab'),
                                                  child: Image(
                                                    image: const AssetImage(
                                                        'assets/icons/javascript.png'),
                                                    width: Screenwidth * 0.03,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                                height: Screenheight * 0.01),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                GestureDetector(
                                                  onTap: () => html.window.open(
                                                      'https://www.java.com/',
                                                      'new tab'),
                                                  child: Image(
                                                    image: const AssetImage(
                                                        'assets/icons/java.png'),
                                                    width: Screenwidth * 0.03,
                                                  ),
                                                ),
                                                SizedBox(
                                                    width: Screenwidth * 0.01),
                                                GestureDetector(
                                                  onTap: () => html.window.open(
                                                      'https://www.python.org/',
                                                      'new tab'),
                                                  child: Image(
                                                    image: const AssetImage(
                                                        'assets/icons/python.png'),
                                                    width: Screenwidth * 0.03,
                                                  ),
                                                ),
                                                SizedBox(
                                                    width: Screenwidth * 0.01),
                                                GestureDetector(
                                                  onTap: () => html.window.open(
                                                      'https://golang.org/',
                                                      'new tab'),
                                                  child: Image(
                                                    image: const AssetImage(
                                                        'assets/icons/go.png'),
                                                    width: Screenwidth * 0.03,
                                                  ),
                                                ),
                                                SizedBox(
                                                    width: Screenwidth * 0.01),
                                                GestureDetector(
                                                  onTap: () => html.window.open(
                                                      'https://firebase.google.com/',
                                                      'new tab'),
                                                  child: Image(
                                                    image: const AssetImage(
                                                        'assets/icons/firebase.png'),
                                                    width: Screenwidth * 0.03,
                                                  ),
                                                ),
                                                SizedBox(
                                                    width: Screenwidth * 0.01),
                                                GestureDetector(
                                                  onTap: () => html.window.open(
                                                      'https://www.mysql.com/',
                                                      'new tab'),
                                                  child: Image(
                                                    image: const AssetImage(
                                                        'assets/icons/mysql.png'),
                                                    width: Screenwidth * 0.03,
                                                  ),
                                                ),
                                                SizedBox(
                                                    width: Screenwidth * 0.01),
                                                GestureDetector(
                                                  onTap: () => html.window.open(
                                                      'https://www.sqlite.org/',
                                                      'new tab'),
                                                  child: Image(
                                                    image: const AssetImage(
                                                        'assets/icons/sqlite.png'),
                                                    width: Screenwidth * 0.03,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                                height: Screenheight * 0.01),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                GestureDetector(
                                                  onTap: () => html.window.open(
                                                      'https://nextjs.org/',
                                                      'new tab'),
                                                  child: Image(
                                                    image: const AssetImage(
                                                        'assets/icons/nextjs.png'),
                                                    width: Screenwidth * 0.03,
                                                  ),
                                                ),
                                                SizedBox(
                                                    width: Screenwidth * 0.01),
                                                GestureDetector(
                                                  onTap: () => html.window.open(
                                                      'https://flutter.dev/',
                                                      'new tab'),
                                                  child: Image(
                                                    image: const AssetImage(
                                                        'assets/icons/flutter.png'),
                                                    width: Screenwidth * 0.03,
                                                  ),
                                                ),
                                                SizedBox(
                                                    width: Screenwidth * 0.01),
                                                GestureDetector(
                                                  onTap: () => html.window.open(
                                                      'https://www.postman.com/',
                                                      'new tab'),
                                                  child: Image(
                                                    image: const AssetImage(
                                                        'assets/icons/postman.png'),
                                                    width: Screenwidth * 0.03,
                                                  ),
                                                ),
                                                SizedBox(
                                                    width: Screenwidth * 0.01),
                                                GestureDetector(
                                                  onTap: () => html.window.open(
                                                      'https://www.docker.com/',
                                                      'new tab'),
                                                  child: Image(
                                                    image: const AssetImage(
                                                        'assets/icons/docker.png'),
                                                    width: Screenwidth * 0.03,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                                height: Screenheight * 0.03),
                                            const Spacer(),
                                            Text(
                                              'Made with ❤️ in Flutter',
                                              style: GoogleFonts.poppins(
                                                  color: Colors.white,
                                                  fontSize:
                                                      Screenheight * 0.02),
                                            ),
                                            SizedBox(
                                                height: Screenheight * 0.01),
                                          ],
                                        )));
                              });
                        },
                        child: Text('Skills',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: Screenheight * 0.02,
                            )),
                      ),
                      const Spacer(),
                      Text(
                        DateFormat('E, MMM d').format(DateTime.now()),
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: Screenheight * 0.02,
                        ),
                      ),
                      SizedBox(
                        width: Screenwidth * 0.01,
                      ),
                      Text(
                        DateFormat.jm().format(DateTime.now()),
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: Screenheight * 0.02,
                        ),
                      ),
                      SizedBox(
                        width: Screenwidth * 0.01,
                      ),
                    ],
                  )),
              Padding(
                padding: EdgeInsets.only(
                    left: Screenwidth * 0.05, top: Screenheight * 0.04),
                child: Column(children: [
                  GestureDetector(
                    onTap: () async => {
                      setState(() {
                        _active = 'Projects';
                      }),
                      await showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) {
                          return MacStore(
                            active: 'Projects',
                            onActiveChanged: (newActive) {
                              setState(() {
                                _active = newActive;
                              });
                            },
                          );
                        },
                      ),
                      setState(() {
                        _active = 'Finder';
                      })
                    },
                    child: Column(
                      children: [
                        Image(
                          image: const AssetImage('assets/icons/projects.png'),
                          width: Screenwidth * 0.03,
                        ),
                        SizedBox(
                          height: Screenheight * 0.005,
                        ),
                        Text(
                          'Projects',
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: Screenheight * 0.02),
                        ),
                        SizedBox(
                          height: Screenheight * 0.02,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: Screenwidth * 0.02,
                  ),
                  GestureDetector(
                    onTap: () => html.window
                        .open('https://github.com/jaivardhan-bhola', 'new tab'),
                    child: Column(
                      children: [
                        Image(
                          image: const AssetImage('assets/icons/github.png'),
                          width: Screenwidth * 0.03,
                        ),
                        SizedBox(
                          height: Screenheight * 0.005,
                        ),
                        Text(
                          'GitHub',
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: Screenheight * 0.02),
                        ),
                        SizedBox(
                          height: Screenheight * 0.02,
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => html.window.open(
                        'https://drive.google.com/file/d/18rltwqG_Tm2paUyemvSNF4HRClGZoYQO/view?usp=sharing',
                        'new tab'),
                    child: Column(
                      children: [
                        Image(
                          image: const AssetImage('assets/icons/acrobat.png'),
                          width: Screenwidth * 0.03,
                        ),
                        SizedBox(
                          height: Screenheight * 0.005,
                        ),
                        Text(
                          'Resume',
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: Screenheight * 0.02),
                        ),
                        SizedBox(
                          height: Screenheight * 0.02,
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => html.window.open(
                        'https://www.linkedin.com/in/jaivardhan-bhola/',
                        'new tab'),
                    child: Column(
                      children: [
                        Image(
                          image: const AssetImage('assets/icons/linkedin.png'),
                          width: Screenwidth * 0.03,
                        ),
                        SizedBox(
                          height: Screenheight * 0.005,
                        ),
                        Text(
                          'LinkedIn',
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: Screenheight * 0.02),
                        ),
                        SizedBox(
                          height: Screenheight * 0.02,
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => {
                      setState(() {
                        _isfullscreen = !_isfullscreen;
                      }),
                      _isfullscreen
                          ? html.document.documentElement?.requestFullscreen()
                          : html.document.exitFullscreen(),
                    },
                    child: Column(
                      children: [
                        Image(
                          image:
                              const AssetImage('assets/windows/fullscreen.png'),
                          width: Screenwidth * 0.03,
                        ),
                        SizedBox(
                          height: Screenheight * 0.005,
                        ),
                        Text(
                          'Fullscreen',
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: Screenheight * 0.02),
                        ),
                        SizedBox(
                          height: Screenheight * 0.02,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: Screenwidth * 0.02,
                  ),
                  GestureDetector(
                    onTap: () => {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const WindowsEntry()),
                      ),
                    },
                    child: Column(
                      children: [
                        Image(
                          image: const AssetImage('assets/windows/logo.png'),
                          width: Screenwidth * 0.03,
                        ),
                        Text(
                          'Windows Mode',
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: Screenheight * 0.02),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
              const Spacer(),
              Dock(
                active: _active,
                onActiveChanged: (newActive) {
                  setState(() {
                    _active = newActive;
                  });
                },
              ),
            ],
          ),
        ));
  }
}
