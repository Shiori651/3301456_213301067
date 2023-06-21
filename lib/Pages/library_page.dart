import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kitap_sarayi_app/Pages/home_page.dart';
import 'package:kitap_sarayi_app/Tools/Provider/library_provider.dart';

import 'package:kitap_sarayi_app/api/Models/books.dart';

class LibraryPage extends ConsumerStatefulWidget {
  const LibraryPage({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LibraryPageState();
}

class _LibraryPageState extends ConsumerState<LibraryPage> {
  @override
  void initState() {
    super.initState();
  }

  List<Books>? books;
  @override
  Widget build(BuildContext context) {
    books = ref.watch(libraryProvider).libraryBooks;
    return Scaffold(
      appBar: AppBar(title: const Text("Kütüphanem")),
      body: books == null
          ? const SizedBox()
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    BookShowWidget(books: books!),
                    const SizedBox(
                      height: 80,
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
