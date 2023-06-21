import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kitap_sarayi_app/Pages/SplashCategory/splash_category_provider.dart';
import 'package:kitap_sarayi_app/Pages/home_page.dart';
import 'package:kitap_sarayi_app/Tools/splash/splash_screen.dart';
import 'package:kitap_sarayi_app/api/Models/books.dart';

class CategoryPage extends ConsumerStatefulWidget {
  const CategoryPage({required this.category, super.key});
  final String category;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CategoryPageState();
}

class _CategoryPageState extends ConsumerState<CategoryPage> {
  final categoryProvider =
      StateNotifierProvider<SplashCategoryProvider, CategoryState>((ref) {
    return SplashCategoryProvider();
  });

  @override
  void initState() {
    super.initState();
    ref.read(categoryProvider.notifier).getCategory(widget.category);
  }

  List<Books>? books;
  int? count;
  bool? cift;
  @override
  Widget build(BuildContext context) {
    ref.listen(categoryProvider, (previous, next) {
      if (next.categoryBooks != null) {
        books = next.categoryBooks;
        count = books!.length ~/ 2;
        cift = books!.length.isEven;
      }
      setState(() {});
    });

    if (books != null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.category),
        ),
        body: ListView.builder(
          itemCount: cift! ? count! : count! + 1,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: (cift! || (index != count))
                    ? [
                        BookImgAndTitle(
                          book: books![2 * index],
                        ),
                        BookImgAndTitle(
                          book: books![2 * index + 1],
                        ),
                      ]
                    : [BookImgAndTitle(book: books![2 * index])],
              ),
            );
          },
        ),
      );
    }
    return const SplashScreen();
  }
}
