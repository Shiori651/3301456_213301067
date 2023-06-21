import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:kitap_sarayi_app/api/Models/books.dart';

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
    String? name,
    String? isbn,
    String? author,
    String? publisher,
    String? booktype,
  }) async {
    print(booktype);
  }
}

final searchProvider =
    ChangeNotifierProvider<SearchProvider>((ref) => SearchProvider());
