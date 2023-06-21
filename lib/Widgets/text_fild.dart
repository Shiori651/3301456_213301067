import 'package:flutter/material.dart';
import 'package:kitap_sarayi_app/Tools/language.dart';

class TextFieldEpostaPassword extends StatelessWidget {
  const TextFieldEpostaPassword({
    required this.emailcontroller,
    required this.passwordcontroller,
    super.key,
  });

  final TextEditingController emailcontroller;
  final TextEditingController passwordcontroller;
  static const borderradius =
      OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)));

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: TextField(
            controller: emailcontroller,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              border: borderradius,
              label: Text(LoginTitle.textfildEposta),
            ),
          ),
        ),
        TextField(
          obscureText: true,
          controller: passwordcontroller,
          keyboardType: TextInputType.visiblePassword,
          textInputAction: TextInputAction.done,
          decoration: const InputDecoration(
            border: borderradius,
            label: Text(
              LoginTitle.textfildSifre,
            ),
          ),
        ),
      ],
    );
  }
}
