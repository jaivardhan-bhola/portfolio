import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'package:intl/intl.dart';
import 'package:portfolio/frosted_glass.dart';
import 'package:portfolio/macOS/entry.dart';
import 'package:portfolio/windows/store.dart';
import 'package:google_fonts/google_fonts.dart';

class WindowsHome extends StatefulWidget {
  const WindowsHome({super.key});

  @override
  State<WindowsHome> createState() => _WindowsHomeState();
}

class _WindowsHomeState extends State<WindowsHome> {
  bool _isfullscreen = false;
  bool _isVisible = false;

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
              image: AssetImage('assets/windows/bg.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: Screenwidth * 0.05, top: Screenheight * 0.04),
                  child: Column(children: [
                    GestureDetector(
                      onTap: () => {
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) {
                              return const WindowsStore();
                            })
                      },
                      child: Column(
                        children: [
                          Image(
                            image:
                                const AssetImage('assets/icons/projects.png'),
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
                      onTap: () => html.window.open(
                          'https://github.com/jaivardhan-bhola', 'new tab'),
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
                            image:
                                const AssetImage('assets/icons/linkedin.png'),
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
                      onTap: () =>
                          html.window.open('https://notablyai.me/', 'new tab'),
                      child: Column(
                        children: [
                          Image(
                            image: const AssetImage('assets/icons/notably.png'),
                            width: Screenwidth * 0.03,
                          ),
                          SizedBox(
                            height: Screenheight * 0.005,
                          ),
                          Text(
                            'Notably',
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
                            image: const AssetImage(
                                'assets/windows/fullscreen.png'),
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
                              builder: (context) => const MacEntry()),
                        ),
                      },
                      child: Column(
                        children: [
                          Image(
                            image: const AssetImage('assets/windows/mac.png'),
                            width: Screenwidth * 0.03,
                          ),
                          Text(
                            'macOS Mode',
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
                FrostedGlassBox(
                  height: Screenheight * 0.065,
                  width: Screenwidth,
                  sigma: 20,
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: Screenheight * 0.005,
                        bottom: Screenheight * 0.005),
                    child: Row(
                      children: [
                        const Spacer(),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () => setState(() {
                                _isVisible = !_isVisible;
                              }),
                              icon: Image.asset(
                                'assets/windows/start.png',
                                width: Screenwidth * 0.02,
                              ),
                            ),
                            IconButton(
                              onPressed: () => html.window.open(
                                  'https://www.github.com/jaivardhan-bhola',
                                  'new tab'),
                              icon: Image.asset(
                                'assets/icons/github.png',
                                width: Screenwidth * 0.02,
                              ),
                            ),
                            IconButton(
                              onPressed: () => html.window.open(
                                  'https://drive.google.com/file/d/18rltwqG_Tm2paUyemvSNF4HRClGZoYQO/view?usp=sharing',
                                  'new tab'),
                              icon: Image.asset(
                                'assets/icons/acrobat.png',
                                width: Screenwidth * 0.02,
                              ),
                            ),
                            IconButton(
                              onPressed: () => {
                                showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (context) {
                                      return const WindowsStore();
                                    })
                              },
                              icon: Image.asset(
                                'assets/icons/projects.png',
                                width: Screenwidth * 0.02,
                              ),
                            ),
                            IconButton(
                              onPressed: () => html.window.open(
                                  'mailto:jaivardhan.bhola@gmail.com',
                                  'new tab'),
                              icon: Image.asset(
                                'assets/windows/mail.png',
                                width: Screenwidth * 0.02,
                              ),
                            ),
                            SizedBox(
                              width: Screenwidth * 0.009,
                            ),
                          ],
                        ),
                        const Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: Screenheight * 0.008,
                            ),
                            Text(
                              DateFormat.jm().format(DateTime.now()).toString(),
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: Screenheight * 0.0165),
                            ),
                            Text(
                              DateFormat.yMd()
                                  .format(DateTime.now())
                                  .toString(),
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: Screenheight * 0.0165),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: Screenwidth * 0.01,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            _isVisible
                ? Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                        padding: EdgeInsets.only(bottom: Screenheight * 0.07),
                        child: FrostedGlassBox(
                          width: Screenwidth * 0.3,
                          height: Screenheight * 0.62,
                          sigma: 20,
                          borderRadius: Screenwidth * 0.005,
                          child: Column(
                            children: [
                              SizedBox(height: Screenheight * 0.01),
                              Text(
                                'Socials',
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: Screenheight * 0.03),
                              ),
                              SizedBox(height: Screenheight * 0.01),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
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
                                  SizedBox(width: Screenwidth * 0.01),
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
                                  SizedBox(width: Screenwidth * 0.01),
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
                                  SizedBox(width: Screenwidth * 0.01),
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
                              SizedBox(height: Screenheight * 0.03),
                              Text(
                                'Skills',
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: Screenheight * 0.03),
                              ),
                              SizedBox(height: Screenheight * 0.01),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
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
                                  SizedBox(width: Screenwidth * 0.01),
                                  GestureDetector(
                                    onTap: () => html.window
                                        .open('https://isocpp.org/', 'new tab'),
                                    child: Image(
                                      image: const AssetImage(
                                          'assets/icons/cpp.png'),
                                      width: Screenwidth * 0.03,
                                    ),
                                  ),
                                  SizedBox(width: Screenwidth * 0.01),
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
                                  SizedBox(width: Screenwidth * 0.01),
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
                                  SizedBox(width: Screenwidth * 0.01),
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
                                  SizedBox(width: Screenwidth * 0.01),
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
                              SizedBox(height: Screenheight * 0.01),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () => html.window.open(
                                        'https://www.java.com/', 'new tab'),
                                    child: Image(
                                      image: const AssetImage(
                                          'assets/icons/java.png'),
                                      width: Screenwidth * 0.03,
                                    ),
                                  ),
                                  SizedBox(width: Screenwidth * 0.01),
                                  GestureDetector(
                                    onTap: () => html.window.open(
                                        'https://www.python.org/', 'new tab'),
                                    child: Image(
                                      image: const AssetImage(
                                          'assets/icons/python.png'),
                                      width: Screenwidth * 0.03,
                                    ),
                                  ),
                                  SizedBox(width: Screenwidth * 0.01),
                                  GestureDetector(
                                    onTap: () => html.window
                                        .open('https://golang.org/', 'new tab'),
                                    child: Image(
                                      image: const AssetImage(
                                          'assets/icons/go.png'),
                                      width: Screenwidth * 0.03,
                                    ),
                                  ),
                                  SizedBox(width: Screenwidth * 0.01),
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
                                  SizedBox(width: Screenwidth * 0.01),
                                  GestureDetector(
                                    onTap: () => html.window.open(
                                        'https://www.mysql.com/', 'new tab'),
                                    child: Image(
                                      image: const AssetImage(
                                          'assets/icons/mysql.png'),
                                      width: Screenwidth * 0.03,
                                    ),
                                  ),
                                  SizedBox(width: Screenwidth * 0.01),
                                  GestureDetector(
                                    onTap: () => html.window.open(
                                        'https://www.sqlite.org/', 'new tab'),
                                    child: Image(
                                      image: const AssetImage(
                                          'assets/icons/sqlite.png'),
                                      width: Screenwidth * 0.03,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: Screenheight * 0.01),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () => html.window
                                        .open('https://nextjs.org/', 'new tab'),
                                    child: Image(
                                      image: const AssetImage(
                                          'assets/icons/nextjs.png'),
                                      width: Screenwidth * 0.03,
                                    ),
                                  ),
                                  SizedBox(width: Screenwidth * 0.01),
                                  GestureDetector(
                                    onTap: () => html.window.open(
                                        'https://flutter.dev/', 'new tab'),
                                    child: Image(
                                      image: const AssetImage(
                                          'assets/icons/flutter.png'),
                                      width: Screenwidth * 0.03,
                                    ),
                                  ),
                                  SizedBox(width: Screenwidth * 0.01),
                                  GestureDetector(
                                    onTap: () => html.window.open(
                                        'https://www.postman.com/', 'new tab'),
                                    child: Image(
                                      image: const AssetImage(
                                          'assets/icons/postman.png'),
                                      width: Screenwidth * 0.03,
                                    ),
                                  ),
                                  SizedBox(width: Screenwidth * 0.01),
                                  GestureDetector(
                                    onTap: () => html.window.open(
                                        'https://www.docker.com/', 'new tab'),
                                    child: Image(
                                      image: const AssetImage(
                                          'assets/icons/docker.png'),
                                      width: Screenwidth * 0.03,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: Screenheight * 0.03),
                              const Spacer(),
                              Text(
                                'Made with ❤️ in Flutter',
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: Screenheight * 0.02),
                              ),
                              SizedBox(width: Screenwidth * 0.01),
                              const Spacer(),
                              FrostedGlassBox(
                                  width: Screenwidth * 0.3,
                                  height: Screenheight * 0.07,
                                  sigma: 20,
                                  child: Row(
                                    children: [
                                      SizedBox(width: Screenwidth * 0.01),
                                      const CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            'https://avatars.githubusercontent.com/u/83286825?s=400&u=20910b5f473552ba8c4028199ee78491e09e5a71&v=4'),
                                      ),
                                      SizedBox(width: Screenwidth * 0.01),
                                      Text(
                                        'Jaivardhan Bhola',
                                        style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontSize: Screenheight * 0.02),
                                      ),
                                    ],
                                  ))
                            ],
                          ),
                        )),
                  )
                : Container(),
          ]),
        ));
  }
}
