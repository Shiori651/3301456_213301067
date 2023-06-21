// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_database/firebase_database.dart';

class Users1 {
  static String name = "";
  static String eposta = "";
  static String age = "";

  void set({
    required String namedata,
    required String epostadata,
    required String agedata,
  }) {
    name = namedata;
    age = agedata;
    eposta = epostadata;
  }

  static List<dynamic> libary = [];
  static List<dynamic> readList = [];
  static String userkey = "";

  bool checkLibary(String data) {
    if (libary.contains(data)) {
      return true;
    }
    return false;
  }

  bool checkReadList(String data) {
    if (readList.contains(data)) {
      return true;
    }
    return false;
  }

  bool addRemoveLibary(String data) {
    if (checkLibary(data)) {
      final gecici = <dynamic>[];
      final index = libary.indexOf(data);
      for (var i = 0; i < libary.length; i++) {
        if (i != index) {
          gecici.add(libary[i]);
        }
      }
      libary = gecici;
      updatelibary();
      return false;
    } else {
      libary = [...libary, data];
      updatelibary();
      return true;
    }
  }

  Future<void> updatelibary() async {
    final dbRef = FirebaseDatabase.instance.ref();
    await dbRef.child('User').child(userkey).update({"libary": libary});
  }

  bool addRemoveReadList(String data) {
    if (checkReadList(data)) {
      final gecici = <dynamic>[];
      final index = readList.indexOf(data);
      for (var i = 0; i < readList.length; i++) {
        if (i != index) {
          gecici.add(readList[i]);
        }
      }
      readList = gecici;
      updatereadList();
      return false;
    } else {
      readList = [...readList, data];
      updatereadList();
      return true;
    }
  }

  Future<void> updatereadList() async {
    final dbRef = FirebaseDatabase.instance.ref();
    await dbRef.child('User').child(userkey).update({"readList": readList});
  }
}
