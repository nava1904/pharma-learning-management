import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_web/webview_flutter_web.dart';

/// `webview_flutter_web` is not endorsed yet; set the platform before any WebView use.
void registerWebViewPlatformForWeb() {
  WebViewPlatform.instance = WebWebViewPlatform();
}
