import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:kitap_sarayi_app/api/Models/books.dart';
import 'package:kitap_sarayi_app/api/Service/service_database.dart';

class SearchProvider extends ChangeNotifier {
  List<Books>? books;

  bool havebooks() {
    if (books != null) {
      return books!.isNotEmpty;
    } else {
      return false;
    }
  }

  Future<void> searchget({
    required String name,
    required String isbn,
    required String author,
    required String publisher,
    required String booktype,
  }) async {
    if (booktype == "Tümü") booktype = "";
    books = await FirebaseGet().getSearch(
      name: name,
      author: author,
      publisher: publisher,
      ISBN: isbn,
      book_type: booktype,
    );
    notifyListeners();
  }
}

final searchProvider =
    ChangeNotifierProvider<SearchProvider>((ref) => SearchProvider());
