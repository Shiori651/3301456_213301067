import 'package:flutter/material.dart';
import 'package:kitap_sarayi_app/Tools/books1.dart';
import 'package:kitap_sarayi_app/Tools/language.dart';
import 'package:kitap_sarayi_app/Tools/user.dart';
import 'package:kitap_sarayi_app/Widgets/book_view.dart';

class BooksWidgetGet extends StatefulWidget {
  const BooksWidgetGet({required this.appbar, super.key});

  final String appbar;
  //Burada gelcek olan değerlin kitapların datası mı yoksa Libary veya readlist olup olmadığını kontrol ediyoruz.
  @override
  State<BooksWidgetGet> createState() => _BooksWidgetGetState();
}

class _BooksWidgetGetState extends State<BooksWidgetGet> {
  bool cift = true;

  List<dynamic> listISBN = [];
  int count = 0;
  int listCount = 0;
  late final String appbar;
  List<dynamic> data = [];
  @override
  void initState() {
    super.initState();
    appbar = widget.appbar;
    if (appbar == HomePageTitle.homeAppbarTitle) {
      data = Books1.books;
      isbnList();
    } else if (appbar == HomePageTitle.libraryAppbarTitle) {
      listISBN = Users1.libary;
    } else {
      listISBN = Users1.readList;
    }
    listCount = listISBN.length;
    count = listCount ~/ 2;
    cift = listCount.isEven;
  }

  void isbnList() {
    for (var i = 0; i < data.length; i++) {
      listISBN.add(data[i]['book_ISBN'].toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: appbar != HomePageTitle.homeAppbarTitle
            ? reflesh()
            : homePageExit(context),
        title: Text(appbar),
      ),
      body: ListView.builder(
        itemCount: cift ? count : count + 1,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: (cift || (index != count))
                      ? [
                          BookView(bookISBN: listISBN[2 * index].toString()),
                          BookView(bookISBN: listISBN[2 * index + 1].toString())
                        ]
                      : [BookView(bookISBN: listISBN[2 * index].toString())],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  IconButton reflesh() => IconButton(
        icon: const Icon(Icons.refresh),
        onPressed: () {
          setState(() {
            if (appbar == HomePageTitle.libraryAppbarTitle) {
              listISBN = Users1.libary;
            } else {
              listISBN = Users1.readList;
            }
          });
          listCount = listISBN.length;
          count = listCount ~/ 2;
          cift = listCount.isEven;
        },
      );

  IconButton homePageExit(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.exit_to_app),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
