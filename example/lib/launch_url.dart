import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

/// Launch the requested [url] in the default browser.
Future<bool> launchURL(String url) async {
  final uri = Uri.tryParse(url);

  if (uri == null) {
    debugPrint('Unable to parse url: $url');
    return false;
  }

  try {
    return await url_launcher.launchUrl(uri);
  } on PlatformException catch (e) {
    debugPrint('Could not launch url: $url, $e');
    return false;
  }
}
