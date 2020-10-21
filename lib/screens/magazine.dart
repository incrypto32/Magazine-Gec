import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class MagazineScreen extends StatefulWidget {
  const MagazineScreen({
    Key key,
    this.path,
  }) : super(key: key);
  final String path;
  @override
  _MagazineScreenState createState() => _MagazineScreenState();
}

class _MagazineScreenState extends State<MagazineScreen> {
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();

  int pages = 0;

  int currentPage = 0;

  bool isReady = false;

  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Container(
          height: 50,
          child: Image.asset(
            'assets/images/cil.png',
            fit: BoxFit.contain,
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          PDFView(
            filePath: widget.path,
            enableSwipe: true,
            swipeHorizontal: true,
            autoSpacing: false,
            pageFling: true,
            pageSnap: true,
            defaultPage: currentPage,
            fitPolicy: FitPolicy.BOTH,
            preventLinkNavigation:
                false, // if set to true the link is handled in flutter
            onRender: (_pages) {
              setState(() {
                pages = _pages;
                isReady = true;
              });
            },
            onError: (error) {
              setState(() {
                errorMessage = error.toString();
              });
              print(error.toString());
            },
            onPageError: (page, error) {
              setState(() {
                errorMessage = '$page: ${error.toString()}';
              });
              print('$page: ${error.toString()}');
            },
            onViewCreated: (PDFViewController pdfViewController) {
              _controller.complete(pdfViewController);
            },
            onLinkHandler: (String uri) {
              print('goto uri: $uri');
            },
            onPageChanged: (int page, int total) {
              print('page change: $page/$total');
              setState(() {
                currentPage = page;
              });
            },
          ),
          errorMessage.isEmpty
              ? !isReady
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container()
              : Center(
                  child: Text("An error occured."),
                ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      textColor:
                          !(currentPage == 10) ? Colors.black : Colors.white,
                      color: currentPage == 10 ? Colors.black : Colors.white,
                      onPressed: () {
                        _controller.future.then((value) {
                          value.setPage(10);
                        });
                      },
                      child: Text("ഇക്കിളി"),
                    ),
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: Colors.white,
                      onPressed: () {
                        _controller.future.then((value) {
                          value.setPage(40);
                        });
                      },
                      child: Text("ചൊറി"),
                    ),
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: Colors.white,
                      onPressed: () {
                        _controller.future.then((value) {
                          value.setPage(30);
                        });
                      },
                      child: Text("വെട്ട്"),
                    ),
                  ],
                ),
                Slider(
                  min: 0,
                  max: 0.0 + pages,
                  label: "hi",
                  value: currentPage + 0.0,
                  onChangeEnd: (value) {
                    _controller.future.then((c) {
                      c.setPage(value.toInt());
                    });
                  },
                  onChanged: (value) {
                    setState(() {
                      currentPage = value.toInt();
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
