import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:kitap_sarayi_app/Tools/Provider/library_provider.dart';
import 'package:kitap_sarayi_app/Tools/Provider/readlist_provider.dart';
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
    final libaryReferanceprovider = ref.watch(libraryProvider);
    final readReferanceprovider = ref.watch(readlistProvider);
    final isLibrary = libaryReferanceprovider.libraryCheck(book.id!);
    final isReadList = readReferanceprovider.readListCheck(book.id!);
    final bookFeature = <String, String?>{
      "Kitap Türü": book.book_type,
      "Yayın Evi": book.publisher,
      "Yayın Yılı": book.publication_year,
      "Sayfa Sayısı": book.pages_count,
      "ISBN": book.ISBN
    }..removeWhere((key, value) => value == "");

    print(bookFeature);
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
              padding: const EdgeInsets.only(top: 10),
              child: ElevatedButton.icon(
                icon: Icon(isLibrary ? Icons.remove : Icons.add),
                label:
                    Text(isLibrary ? "Kitaplığımdan Çıkar" : "Kitaplığa Ekle"),
                onPressed: () {
                  if (isLibrary) {
                    libaryReferanceprovider.libraryRomove(book.id!);
                    libaryReferanceprovider.libraryBooks!.remove(book);
                  } else {
                    libaryReferanceprovider.libraryAdd(book.id!);
                    libaryReferanceprovider.libraryBooks!.add(book);
                  }
                  setState(() {});
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ElevatedButton.icon(
                icon: Icon(isReadList ? Icons.remove : Icons.add),
                label: Text(
                  isReadList ? "Okuma Listemden Çıkar" : "Okuma Listeme Ekle",
                ),
                onPressed: () {
                  if (isReadList) {
                    readReferanceprovider.readListRomove(book.id!);
                    readReferanceprovider.readlistBooks!.remove(book);
                  } else {
                    readReferanceprovider.readListAdd(book.id!);
                    readReferanceprovider.readlistBooks!.add(book);
                  }
                  setState(() {});
                },
              ),
            ),
            Text(
              "Kitap Türü: ${book.book_type}",
            ),
            if (book.publisher == "")
              const SizedBox()
            else
              Text(
                "Yayın Evi: ${book.publisher}",
              ),
            if (book.publication_year == "")
              const SizedBox()
            else
              Text(
                "Yayın Yılı: ${book.publication_year}",
              ),
            if (book.pages_count == "")
              const SizedBox()
            else
              Text(
                "Sayfa Sayısı: ${book.pages_count}",
              ),
            Text(
              "ISBN: ${book.ISBN}",
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
                  style: context.textTheme.headlineSmall!.copyWith(
                    fontSize: 17,
                    fontFamily: "Calibri",
                    fontStyle: FontStyle.italic,
                    wordSpacing: 5,
                  ),
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

  Row showField(String title, String value) {
    return const Row();
  }
}
