import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:kitap_sarayi_app/Tools/basil_theme.dart';
import 'package:kitap_sarayi_app/Tools/splash/splash_screen.dart';

import 'package:kitap_sarayi_app/api/Models/books.dart';

import 'package:kitap_sarayi_app/api/Service/servis_auth.dart';

class PopularBookChange extends StatefulWidget {
  const PopularBookChange({super.key});

  @override
  State<PopularBookChange> createState() => _PopularBookChangeState();
}

class _PopularBookChangeState extends State<PopularBookChange> {
  final theme = const BasilTheme();
  List<String> value = [];
  List<Books?> books = [];
  List<Books?> popularbooks = [];
  List<String> names = ["", "", "", "", ""];
  List<String> id = [];
  bool hasbooks = false;
  bool haspopulars = false;
  @override
  void initState() {
    super.initState();
    getpopular();
    getbooks();
  }

  Future<void> getpopular() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('popularbooks').get();
    popularbooks = snapshot.docs.map((doc) {
      id.add(doc.id);
      final jsonBody = doc.data();
      return Books.fromJson(jsonBody);
    }).toList();

    names.clear();
    setState(() {
      for (final value in popularbooks) {
        names.add(value!.name.toString());
      }
      haspopulars = true;
    });
  }

  Future<void> getbooks() async {
    final snapshot = await FirebaseFirestore.instance.collection('books').get();
    books = snapshot.docs.map((doc) {
      final jsonBody = doc.data();
      return Books.fromJson(jsonBody);
    }).toList();
    value.clear();
    for (var i = 0; i < books.length; i++) {
      value.add("${i + 1}- ${books[i]!.name}-${books[i]!.author}");
    }
    setState(() {
      hasbooks = true;
    });
  }

  void databaseupdate() {
    final ref = FirebaseFirestore.instance.collection("popularbooks");
    for (var index = 0; index < popularbooks.length; index++) {
      ref.doc(id[index]).update(popularbooks[index]!.toJson());
    }
    dialogShow(
      content: "Veri başarıyla eklendi.",
      context: context,
      isRegisted: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    const padding = EdgeInsets.symmetric(vertical: 16);

    if (!(hasbooks && haspopulars)) {
      return const SplashScreen();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Değiştir"),
      ),
      body: !(hasbooks && haspopulars)
          ? const SizedBox()
          : SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: padding,
                    child: columnAheadWidget(0, context),
                  ),
                  columnAheadWidget(1, context),
                  Padding(
                    padding: padding,
                    child: columnAheadWidget(2, context),
                  ),
                  columnAheadWidget(3, context),
                  Padding(
                    padding: padding,
                    child: columnAheadWidget(4, context),
                  ),
                  ElevatedButton(
                    onPressed: databaseupdate,
                    child: const Text("Güncelleme"),
                  ),
                  const SizedBox(
                    height: 150,
                  )
                ],
              ),
            ),
    );
    // ignore: dead_code
  }

  Column columnAheadWidget(int index, BuildContext context) {
    return Column(
      children: [
        Text(
          "${index + 1}. Popüler Kitap",
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TypeAheadField(
            textFieldConfiguration: TextFieldConfiguration(
              decoration: InputDecoration(
                hintText: names[index],
              ),
            ),
            suggestionsCallback: getSuggestions,
            itemBuilder: (context, suggestion) {
              return ListTile(
                title: Text(
                  suggestion,
                ),
              );
            },
            onSuggestionSelected: (suggestion) {
              final a = value.indexOf(suggestion);
              names[index] = books[a]!.name.toString();
              popularbooks[index] = books[a];
              setState(() {});
            },
          ),
        ),
      ],
    );
  }

  List<String> getSuggestions(String query) {
    final matches = <String>[];
    // ignore: cascade_invocations
    matches
      ..addAll(value)
      ..retainWhere(
        (suggestion) => suggestion.toLowerCase().contains(query.toLowerCase()),
      );
    return matches;
  }
}
