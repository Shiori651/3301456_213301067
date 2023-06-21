import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kitap_sarayi_app/api/Models/books.dart';
import 'package:kitap_sarayi_app/api/Service/service_database.dart';

class SplashCategoryProvider extends StateNotifier<CategoryState> {
  SplashCategoryProvider() : super(const CategoryState());

  Future<void> getCategory(String category) async {
    state = state.copyWith(
      categoryBooks: await FirebaseGet().getCategory(category),
    );
  }
}

class CategoryState extends Equatable {
  const CategoryState({this.categoryBooks});

  final List<Books>? categoryBooks;

  CategoryState copyWith({
    List<Books>? categoryBooks,
  }) {
    return CategoryState(
      categoryBooks: categoryBooks ?? this.categoryBooks,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
