import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gecmagazine/screens/splash.dart';
import 'package:gecmagazine/screens/uri.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Magazine',
      theme: ThemeData(
        primaryColor: Colors.black,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.montserratTextTheme(Theme.of(context).textTheme),
      ),
      home: Magazine(),
    );
  }
}

class Magazine extends StatefulWidget {
  @override
  _MagazineState createState() => _MagazineState();
}

class _MagazineState extends State<Magazine> {
  String path = "";
  Future<File> fromAsset(String asset, String filename) async {
    // To open from assets, you can copy them to the app storage folder, and the access them "locally"
    Completer<File> completer = Completer();

    try {
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/$filename");
      var data = await rootBundle.load(asset);
      var bytes = data.buffer.asUint8List();
      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      print(e);
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      Duration(seconds: 2),
      () {
        fromAsset("assets/pdf/magazine.pdf", "magazine.pdf").then((value) {
          Navigator.of(context).pushReplacement(
            PageRouteBuilder(
              transitionDuration: Duration(milliseconds: 600),
              pageBuilder: (context, animation, secondaryAnimation) =>
                  LandingScreen(path: value.path),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
            ),
          );
        });
      },
    );
    return SplashScreen();
  }
}
