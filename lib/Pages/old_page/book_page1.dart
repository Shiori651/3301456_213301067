import 'package:flutter/material.dart';
import 'package:kitap_sarayi_app/Tools/books1.dart';
import 'package:kitap_sarayi_app/Tools/colorstheme.dart';
import 'package:kitap_sarayi_app/Tools/language.dart';
import 'package:kitap_sarayi_app/Tools/user.dart';
import 'package:kitap_sarayi_app/api/Service/service_storage.dart';

class Bookpage1 extends StatefulWidget {
  const Bookpage1({required this.isbn, super.key});
  final String isbn;

  @override
  State<Bookpage1> createState() => _Bookpage1State();
}

class _Bookpage1State extends State<Bookpage1> {
  late final int index;
  late final String bookISBN;
  late final String bookNAME;
  late final String bookEXPLANATION;

  late final dynamic data;
  late bool isReadList;
  late bool isLibary;
  @override
  void initState() {
    bookISBN = widget.isbn;
    index = Books1().isbnIndexSearch(bookISBN);
    data = Books1.books[index];
    bookNAME = Books1.books[index]["book_name"].toString();
    bookEXPLANATION = Books1.books[index]["book_aciklama"].toString();
    isReadList = Users1().checkReadList(bookISBN);
    isLibary = Users1().checkLibary(bookISBN);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(bookNAME),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          setState(() {
            isLibary = Users1().addRemoveLibary(bookISBN);
          });
        },
        backgroundColor: Colorstheme().libraryAddColor,
        icon: Icon(
          isLibary ? Icons.remove : Icons.add,
          color: Colorstheme().textColorwhite,
        ),
        label: Text(
          isLibary ? BookPageTitle.bookFloatRemove : BookPageTitle.bookFloatAdd,
          style: TextStyle(color: Colorstheme().textColorwhite),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Container(
                    decoration: BoxDecoration(color: Colorstheme().bookBack),
                    padding: const EdgeInsets.all(10),
                    height: 300,
                    child: ShowImage(imagePath: bookISBN),
                  ),
                ),
                Flexible(
                  child: SizedBox(
                    height: 300,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _bookFild(
                          title: BookPageTitle.bookName,
                          subtitle: bookNAME,
                        ),
                        _bookFild(
                          title: BookPageTitle.bookISBN,
                          subtitle: bookISBN,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: ElevatedButton.icon(
                            onPressed: () {
                              setState(() {
                                isReadList =
                                    Users1().addRemoveReadList(bookISBN);
                              });
                            },
                            icon: Icon(isReadList ? Icons.remove : Icons.add),
                            label: Text(
                              (isReadList
                                  ? BookPageTitle.bookElevateRemove
                                  : BookPageTitle.bookElevatedAdd),
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 13),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: _bookFild(
              title: BookPageTitle.bookExplanation,
              subtitle: bookEXPLANATION,
            ),
          ),
          //floatingActionButton yazıyı kapatmaması için
          const SizedBox(
            height: 60,
          )
        ],
      ),
    );
  }

  ListTile _bookFild({required String title, required String subtitle}) {
    return ListTile(
      title: _textWidget(title),
      subtitle: _textWidget(subtitle),
    );
  }

  Text _textWidget(String value) => Text(
        value,
        style: const TextStyle(fontSize: 16),
      );
}
