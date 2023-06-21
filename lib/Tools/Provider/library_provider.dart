import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kitap_sarayi_app/api/Models/books.dart';
import 'package:kitap_sarayi_app/api/Service/service_database.dart';

class LibraryCange extends ChangeNotifier {
  String userid = "";
  List<String> libraryListID = [];
  List<Books>? libraryBooks;
  void libraryAdd(String book) {
    libraryListID.add(book);
    UpdateDatabase().addLibrary(book, userid);
    notifyListeners();
  }

  void libraryRomove(String book) {
    libraryListID.remove(book);
    UpdateDatabase().removeLibrary(book, userid);
    notifyListeners();
  }

  bool libraryCheck(String book) {
    return libraryListID.contains(book);
  }

  Future<void> getLibraryProvider() async {
    libraryBooks = await FirebaseGet().getLibraryBooks(libraryListID);
    notifyListeners();
  }
}

final libraryProvider =
    ChangeNotifierProvider<LibraryCange>((ref) => LibraryCange());
