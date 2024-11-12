import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../core/remote_urls.dart';
import '../../core/router_name.dart';
import '../../utils/constants.dart';
import '../../utils/utils.dart';

class FlutterWaveScreen extends StatefulWidget {
  const FlutterWaveScreen({super.key, required this.url});
  final String url;

  @override
  State<FlutterWaveScreen> createState() => _FlutterWaveState();
}

class _FlutterWaveState extends State<FlutterWaveScreen> {
  double value = 0.0;

  bool _canRedirect = true;

  bool _isLoading = true;

  late WebViewController controllerGlobal;

  @override
  void initState() {
    initializeController();
    super.initState();
  }

  void initializeController() {
    final header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
    controllerGlobal = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      //..setBackgroundColor(redColor)
      ..setNavigationDelegate(NavigationDelegate(
        onProgress: (int progress) {
          setState(() {
            value = progress / 100;
          });
          log("WebView is loading (progress : $progress%)");
        },
        onPageStarted: (String url) {
          log('Page started loading: $url');
          setState(() {
            _isLoading = true;
          });
          log("printing urls $url");
          _redirect(url);
        },
        onPageFinished: (String url) {
          log('Page finished loading: $url');
          setState(() {
            _isLoading = false;
          });
          _redirect(url);
        },
      ))
      ..loadRequest(Uri.parse(widget.url),
          method: LoadRequestMethod.get, headers: header);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _exitApp(context),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("Flutterwave Payment"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => _exitApp(context),
          ),
          backgroundColor: white,
        ),
        body: Column(
          children: [
            if (_isLoading)
              Center(
                child: LinearProgressIndicator(
                  value: value,
                ),
              ),
            Expanded(
              child: WebViewWidget(controller: controllerGlobal),
            ),
          ],
        ),
      ),
    );
  }

  // Widget buildContainer() {
  //   return Container(
  //     color: redColor,
  //     child: WebView(
  //       javascriptMode: JavascriptMode.unrestricted,
  //       initialUrl: widget.url,
  //       gestureNavigationEnabled: true,
  //       userAgent:
  //           'Mozilla/5.0 (iPhone; CPU iPhone OS 9_3 like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Version/9.0 Mobile/13E233 Safari/601.1',
  //       onWebViewCreated: (WebViewController webViewController) {
  //         controllerGlobal = webViewController;
  //
  //         //_controller.future.catchError(onError)
  //       },
  //       onProgress: (int progress) {
  //         setState(() {
  //           value = progress / 100;
  //         });
  //         log("WebView is loading (progress : $progress%)");
  //       },
  //       onPageStarted: (String url) {
  //         log('Page started loading: $url');
  //         setState(() {
  //           _isLoading = true;
  //         });
  //         log("printing urls " + url.toString());
  //         _redirect(url);
  //       },
  //       onPageFinished: (String url) {
  //         log('Page finished loading: $url');
  //         setState(() {
  //           _isLoading = false;
  //         });
  //         _redirect(url);
  //       },
  //     ),
  //   );
  // }

  void _redirect(String url) {
    print("Url: $url");
    if (_canRedirect) {
      bool isSuccess = url.contains('/order-success-url-for-mobile-app') &&
          url.contains(RemoteUrls.rootUrl);
      bool isFailed = url.contains('fail') && url.contains(RemoteUrls.rootUrl);
      bool isCancel = url.contains('/order-fail-url-for-mobile-app') &&
          url.contains(RemoteUrls.rootUrl);
      if (isSuccess || isFailed || isCancel) {
        _canRedirect = false;
      }
      if (isSuccess) {
        getData();
      } else if (isFailed || isCancel) {
        Utils.errorSnackBar(context, 'Payment cancelled');
        Navigator.pop(context);
        return;
      } else {
        log("Encountered problem");
      }
    }
  }

  void getData() {
    controllerGlobal
        .runJavaScriptReturningResult("document.body.innerText")
        .then(
      (data) {
        var decodedJSON = jsonDecode(data.toString());
        var responseJSON = jsonDecode(decodedJSON);
        log(decodedJSON, name: 'FlutterWaveScreen');
        if (responseJSON["result"] == false) {
          Utils.errorSnackBar(context, responseJSON["message"]);
          print('message3');
        } else if (responseJSON["result"] == true) {
          Utils.showSnackBar(context, responseJSON["message"]);
          print('message1');
        }
        Navigator.pushNamedAndRemoveUntil(context, RouteNames.orderScreen,
            (route) {
          if (route.settings.name == RouteNames.mainPage) {
            print('message2');
            return true;
          }
          return false;
        });
      },
    );
  }

  Future<bool> _exitApp(BuildContext context) async {
    if (await controllerGlobal.canGoBack()) {
      controllerGlobal.goBack();
      return Future.value(false);
    } else {
      return true;
    }
  }
}
