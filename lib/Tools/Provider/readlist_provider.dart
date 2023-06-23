import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:kitap_sarayi_app/api/Models/books.dart';

import 'package:kitap_sarayi_app/api/Service/service_database.dart';

class ReadlistProvider extends ChangeNotifier {
  String userid = "";
  List<String> readlistListID = [];
  List<Books> readlistBooks = [];

  bool readListCheck(String book) {
    return readlistListID.contains(book);
  }

  void readListAdd(String book) {
    readlistListID.add(book);
    UpdateDatabase().addReadList(book, userid);
    notifyListeners();
  }

  void readListRomove(String book) {
    readlistListID.remove(book);
    UpdateDatabase().removeReadList(book, userid);
    notifyListeners();
  }

  Future<void> getreadListProvider() async {
    readlistBooks = await FirebaseGet().getDocIdBooks(readlistListID);
    notifyListeners();
  }

  void reset() {
    userid = "";
    readlistListID = [];
    readlistBooks.clear();
  }
}

final readlistProvider =
    ChangeNotifierProvider<ReadlistProvider>((ref) => ReadlistProvider());
