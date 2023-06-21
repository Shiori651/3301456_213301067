import 'package:equatable/equatable.dart';

class Books extends Equatable {
  const Books({
    this.name,
    this.id,
    this.author,
    this.publisher,
    this.publication_year,
    this.pages_count,
    this.ISBN,
    this.book_type,
    this.explanation,
    this.book_img,
  });

  factory Books.fromJson(Map<String, dynamic> json) {
    return Books(
      name: json['name'] as String?,
      id: json['id'] as String?,
      author: json['author'] as String?,
      publisher: json['publisher'] as String?,
      publication_year: json['publication_year'] as String?,
      pages_count: json['pages_count'] as String?,
      ISBN: json['ISBN'] as String?,
      book_type: json['book_type'] as String?,
      explanation: json['explanation'] as String?,
      book_img: json['book_img'] as String?,
    );
  }
  final String? name;
  final String? id;
  final String? author;
  final String? publisher;
  final String? publication_year;
  final String? pages_count;
  final String? ISBN;
  final String? book_type;
  final String? explanation;
  final String? book_img;

  @override
  List<Object?> get props => [
        name,
        id,
        author,
        publisher,
        publication_year,
        pages_count,
        ISBN,
        book_type,
        explanation,
        book_img
      ];

  Books copyWith({
    String? name,
    String? id,
    String? author,
    String? publisher,
    String? publication_year,
    String? pages_count,
    String? ISBN,
    String? book_type,
    String? explanation,
    String? book_img,
  }) {
    return Books(
      name: name ?? this.name,
      id: id ?? this.id,
      author: author ?? this.author,
      publisher: publisher ?? this.publisher,
      publication_year: publication_year ?? this.publication_year,
      pages_count: pages_count ?? this.pages_count,
      ISBN: ISBN ?? this.ISBN,
      book_type: book_type ?? this.book_type,
      explanation: explanation ?? this.explanation,
      book_img: book_img ?? this.book_img,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
      'author': author,
      'publisher': publisher,
      'publication_year': publication_year,
      'pages_count': pages_count,
      'ISBN': ISBN,
      'book_type': book_type,
      'explanation': explanation,
      'book_img': book_img,
    };
  }
}
