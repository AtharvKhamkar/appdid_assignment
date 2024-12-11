import 'package:url_launcher/url_launcher.dart';

class AppUtils {
  Future<void> launchURL(String url, {LaunchMode? mode}) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(
        Uri.parse(url),
        mode: mode ?? LaunchMode.inAppWebView,
      );
    } else {
      throw 'Could not launch URL';
    }
  }
}
