import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kitap_sarayi_app/Tools/language.dart';
import 'package:kitap_sarayi_app/api/Models/users.dart';

import 'package:kitap_sarayi_app/main.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({required this.user, super.key});
  final Users user;
  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  String name = "";
  String birthDate = "";
  String eposta = "";

  @override
  void initState() {
    name = widget.user.name ?? "";
    birthDate = widget.user.birthDate ?? "";
    eposta = widget.user.eposta ?? "";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(SettingTitle.appbarTitle),
        leading: const SizedBox(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const Row(
              children: [
                Icon(
                  Icons.person,
                  size: 30,
                ),
                SizedBox(width: 10),
                Text(
                  SettingTitle.personTitle,
                  style: TextStyle(
                    fontSize: 17,
                  ),
                )
              ],
            ),
            personData(title: SettingTitle.epostTitle, subTitle: eposta),
            personData(title: SettingTitle.nameTitle, subTitle: name),
            personData(title: SettingTitle.birthTitle, subTitle: birthDate),
            const Row(
              children: [
                Icon(
                  Icons.settings,
                  size: 30,
                ),
                SizedBox(width: 10),
                Text(
                  SettingTitle.appSettingTitle,
                  style: TextStyle(fontSize: 17),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(SettingTitle.themeTitle),
                  CupertinoSwitch(
                    value: themeManager.themeMode == ThemeMode.dark,
                    onChanged: (value) {
                      setState(() {});
                      themeManager.toggletheme(value);
                    },
                    activeColor: Colors.blue,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ListTile personData({required String title, required String subTitle}) =>
      ListTile(title: Text(title), subtitle: Text(subTitle));
}
