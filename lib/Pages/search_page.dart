import 'package:flutter/material.dart';
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
  TextEditingController name = TextEditingController();
  TextEditingController author = TextEditingController();
  TextEditingController publisher = TextEditingController();
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

  List<String> category = [];
  String selectedValue = "";
  bool searching = false;
  List<Books>? books;
  bool isget = false;
  bool notfirt = false;
  @override
  Widget build(BuildContext context) {
    final providerRef = ref.watch(searchProvider);

    ref.listen(
      searchProvider,
      (previous, next) {
        print(next.books!.isEmpty);
        setState(() {
          if (next.havebooks()) {
            books = next.books;
            isget = true;
          } else {
            if (books != null) {
              books!.clear();
            }
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
              SizedBox(
                width: 375,
                child: TextField(
                  controller: name,
                  decoration: const InputDecoration(
                    border: borderradius,
                    label: Text("Kitap Adı:"),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textFieldWidget("Yazar:", author),
                  textFieldWidget("Yayın Evi:", publisher),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 180,
                    child: TextField(
                      controller: isbn,
                      keyboardType: TextInputType.number,
                      maxLength: 13,
                      decoration: const InputDecoration(
                        border: borderradius,
                        label: Text("ISBN"),
                      ),
                    ),
                  ),
                  dropButtonWidget(),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    providerRef.searchget(
                      name: name.text,
                      author: author.text,
                      publisher: publisher.text,
                      isbn: isbn.text,
                      booktype: selectedValue,
                    );
                    notfirt = true;
                    searching = true;
                  });
                },
                icon: searching
                    ? const Icon(Icons.cloud_download)
                    : const Icon(Icons.search),
                label: searching ? const Text("Aranıyor") : const Text("Ara"),
              ),
              if (!searching && !isget && notfirt)
                const Text("Kitap Bulunamadı"),
              if (!isget) const SizedBox() else CategoryBookShow(books: books)
            ],
          ),
        ),
      ),
    );
  }

  SizedBox textFieldWidget(String title, TextEditingController controller) {
    return SizedBox(
      width: 180,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: borderradius,
          label: Text(title),
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
        onChanged: (newValue) {
          setState(() {
            selectedValue = newValue!;
          });
        },
      ),
    );
  }
}
