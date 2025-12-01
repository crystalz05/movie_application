


import 'package:url_launcher/url_launcher.dart';

class Utils {
  static Future<void> openUrl(String uri) async {
    final url = Uri.parse(uri);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }
}