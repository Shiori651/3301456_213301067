import 'package:flutter/material.dart';
import 'package:kitap_sarayi_app/AppManager/product/enums/icon_constants.dart';
import 'package:kitap_sarayi_app/Tools/basil_theme.dart';

class ManagerHomePage extends StatelessWidget {
  const ManagerHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    const customMainAxis = MainAxisAlignment.spaceAround;
    const padding20 = EdgeInsets.symmetric(vertical: 20);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Uygulama Yönetimi"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: padding20,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: customMainAxis,
                children: <Widget>[
                  toContainerWidget(
                    enums: IconConstants.importexcel,
                    context,
                  ),
                  toContainerWidget(
                    enums: IconConstants.popularbooks,
                    context,
                  ),
                ],
              ),
              Padding(
                padding: padding20,
                child: Row(
                  mainAxisAlignment: customMainAxis,
                  children: <Widget>[
                    toContainerWidget(
                      enums: IconConstants.versionChecking,
                      context,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector toContainerWidget(
    BuildContext context, {
    required IconConstants enums,
  }) {
    const theme = BasilTheme();
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          // ignore: inference_failure_on_instance_creation
          MaterialPageRoute(
            builder: (context) => enums.toPage(),
          ),
        );
      },
      child: Container(
        width: 150,
        height: 180,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: Color(theme.themeColor().primaryContainer),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: enums.topng,
            ),
            enums.totitle()
          ],
        ),
      ),
    );
  }
}
