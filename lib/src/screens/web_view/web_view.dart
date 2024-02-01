import 'package:flutter/material.dart';
import 'package:web_browser/web_browser.dart';

final class WebViewScreenPayload {
  final String url;

  const WebViewScreenPayload({required this.url});
}

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({
    Key? key,
    required this.payload,
  }) : super(key: key);

  static const path = '/webview';
  final WebViewScreenPayload payload;

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Browser(
          initialUriString: widget.payload.url,
        ),
      ),
    );
  }
}
