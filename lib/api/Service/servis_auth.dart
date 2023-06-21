import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kitap_sarayi_app/Pages/SplashHome/splash_home_view.dart';
import 'package:kitap_sarayi_app/Tools/language.dart';
import 'package:kitap_sarayi_app/api/Models/users.dart';
import 'package:kitap_sarayi_app/api/Service/service_database.dart';

class RegisterAuth {
  void check(
    String email,
    String password,
    String name,
    DateTime date,
    BuildContext context,
  ) {
    if (email != "" && password != "" && name != "") {
      registerUser(email, password, name, date, context);
    } else {
      dialogShow(context: context, content: RegisterTitle.errorTextfild);
    }
  }

  String dateDesign(DateTime fulldate) {
    return "${fulldate.year}/${fulldate.month}/${fulldate.day}";
  }

  Future<void> registerUser(
    String eposta,
    String password,
    String name,
    DateTime age,
    BuildContext context,
  ) async {
    late final UserCredential userCredential;
    final date = dateDesign(age);
    late String userid;
    try {
      userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: eposta, password: password);
      userid = userCredential.user!.uid;
      final user =
          Users(id: userid, birthDate: date, eposta: eposta, name: name);
      await UpdateDatabase().setAuthDatabase(user: user);

      // ignore: use_build_context_synchronously
      dialogShow(
        context: context,
        content: RegisterTitle.registed,
        isRegisted: true,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        dialogShow(content: RegisterTitle.passwordWeak, context: context);
      } else if (e.code == 'email-already-in-use') {
        dialogShow(content: RegisterTitle.epostaInUse, context: context);
      }
    } catch (e) {
      dialogShow(content: 'Hata: $e', context: context);
    }
  }
}

class LoginAuth {
  late UserCredential userCredential;
  late String userid;
  void check(String email, String password, BuildContext context) {
    if (email != "" && password != "") {
      login(email, password, context);
    } else {
      dialogShow(context: context, content: RegisterTitle.errorTextfild);
    }
  }

  Future<void> login(
    String eMail,
    String password,
    BuildContext context,
  ) async {
    try {
      userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: eMail,
        password: password,
      );
      userid = userCredential.user!.uid;
      // ignore: use_build_context_synchronously
      await Navigator.push(
        context,
        // ignore: inference_failure_on_instance_creation
        MaterialPageRoute(
          builder: (context) => SplashHomeView(userid: userid),
        ),
      );
    } catch (e) {
      dialogShow(context: context, content: LoginTitle.errorPassword);
    }
  }
}

// Her iki sınıfta aynı dialog showu kullandığı için buraya aldım.
void dialogShow({
  required BuildContext context,
  required String content,
  bool isRegisted = false,
}) {
  // ignore: inference_failure_on_function_invocation
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title:
            Text(isRegisted ? RegisterTitle.successful : RegisterTitle.warning),
        content: Text(content),
        actions: <Widget>[
          TextButton(
            child: const Text(RegisterTitle.okey),
            onPressed: () {
              Navigator.of(context).pop();
              if (isRegisted) {
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      );
    },
  );
}
