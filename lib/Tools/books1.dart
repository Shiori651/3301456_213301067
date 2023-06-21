class Books1 {
  static List<dynamic> books = [];

  int isbnIndexSearch(String isbn) {
    for (var i = 0; i < books.length; i++) {
      if (books[i]["book_ISBN"].toString() == isbn) {
        return i;
      }
    }
    return 0;
  }
}
