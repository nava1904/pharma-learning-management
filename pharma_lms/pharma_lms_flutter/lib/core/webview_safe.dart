import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:webview_flutter/webview_flutter.dart';

/// [webview_flutter_web] does not implement
/// [WebViewController.setJavaScriptMode] (throws [UnimplementedError]).
/// On mobile/desktop we enable unrestricted JS for embeds; on web, iframe
/// content behaves as the browser allows by default.
WebViewController webViewControllerWithDefaults() {
  final c = WebViewController();
  if (!kIsWeb) {
    c.setJavaScriptMode(JavaScriptMode.unrestricted);
  }
  return c;
}
