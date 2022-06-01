import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main(List<String> args) {
  runApp(const MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  final CookieManager _cookieManager = CookieManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              const Text(
                'WebView Part',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 500,
                width: double.infinity,
                child: WebView(
                  // Initilise to my github page
                  initialUrl: 'https://github.com/jinosh05',
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (WebViewController webViewController) {
                    _controller.complete(webViewController);
                  },
                  onProgress: (int progress) {
                    debugPrint('WebView is loading (progress : $progress%)');
                  },

                  onPageStarted: (String url) {
                    debugPrint('Page started loading: $url');
                  },
                  onPageFinished: (String url) {
                    debugPrint('Page finished loading: $url');
                  },
                  gestureNavigationEnabled: true,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
