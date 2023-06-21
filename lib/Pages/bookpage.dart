import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:kitap_sarayi_app/Tools/Provider/library_provider.dart';
import 'package:kitap_sarayi_app/api/Models/books.dart';

class BookPage extends ConsumerStatefulWidget {
  const BookPage({required this.book, super.key});
  final Books book;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BookPageState();
}

class _BookPageState extends ConsumerState<BookPage> {
  late final Books book;
  @override
  void initState() {
    super.initState();
    book = widget.book;
  }

  @override
  Widget build(BuildContext context) {
    final referanceprovider = ref.watch(libraryProvider);
    final isLibrary = referanceprovider.libraryCheck(book.id!);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          book.name!,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: context.colorScheme.onBackground,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: Image.network(
                  book.book_img!,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            ListTile(
              title: Text(
                book.name!,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              subtitle: Text(
                book.author!,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ElevatedButton.icon(
                icon: Icon(isLibrary ? Icons.remove : Icons.add),
                label:
                    Text(isLibrary ? "Kitaplığımdan Çıkar" : "Kitaplığa Ekle"),
                onPressed: () {
                  if (isLibrary) {
                    referanceprovider.libraryRomove(book.id!);
                    referanceprovider.libraryBooks!.remove(book);
                  } else {
                    referanceprovider.libraryAdd(book.id!);
                    referanceprovider.libraryBooks!.add(book);
                  }
                  setState(() {});
                },
              ),
            ),
            Text(
              "Kitap Türü: ${book.book_type}",
              style: context.textTheme.headlineMedium,
            ),
            if (book.publisher == "")
              const SizedBox()
            else
              Text(
                "Yayın Evi: ${book.publisher}",
                style: context.textTheme.headlineMedium,
              ),
            if (book.publication_year == "")
              const SizedBox()
            else
              Text(
                "Yayın Yılı: ${book.publication_year}",
                style: context.textTheme.headlineMedium,
              ),
            if (book.pages_count == "")
              const SizedBox()
            else
              Text(
                "Sayfa Sayısı: ${book.pages_count}",
                style: context.textTheme.headlineMedium,
              ),
            Text(
              "ISBN: ${book.ISBN}",
              style: context.textTheme.headlineMedium,
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              "Kitap Açıklaması",
              style: context.textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                width: 500,
                child: Text(
                  book.explanation!,
                  style:
                      context.textTheme.headlineSmall!.copyWith(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }
}
