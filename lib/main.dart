import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main(List<String> args) {
  runApp(const MaterialApp(
    home: SafeArea(child: MyApp()),
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
  late WebViewController _mycontroller;
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
                width: MediaQuery.of(context).size.width - 30,
                child: WebView(
                  // Initilise to my github page
                  initialUrl: 'https://github.com/jinosh05',
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (WebViewController webViewController) {
                    _controller.complete(webViewController);
                    webViewController.clearCache();
                    _cookieManager.clearCookies();
                    setState(() {
                      _mycontroller = webViewController;
                    });
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
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    _mycontroller.clearCache();
                  },
                  child: const Text('Clear Cache'))
            ],
          ),
        ),
      ),
    );
  }
}
