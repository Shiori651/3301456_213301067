import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:kitap_sarayi_app/api/Models/books.dart';

class ReadlistProvider extends ChangeNotifier {
  String userid = "";
  List<String> readlistListID = [];
  List<Books>? readlistBooks;

  bool readListCheck(String book) {
    return readlistListID.contains(book);
  }
}

final readlistProvider =
    ChangeNotifierProvider<ReadlistProvider>((ref) => ReadlistProvider());
