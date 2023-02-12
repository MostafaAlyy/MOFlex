import 'dart:io';

import 'package:desktop_webview_window/desktop_webview_window.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class DesktopWebView extends StatefulWidget {
  String videoUrl;
  DesktopWebView(this.videoUrl);

  @override
  State<DesktopWebView> createState() => _DesktopWebViewState(videoUrl);
}

class _DesktopWebViewState extends State<DesktopWebView> {
  String videoUrl;
  _DesktopWebViewState(this.videoUrl);

  bool? _webviewAvailable;

  @override
  void initState() {
    super.initState();

    WebviewWindow.isWebviewAvailable().then((value) {
      setState(() {
        _webviewAvailable = value;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                onPressed: _webviewAvailable != true ? null : _onTap,
                child: const Text('Open'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onTap() async {
    final webview = await WebviewWindow.create(
      configuration: CreateConfiguration(
        userDataFolderWindows: await _getWebViewPath(),
      ),
    );
    webview
      ..setBrightness(Brightness.dark)
      ..setApplicationNameForUserAgent(" WebviewExample/1.0.0")
      ..launch(videoUrl)
      ..addOnUrlRequestCallback((url) {
        debugPrint('url: $url');
        if (url != videoUrl) {
          webview.stop();
        }
        final uri = Uri.parse(url);
        if (uri.path == '/login_success') {
          debugPrint('login success. token: ${uri.queryParameters['token']}');
          webview.close();
        }
      })
      ..onClose.whenComplete(() {
        debugPrint("on close");
      });
    await Future.delayed(const Duration(seconds: 2));
    for (final javaScript in _javaScriptToEval) {
      try {
        final ret = await webview.evaluateJavaScript(javaScript);
        debugPrint('evaluateJavaScript: $ret');
      } catch (e) {
        debugPrint('evaluateJavaScript error: $e \n $javaScript');
      }
    }
  }
}

const _javaScriptToEval = [
  """
  function test() {
    return;
  }
  test();
  """,
  'eval({"name": "test", "user_agent": navigator.userAgent})',
  '1 + 1',
  'undefined',
  '1.0 + 1.0',
  '"test"',
];

Future<String> _getWebViewPath() async {
  final document = await getApplicationDocumentsDirectory();
  return p.join(
    document.path,
    'desktop_webview_window',
  );
}
