import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:kitap_sarayi_app/Pages/home_page.dart';
import 'package:kitap_sarayi_app/Tools/Provider/library_provider.dart';
import 'package:kitap_sarayi_app/Tools/Provider/readlist_provider.dart';
import 'package:kitap_sarayi_app/api/Models/books.dart';
import 'package:kitap_sarayi_app/api/Service/service_database.dart';
class BookData {

  BookData({
    required this.isLibrary,
    required this.isReadList,
    required this.books,
    required this.bookFeature,
  });
  final bool isLibrary;
  final bool isReadList;
  final List<Books> books;
  final Map<String, String?> bookFeature;
}
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
  Future<BookData> _fetchBookData() async {
    final firebaseGet = FirebaseGet();
    final libaryReferanceprovider = ref.watch(libraryProvider);
    final readReferanceprovider = ref.watch(readlistProvider);
    final isLibrary = libaryReferanceprovider.libraryCheck(book.id!);
    final isReadList = readReferanceprovider.readListCheck(book.id!);
    final recoBooks = await firebaseGet.fetchRecommendations(book.id!);

   var books = <Books>[];
    if(recoBooks.isNotEmpty){

      books = await firebaseGet.getDocIdBooks(recoBooks);
    }

    final bookFeature = <String, String?>{
      "Kitap Türü": book.book_type,
      "Yayın Evi": book.publisher,
      "Yayın Yılı": book.publication_year,
      "Sayfa Sayısı": book.pages_count,
      "ISBN": book.ISBN,
    }..removeWhere((key, value) => value == "");

    return BookData(
      isLibrary: isLibrary,
      isReadList: isReadList,
      books: books,
      bookFeature: bookFeature,
    );
  }

  @override
  Widget build(BuildContext context) {
    final libaryReferanceprovider2 = ref.watch(libraryProvider);
    final readReferanceprovider2 = ref.watch(readlistProvider);
    return
      FutureBuilder(
          future: _fetchBookData(),
          builder: (context,snapshot){
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  book.name!,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
              ),
              body: const Center(child: CircularProgressIndicator()),
            );
          }
          else if (snapshot.hasError){
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  book.name!,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
              ),
              body: Center(child: Text('Hata: ${snapshot.error}')),
            );
          }else if (snapshot.hasData){
            final data = snapshot.data!;
            return  Scaffold(
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
                        borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                        ),
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
                        const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: Text(
                        book.author!,
                        textAlign: TextAlign.center,
                        style:
                        const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: ElevatedButton.icon(
                        icon: Icon(data.isLibrary ? Icons.remove : Icons.add),
                        label:
                        Text(
                            data.isLibrary ?
                            "Kitaplığımdan Çıkar" :
                            "Kitaplığa Ekle",
                        ),
                        onPressed: () {
                          if (data.isLibrary) {

                            libaryReferanceprovider2.libraryRomove(book.id!);
                            libaryReferanceprovider2.libraryBooks.remove(book);
                          } else {
                            libaryReferanceprovider2.libraryAdd(book.id!);
                            libaryReferanceprovider2.libraryBooks.add(book);
                          }
                          setState(() {});
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: ElevatedButton.icon(
                        icon: Icon(data.isReadList ? Icons.remove : Icons.add),
                        label: Text(
                          data.isReadList ?
                          "Okuma Listemden Çıkar" :
                          "Okuma Listeme Ekle",
                        ),
                        onPressed: () {
                          if (data.isReadList) {
                            readReferanceprovider2.readListRomove(book.id!);
                            readReferanceprovider2.readlistBooks.remove(book);
                          } else {
                            readReferanceprovider2.readListAdd(book.id!);
                            readReferanceprovider2.readlistBooks.add(book);
                          }
                          setState(() {});
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(13),
                      child: showFieldTitle(data.bookFeature),
                    ),
                    if (data.books.isNotEmpty) Padding(
                      padding: const EdgeInsets.all(13),
                      child: recommendBook(data.books,context),
                    ) else const Padding(
                      padding: EdgeInsets.all(13),
                      child: Text("Tavsiye Bulunamadı"),
                    ),
                    Text(
                      "Kitap Açıklaması",
                      style: context.textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(13),
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
                    ),
                  ],
                ),
              ),
            );
          }else {
              return Scaffold(
                appBar: AppBar(
                  title: Text(
                    book.name!,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                ),
                body: const Center(child: Text('Veri bulunamadı.')),
              );
            }
        },
      );
  }

  Row showFieldTitle(Map<String, String?> value) {
    return Row(
      children: [
        SizedBox(
          width: 100,
          height: 110,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              value.length,
              (index) => Text(value.keys.elementAt(index)),
            ),
          ),
        ),
        SizedBox(
          width: 200,
          height: 110,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              value.length,
              (index) => Text(":${value.values.elementAt(index)}"),
            ),
          ),
        ),
      ],
    );
  }
  Column recommendBook(List<Books> books, BuildContext context) {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Tavsiye Edilen Kitaplar",
            ),
            SizedBox(),
          ],
        ),
        SizedBox(
          height: 300,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: books.length,
            itemBuilder: (context, index) {
              final book = books[index];
              return Padding(
                padding: const EdgeInsets.only(top: 10, right: 10),
                child: BookImgAndTitle(book: book),
              );
            },
          ),
        ),
      ],
    );
  }
}
