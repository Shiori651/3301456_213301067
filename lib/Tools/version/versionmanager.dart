import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class VersionManager {
  static bool isNeedUpdate({
    required String databasevalue,
    required String clientcvalue,
  }) {
    final deviceNumberSplit = clientcvalue.split('.').join();
    final databaseNumberSplit = databasevalue.split('.').join();

    final deviceNumber = int.tryParse(deviceNumberSplit);
    final databaseNumber = int.tryParse(databaseNumberSplit);
    if (deviceNumber == null || databaseNumber == null) {
      throw Exception("hata");
    }
    return deviceNumber < databaseNumber;
  }

  void showCustomDialog(BuildContext context, String url) {
    // ignore: inference_failure_on_function_invocation
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Sürüm Hatası"),
          content: const Text("Lütfen Uygulamayı Güncelleyin!"),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                _launchPlayStore(url);
              },
              child: const Text("Git"),
            )
          ],
        );
      },
    );
  }

  Future<void> _launchPlayStore(String urlS) async {
    final url = Uri.parse(urlS);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
