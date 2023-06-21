import 'package:flutter/material.dart';
import 'package:kitap_sarayi_app/Pages/zold_page/book_page1.dart';
import 'package:kitap_sarayi_app/Tools/books1.dart';
import 'package:kitap_sarayi_app/Tools/colorstheme.dart';
import 'package:kitap_sarayi_app/api/Service/service_storage.dart';

class BookView extends StatefulWidget {
  const BookView({required this.bookISBN, super.key});
  final String bookISBN;
  @override
  State<BookView> createState() => _BookViewState();
}

class _BookViewState extends State<BookView> {
  late final int index;
  late final String isbn;
  late final String name;
  @override
  void initState() {
    super.initState();
  }

  String getName() {
    final index = Books1().isbnIndexSearch(widget.bookISBN);
    return Books1.books[index]['book_name'].toString();
  }

  @override
  Widget build(BuildContext context) {
    // Kitabın üstüne tıkladığımızda o kitabın listenin içindekiindexi ile kitap sayfasına giden kod.
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          // ignore: inference_failure_on_instance_creation
          MaterialPageRoute(
            builder: (context) => Bookpage1(isbn: widget.bookISBN),
          ),
        );
      },
      child: Container(
        height: 300,
        width: 170,
        decoration: BoxDecoration(
          color: Colorstheme().bookBack,
          borderRadius: const BorderRadius.all(Radius.circular(7)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //Servis klasöründeki Firebse dosyasının içindeki fonksiyonu çağırarak Firebase Storageden image getiriyor.
            ShowImage(imagePath: widget.bookISBN),
            Text(
              getName(),
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(color: Colorstheme().textColorBlack),
            )
          ],
        ),
      ),
    );
  }
}
