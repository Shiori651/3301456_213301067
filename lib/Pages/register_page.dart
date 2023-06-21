import 'package:cupertino_date_textbox/cupertino_date_textbox.dart';
import 'package:flutter/material.dart';
import 'package:kitap_sarayi_app/Tools/basil_theme.dart';
import 'package:kitap_sarayi_app/Tools/language.dart';
import 'package:kitap_sarayi_app/Widgets/text_fild.dart';
import 'package:kitap_sarayi_app/api/Service/servis_auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final logoPath = "assets/Logo/selcuklogo.jpg";
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final TextEditingController namecontroller = TextEditingController();
  final double padding = 10;
  DateTime _selectedDateTime = DateTime.now();

  static const borderradius =
      OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(RegisterTitle.appbartitle),
      ),
      body: Padding(
        padding: EdgeInsets.all(padding),
        child: ListView(
          children: [
            SizedBox(height: 200, child: Image.asset(logoPath)),
            TextFieldEpostaPassword(
              emailcontroller: emailcontroller,
              passwordcontroller: passwordcontroller,
            ),
            nameAge(),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ElevatedButton.icon(
                onPressed: () {
                  RegisterAuth().check(
                    emailcontroller.text,
                    passwordcontroller.text,
                    namecontroller.text,
                    _selectedDateTime,
                    context,
                  );
                },
                icon: const Icon(Icons.person_add_alt),
                label: const Text(RegisterTitle.registerTitle),
              ),
            )
          ],
        ),
      ),
    );
  }

  Column nameAge() {
    const theme = BasilTheme();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: TextField(
            controller: namecontroller,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              border: borderradius,
              label: Text(RegisterTitle.textFildname),
            ),
          ),
        ),
        CupertinoDateTextBox(
          initialValue: _selectedDateTime,
          color: Color(theme.themeColor().primary),
          onDateChange: (DateTime birthday) {
            _selectedDateTime = birthday;
          },
          hintText: _selectedDateTime.toString(),
        ),
      ],
    );
  }
}
