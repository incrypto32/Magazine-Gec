import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.all(10),
          child: Text(
            "വാർഷികം 2020",
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
      ),
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
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(100),
              child: Image.asset(
                'assets/images/u.png',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
