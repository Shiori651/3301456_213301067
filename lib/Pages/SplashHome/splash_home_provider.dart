import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kitap_sarayi_app/api/Models/books.dart';
import 'package:kitap_sarayi_app/api/Models/library.dart';

import 'package:kitap_sarayi_app/api/Models/users.dart';

import 'package:kitap_sarayi_app/api/Service/service_database.dart';

class SplashHomeProvider extends StateNotifier<SplashHomeState> {
  SplashHomeProvider() : super(const SplashHomeState());

  Future<void> getbooks(String id) async {
    state = state.copyWith(popularbooks: await FirebaseGet().getPopular());
    state = state.copyWith(books: await FirebaseGet().getBooks());
    state = state.copyWith(user: await FirebaseGet().getUser(id));
    final libaryid = await FirebaseGet().getLibraryid(id);
    if (libaryid.library!.isNotEmpty) {
      state = state.copyWith(
        libraryBooks: await FirebaseGet().getDocIdBooks(libaryid.library!),
      );
    }
    if (libaryid.readList!.isNotEmpty) {
      state = state.copyWith(
        readListBooks: await FirebaseGet().getDocIdBooks(libaryid.readList!),
      );
    }

    state = state.copyWith(
      isGet: true,
      library: libaryid,
    );
  }
}

class SplashHomeState extends Equatable {
  const SplashHomeState({
    this.readListBooks,
    this.library,
    this.libraryBooks,
    this.books,
    this.isGet,
    this.popularbooks,
    this.user,
  });
  final bool? isGet;
  final List<Books>? books;
  final List<Books>? popularbooks;
  final Users? user;
  final Library? library;
  final List<Books>? libraryBooks;
  final List<Books>? readListBooks;

  @override
  List<Object?> get props => throw UnimplementedError();

  SplashHomeState copyWith({
    bool? isGet,
    List<Books>? books,
    List<Books>? popularbooks,
    Users? user,
    Library? library,
    List<Books>? libraryBooks,
    List<Books>? readListBooks,
  }) {
    return SplashHomeState(
      isGet: isGet ?? this.isGet,
      books: books ?? this.books,
      popularbooks: popularbooks ?? this.popularbooks,
      user: user ?? this.user,
      library: library ?? this.library,
      libraryBooks: libraryBooks ?? this.libraryBooks,
      readListBooks: readListBooks ?? this.readListBooks,
    );
  }
}
