import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kitap_sarayi_app/AppManager/product/version_provider.dart';
import 'package:kitap_sarayi_app/Tools/splash/splash_screen.dart';
import 'package:kitap_sarayi_app/api/Models/version.dart';

class VersionControlPage extends ConsumerStatefulWidget {
  const VersionControlPage({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      VersionControlPageState();
}

class VersionControlPageState extends ConsumerState<VersionControlPage> {
  static const borderradius =
      OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)));

  TextEditingController androidVersionController = TextEditingController();
  TextEditingController androidStoreController = TextEditingController();
  TextEditingController iosVersionController = TextEditingController();
  TextEditingController iosStoreController = TextEditingController();

  @override
  void initState() {
    super.initState();
    ref.read(versionProvider).getVersion();
  }

  Version? android;
  Version? ios;
  bool isgo = false;
  @override
  Widget build(BuildContext context) {
    ref.listen(versionProvider, (previous, next) {
      if (next.android != null && next.ios != null) {
        android = next.android;
        ios = next.ios;
        isgo = true;
        androidVersionController.text = android!.number!;
        androidStoreController.text = android!.store!;
        iosVersionController.text = ios!.number!;
        iosStoreController.text = ios!.store!;
      }
      setState(() {});
    });
    if (!isgo) {
      return const SplashScreen();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verison Control"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              textFieldWidget(
                controller: androidVersionController,
                label: "Android Version",
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: textFieldWidget(
                  controller: androidStoreController,
                  label: "Android Store URL",
                ),
              ),
              textFieldWidget(
                controller: iosVersionController,
                label: "iOS Version",
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: textFieldWidget(
                  controller: iosStoreController,
                  label: "iOS Store URL",
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  ref.read(versionProvider).updateVersion(
                        android: Version(
                          number: androidVersionController.text,
                          store: androidStoreController.text,
                        ),
                        ios: Version(
                          number: iosVersionController.text,
                          store: iosStoreController.text,
                        ),
                      );
                },
                icon: const Icon(Icons.save_alt_outlined),
                label: const Text("Kaydet"),
              )
            ],
          ),
        ),
      ),
    );
  }

  SizedBox textFieldWidget({
    required TextEditingController controller,
    required String label,
  }) {
    return SizedBox(
      width: 375,
      child: TextField(
        controller: controller,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        decoration: InputDecoration(
          border: borderradius,
          label: Text(label),
        ),
      ),
    );
  }
}
