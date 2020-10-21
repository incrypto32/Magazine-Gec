import 'package:flutter/material.dart';
import 'package:gecmagazine/screens/magazine.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({
    Key key,
    @required this.path,
  }) : super(key: key);

  final String path;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          color: Colors.black54,
          child: SafeArea(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "വാർഷികം 2020",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 120),
                  child: Image.asset(
                    'assets/images/u.png',
                  ),
                ),
                Text(
                  "College Magazine",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                  ),
                ),
                Spacer(),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: Duration(milliseconds: 300),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          var begin = Offset(1.0, 0.0);
                          var end = Offset.zero;
                          var curve = Curves.ease;

                          var tween = Tween(begin: begin, end: end);
                          var curvedAnimation = CurvedAnimation(
                            parent: animation,
                            curve: curve,
                          );

                          return SlideTransition(
                            position: tween.animate(curvedAnimation),
                            child: child,
                          );
                        },
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            MagazineScreen(
                          path: path,
                        ),
                      ),
                    );
                  },
                  child: Text("Read"),
                ),
                Spacer(flex: 3),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    "Government Engineering College\nThrissur",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
