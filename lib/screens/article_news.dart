import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleNews extends StatefulWidget {
  static const routeName = '/article';
  // ignore: non_constant_identifier_names
  final String Blogurl;
  // ignore: non_constant_identifier_names
  ArticleNews({this.Blogurl});
  @override
  _ArticleNewsState createState() => _ArticleNewsState();
}

class _ArticleNewsState extends State<ArticleNews> {
  final Completer<WebViewController> controller =
      Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'BIZZBUZZ',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: WebView(
          initialUrl: widget.Blogurl,
          onWebViewCreated: (WebViewController webViewController) {
            controller.complete(webViewController);
          },
        ),
      ),
    );
  }
}
