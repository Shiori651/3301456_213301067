import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kitap_sarayi_app/Pages/SplashCategory/splash_category_view.dart';
import 'package:kitap_sarayi_app/Pages/book_page.dart';
import 'package:kitap_sarayi_app/Tools/Provider/library_provider.dart';
import 'package:kitap_sarayi_app/Tools/Provider/readlist_provider.dart';
import 'package:kitap_sarayi_app/Tools/img_enum.dart';
import 'package:kitap_sarayi_app/api/Models/books.dart';
import 'package:kitap_sarayi_app/api/Service/service_database.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({
    required this.books,
    required this.popularbooks,
    super.key,
  });
  final List<Books> books;
  final List<Books> popularbooks;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>{

  late List<Books> books;
  late List<Books> popularbooks;
  @override
  void initState() {
    super.initState();
    books = widget.books;
    popularbooks = widget.popularbooks;
  }


  Future<List<Books>> _fetchData() async {

    final libraryProviderRef = ref.watch(libraryProvider);
    final libraryBook = libraryProviderRef.libraryBooks;
    final ids = libraryBook
        .map((Books value) => value.id)
        .whereType<String>()
        .toList();
    var recommendsListBook = <Books>[];
    if(ids.isNotEmpty){
      final recommendsList =
      await FirebaseGet().fetchRecommendationsForUser(ids);

      if(recommendsList.isNotEmpty){
        recommendsListBook = await FirebaseGet().getDocIdBooks(recommendsList);
      }

    }
    return recommendsListBook;
  }

  @override
  Widget build(BuildContext context) {
    void reset() {
      ref.read(readlistProvider).reset();
      ref.read(libraryProvider).reset();
    }

    return
      FutureBuilder(
        future: _fetchData(),
        builder: (context,snapshot){
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                "Ana Sayfa",
              ),
              leading: IconButton(
                icon: const Icon(Icons.exit_to_app),
                onPressed: () {
                  reset();
                  Navigator.pop(context);
                },
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    popularShow(popularbooks, context),
                    recommendsBooksList(snapshot,context),
                    ContainerCategory(),
                    const SizedBox(
                      height: 10,
                    ),
                    BookShowWidget(
                      books: books,
                    ),
                    const SizedBox(
                      height: 80,
                    )
                  ],
                ),
              ),
            ),
          );
        },
      );
  }

  Column popularShow(List<Books> books, BuildContext context) {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Popüler Kitaplar",
            ),
            SizedBox()
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
  Column recommendsBooksList(AsyncSnapshot<List<Books>> snapshot, BuildContext context) {
    if(snapshot.connectionState==ConnectionState.waiting){
      return const Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Sizin İçin Seçilen",
              ),
              SizedBox(),
            ],
          ),
          SizedBox(
            height: 300,
            child: Center(child: CircularProgressIndicator()),
          ),
        ],
      );
    }
    else if(snapshot.hasData){
      if(snapshot.data!.isNotEmpty){
        final recommendsBooks = snapshot.data;
        return Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Sizin İçin Seçilen",
                ),
                SizedBox(),
              ],
            ),
            SizedBox(
              height: 300,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: recommendsBooks!.length,
                itemBuilder: (context, index) {
                  final recommendsBook = recommendsBooks[index];
                  return Padding(
                    padding: const EdgeInsets.only(top: 10, right: 10),
                    child: BookImgAndTitle(book: recommendsBook),
                  );
                },
              ),
            ),
          ],
        );
      }
      else{
        return const Column();
      }
    }
    else{
      return const Column();
    }
  }
}















class BookImgAndTitle extends StatelessWidget {
  const BookImgAndTitle({
    required this.book,
    super.key,
  });

  final Books book;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        // ignore: inference_failure_on_instance_creation
        MaterialPageRoute(
          builder: (context) => BookPage(book: book),
        ),
      ),
      child: Container(
        width: 150,
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ImageContainerGet(
              url: book.book_img!,
            ),
            ListTile(
              title: Text(
                book.name!,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                book.author!,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BookShowWidget extends StatelessWidget {
  const BookShowWidget({
    required this.books,
    super.key,
  });
  final List<Books> books;
  @override
  Widget build(BuildContext context) {
    final categoryes = FirebaseGet().categories;
    return Column(
      children: List.generate(categoryes.length, (index) {
        final categorybooks = books
            .where((element) => element.book_type == categoryes[index])
            .toList();
        return categorybooks.isEmpty
            ? const SizedBox()
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        // ignore: inference_failure_on_instance_creation
                        MaterialPageRoute(
                          builder: (context) =>
                              CategoryPage(category: categoryes[index]),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            categoryes[index],
                          ),
                          const Icon(Icons.navigate_next)
                        ],
                      ),
                    ),
                  ),
                  categoryShow(categorybooks, context),
                ],
              );
      }),
    );
  }
}

SizedBox categoryShow(List<Books> books, BuildContext context) {
  return SizedBox(
    width: 500,
    height: 200,
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(books.length, (index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                // ignore: inference_failure_on_instance_creation
                MaterialPageRoute(
                  builder: (context) => BookPage(book: books[index]),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(left: 20),
              child: ImageContainerGet(url: books[index].book_img!),
            ),
          );
        }),
      ),
    ),
  );
}

class ImageContainerGet extends StatelessWidget {
  const ImageContainerGet({
    required this.url,
    super.key,
  });

  final String url;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      child: Image.network(
        url,
        fit: BoxFit.contain,
        height: 190,
      ),
    );
  }
}
