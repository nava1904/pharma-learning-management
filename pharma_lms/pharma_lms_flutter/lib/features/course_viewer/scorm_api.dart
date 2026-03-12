// ignore_for_file: avoid_escaping_inner_quotes

/// Builds HTML that injects SCORM 1.2 and 2004 API and loads content in an iframe (plan 2C).
/// The content looks for window.parent.API or window.parent.API_1484_11.
String buildScormWrapperHtml(String contentUrl) {
  final escapedUrl = contentUrl
      .replaceAll('&', '&amp;')
      .replaceAll('<', '&lt;')
      .replaceAll('>', '&gt;')
      .replaceAll('"', '&quot;');
  return '''
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>SCORM</title>
  <style>
    body { margin: 0; padding: 0; height: 100vh; }
    iframe { width: 100%; height: 100%; border: none; }
  </style>
</head>
<body>
  <iframe id="scorm_frame" src="$escapedUrl"></iframe>
  <script>
(function() {
  var store = {};
  function get(key) { return store[key] !== undefined ? String(store[key]) : ""; }
  function set(key, val) { store[key] = String(val); return true; }
  function commit() {
    try {
      if (window.ScormBridge && typeof window.ScormBridge.postMessage === "function") {
        window.ScormBridge.postMessage(JSON.stringify({ type: "commit", data: store }));
      }
    } catch (e) {}
    return true;
  }

  // SCORM 1.2 API
  window.API = {
    LMSGetValue: function(key) { return get(key); },
    LMSSetValue: function(key, val) { set(key, val); return "true"; },
    LMSCommit: function() { return commit() ? "true" : "false"; },
    LMSFinish: function() { return commit() ? "true" : "false"; },
    LMSGetLastError: function() { return "0"; },
    LMSGetErrorString: function() { return "No error"; },
    LMSGetDiagnostic: function() { return ""; }
  };

  // SCORM 2004 API
  window.API_1484_11 = {
    GetValue: function(elm) { return get(elm); },
    SetValue: function(elm, val) { set(elm, val); return true; },
    Commit: function() { return commit(); },
    Terminate: function() { return commit(); },
    GetLastError: function() { return "0"; },
    GetErrorString: function() { return ""; },
    GetDiagnostic: function() { return ""; }
  };
})();
  </script>
</body>
</html>
''';
}
