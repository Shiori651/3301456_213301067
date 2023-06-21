import 'package:flutter/material.dart';
import 'package:kitap_sarayi_app/AppManager/Pages/manager_home_page.dart';
import 'package:kitap_sarayi_app/Pages/register_page.dart';
import 'package:kitap_sarayi_app/Tools/colorstheme.dart';
import 'package:kitap_sarayi_app/Tools/language.dart';
import 'package:kitap_sarayi_app/Widgets/text_fild.dart';
import 'package:kitap_sarayi_app/api/Service/servis_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final logoPath = 'assets/Logo/selcuklogo.jpg';
  double padding = 10;

  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(LoginTitle.appbarTitle),
        leading: const SizedBox(),
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
            Padding(
              padding: EdgeInsets.only(top: padding),
              child: ElevatedButton.icon(
                onPressed: () {
                  LoginAuth().check(
                    emailcontroller.text,
                    passwordcontroller.text,
                    context,
                  );
                },
                label: const Text("Giriş Yap"),
                icon: const Icon(Icons.login),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colorstheme().bookBack,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  // ignore: inference_failure_on_instance_creation
                  MaterialPageRoute(
                    builder: (context) => const RegisterPage(),
                  ),
                );
              },
              child: const Text(LoginTitle.registerTitle),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  // ignore: inference_failure_on_instance_creation
                  MaterialPageRoute(
                    builder: (context) => const ManagerHomePage(),
                  ),
                );
              },
              child: const Text("Yönetici bölgesi"),
            ),
          ],
        ),
      ),
    );
  }
}
