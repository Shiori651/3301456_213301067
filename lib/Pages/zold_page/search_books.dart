// import 'package:flutter/material.dart';
// import 'package:kitap_sarayi_app/Tools/books1.dart';
// import 'package:kitap_sarayi_app/Tools/colorstheme.dart';
// import 'package:kitap_sarayi_app/Tools/language.dart';
// import 'package:kitap_sarayi_app/Tools/user.dart';
// import 'package:kitap_sarayi_app/Widgets/book_view.dart';
// import 'package:kitap_sarayi_app/main.dart';

// class SearchBooks extends StatefulWidget {
//   const SearchBooks({super.key});

//   @override
//   State<SearchBooks> createState() => _SearchBooksState();
// }

// class _SearchBooksState extends State<SearchBooks> {
//   late final List<dynamic> data;
//   bool isLibary = false;
//   int index = 0;
//   String isbn = "";
//   String bookName = "";
//   String hint = "";
//   @override
//   void initState() {
//     data = Books1.books;
//     isbn = data[0]['book_ISBN'].toString();
//     hint = data[0]['book_name'].toString();
//     isLibary = Users1().checkLibary(isbn);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Kitap Arama')),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.only(top: 15, bottom: 10),
//           child: Column(
//             children: [
//               DropdownButton(
//                 value: isbn,
//                 icon: const Icon(Icons.arrow_downward),
//                 style: TextStyle(
//                   color: themeManager.themeMode == ThemeMode.dark
//                       ? Colorstheme().textColorwhite
//                       : Colorstheme().textColorBlack,
//                   fontSize: 13,
//                 ),
//                 onChanged: (value) {
//                   setState(() {
//                     isbn = value.toString();
//                     index = Books1().isbnIndexSearch(isbn);
//                     bookName = data[index]['book_name'].toString();
//                     isLibary = Users1().checkLibary(isbn);
//                   });
//                 },
//                 items: data.map<DropdownMenuItem<dynamic>>((dynamic value) {
//                   return DropdownMenuItem<dynamic>(
//                     value: value['book_ISBN'].toString(),
//                     child: Text(value["book_name"].toString()),
//                   );
//                 }).toList(),
//               ),
//               Column(
//                 children: [
//                   BookView(bookISBN: isbn),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 15),
//                     child: ElevatedButton.icon(
//                       style: ButtonStyle(
//                         backgroundColor: MaterialStateProperty.all<Color>(
//                           Colorstheme().libaryAddColor,
//                         ),
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           isLibary = Users1().addRemoveLibary(isbn);
//                         });
//                       },
//                       icon: Icon(isLibary ? Icons.remove : Icons.add),
//                       label: Text(
//                         (isLibary
//                             ? SearchTitle.bookLibaryRemove
//                             : SearchTitle.bookLibaryAdd),
//                         textAlign: TextAlign.center,
//                         style: const TextStyle(fontSize: 13),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
