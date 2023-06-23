import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kitap_sarayi_app/Pages/SplashCategory/splash_category_view.dart';
import 'package:kitap_sarayi_app/Tools/Provider/search_provider.dart';
import 'package:kitap_sarayi_app/Tools/database_key.dart';
import 'package:kitap_sarayi_app/api/Models/books.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  TextEditingController textfildController = TextEditingController();
  TextEditingController isbn = TextEditingController();
  static const borderradius =
      OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)));

  @override
  void initState() {
    super.initState();
    category.addAll(DatabaseKey.category);
    category.insert(0, "Tümü");
    selectedValue = category[0];
  }

  String kitapad = "Kitap Adı";
  String author = "Yazar";
  String publisher = "Yayıncı";

  List<String> category = [];
  String selectedValue = "";
  bool searching = false;
  List<Books>? books;
  bool isget = false;
  bool notfirt = false;
  bool isEnable = true;
  bool isEnablebutton = true;

  String selectedOption = "name";
  String textfildTitle = "Kitap Adı";
  @override
  Widget build(BuildContext context) {
    final providerRef = ref.watch(searchProvider);

    ref.listen(
      searchProvider,
      (previous, next) {
        setState(() {
          if (next.havebooks()) {
            books = next.books;
            isget = true;
            notfirt = false;
          } else {
            if (books != null) {
              books!.clear();
            }
            notfirt = true;
          }
          searching = false;
        });
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Kitap Ara"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  Radio(
                    value: "name",
                    groupValue: selectedOption,
                    onChanged: isEnable
                        ? (value) {
                            setState(() {
                              selectedOption = value.toString();
                              textfildTitle = kitapad;
                            });
                          }
                        : null,
                  ),
                  Text(kitapad),
                  Radio(
                    value: "author",
                    groupValue: selectedOption,
                    onChanged: isEnable
                        ? (value) {
                            setState(() {
                              selectedOption = value.toString();
                              textfildTitle = author;
                            });
                          }
                        : null,
                  ),
                  Text(author),
                  Radio(
                    value: "publisher",
                    groupValue: selectedOption,
                    onChanged: isEnable
                        ? (value) {
                            setState(() {
                              selectedOption = value.toString();
                              textfildTitle = publisher;
                            });
                          }
                        : null,
                  ),
                  Text(publisher),
                ],
              ),
              textFieldWidget(),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  isbnTextField(),
                  dropButtonWidget(),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton.icon(
                icon: searching
                    ? const Icon(Icons.cloud_download)
                    : const Icon(Icons.search),
                label: searching ? const Text("Aranıyor") : const Text("Ara"),
                onPressed: isEnablebutton
                    ? () {
                        setState(() {
                          if (isbn.text == "") {
                            providerRef.searchget(
                              searchText: textfildController.text,
                              booktype: selectedValue,
                              searchType: selectedOption,
                            );
                          } else {
                            providerRef.searchget(isbn: isbn.text);
                          }
                          searching = true;
                        });
                      }
                    : null,
              ),
              if (notfirt) const Text("Aradığınız Kitap Bulunamadı"),
              if (!isget) const SizedBox() else CategoryBookShow(books: books)
            ],
          ),
        ),
      ),
    );
  }

  SizedBox isbnTextField() {
    return SizedBox(
      width: 180,
      child: TextField(
        controller: isbn,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        keyboardType: TextInputType.number,
        maxLength: 13,
        onChanged: (value) {
          setState(() {
            isbncheck(value);
          });
        },
        decoration: const InputDecoration(
          border: borderradius,
          label: Text("ISBN"),
        ),
      ),
    );
  }

  void isbncheck(String value) {
    if (value.isEmpty) {
      isEnable = true;
    } else {
      isEnable = false;
    }
    if (value.length == 13 || value.isEmpty) {
      isEnablebutton = true;
    } else {
      isEnablebutton = false;
    }
  }

  SizedBox textFieldWidget() {
    return SizedBox(
      width: 375,
      child: TextField(
        enabled: isEnable,
        controller: textfildController,
        decoration: InputDecoration(
          border: borderradius,
          label: Text(textfildTitle),
        ),
      ),
    );
  }

  SizedBox dropButtonWidget() {
    return SizedBox(
      width: 180,
      child: DropdownButtonFormField(
        value: selectedValue,
        items: category.map((value) {
          return DropdownMenuItem(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: isEnable
            ? (newValue) {
                setState(() {
                  selectedValue = newValue.toString();
                });
              }
            : null,
      ),
    );
  }
}
