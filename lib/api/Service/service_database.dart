import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kitap_sarayi_app/Tools/database_key.dart';
import 'package:kitap_sarayi_app/Tools/version/platform_name.dart';
import 'package:kitap_sarayi_app/api/Models/books.dart';
import 'package:kitap_sarayi_app/api/Models/library.dart';
import 'package:kitap_sarayi_app/api/Models/users.dart';
import 'package:kitap_sarayi_app/api/Models/version.dart';

class UpdateDatabase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> setAuthDatabase({
    required Users user,
  }) async {
    final a = <String>[];
    await _firestore.collection('users').doc(user.id).set(user.toJson());
    await _firestore
        .collection("library")
        .doc(user.id)
        .set({"library": a, "readList": a});
  }

  Future<void> addLibrary(String newData, String userid) async {
    final CollectionReference libraryCollection =
        FirebaseFirestore.instance.collection('library');

    await libraryCollection.doc(userid).update({
      'library': FieldValue.arrayUnion([newData]),
    });
  }

  Future<void> removeLibrary(String newData, String userid) async {
    final CollectionReference libraryCollection =
        FirebaseFirestore.instance.collection('library');

    await libraryCollection.doc(userid).update({
      'library': FieldValue.arrayRemove([newData]),
    });
  }

  Future<void> addReadList(String newData, String userid) async {
    final CollectionReference libraryCollection =
        FirebaseFirestore.instance.collection('library');

    await libraryCollection.doc(userid).update({
      'readList': FieldValue.arrayUnion([newData]),
    });
  }

  Future<void> removeReadList(String newData, String userid) async {
    final CollectionReference libraryCollection =
        FirebaseFirestore.instance.collection('library');

    await libraryCollection.doc(userid).update({
      'readList': FieldValue.arrayRemove([newData]),
    });
  }
}

class FirebaseGet {
  final categories = DatabaseKey.category;

  Future<List<Books>> getPopular() async {
    final snapshot =
        await FirebaseFirestore.instance.collection("popularbooks").get();
    final dataList = snapshot.docs.map((DocumentSnapshot doc) {
      final data = doc.data()! as Map<String, dynamic>;
      return Books.fromJson(data);
    }).toList();
    return dataList;
  }

  Future<List<Books>> getBooks() async {
    final books = <Books>[];
    for (final category in categories) {
      final snapshot = await FirebaseFirestore.instance
          .collection("books")
          .where("book_type", isEqualTo: category)
          .limit(10)
          .get();
      final dataList = snapshot.docs.map((DocumentSnapshot doc) {
        final data = doc.data()! as Map<String, dynamic>;
        return Books.fromJson(data).copyWith();
      }).toList();
      books.addAll(dataList);
    }
    return books;
  }

  Future<Version?> getVersion() async {
    final DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('version')
        .doc(PlatformEnum.versionName)
        .get();
    if (snapshot.exists) {
      return Version.fromJson(snapshot.data()! as Map<String, dynamic>);
    } else {
      return null;
    }
  }

  Future<Users> getUser(String id) async {
    final DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection('users').doc(id).get();
    return Users.fromJson(snapshot.data()! as Map<String, dynamic>)
        .copyWith(id: id);
  }

  Future<Library> getLibraryid(String id) async {
    final DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection('library').doc(id).get();
    return Library.fromJson(snapshot.data()! as Map<String, dynamic>);
  }

  Future<List<Books>> getDocIdBooks(List<String> booksid) async {
    final snapshot = await FirebaseFirestore.instance
        .collection("books")
        .where(
          FieldPath.documentId,
          whereIn: booksid,
        )
        .get();
    final dataList = snapshot.docs.map((DocumentSnapshot doc) {
      final data = doc.data()! as Map<String, dynamic>;
      return Books.fromJson(data);
    }).toList();

    return dataList;
  }

  Future<List<Books>> getCategory(String category) async {
    final snapshot = await FirebaseFirestore.instance
        .collection("books")
        .where(
          "book_type",
          isEqualTo: category,
        )
        .limit(100)
        .get();
    final dataList = snapshot.docs.map((DocumentSnapshot doc) {
      final data = doc.data()! as Map<String, dynamic>;
      return Books.fromJson(data);
    }).toList();
    return dataList;
  }

  Future<List<Books>> getSearch({
    required String searchText,
    required String searchType,
    required String isbn,
    required String book_type,
  }) async {
    Query query = FirebaseFirestore.instance.collection("books");

    if (isbn.isNotEmpty) {
      query = query.where("ISBN", isEqualTo: isbn);
    } else {
      if (book_type.isNotEmpty) {
        query = query.where("book_type", isEqualTo: book_type);
      }
      if (searchText.isNotEmpty) {
        searchText = formatSearchKeyword(searchText);
        query = query
            .where(searchType, isGreaterThanOrEqualTo: searchText)
            .where(searchType, isLessThan: '${searchText}z');
      }
    }

    final snapshot = await query.limit(30).get();
    final dataList = snapshot.docs.map((DocumentSnapshot doc) {
      final data = doc.data()! as Map<String, dynamic>;
      return Books.fromJson(data);
    }).toList();
    return dataList;
  }

  String formatSearchKeyword(String keyword) {
    final words = keyword.trim().split(' ');

    for (var i = 0; i < words.length; i++) {
      final word = words[i];
      var formattedWord = "";
      if (word[0] == "i") {
        formattedWord = "İ${word.substring(1).toLowerCase()}";
      } else {
        formattedWord = word[0].toUpperCase() + word.substring(1).toLowerCase();
      }

      words[i] = formattedWord;
    }

    return words.join(' ');
  }
}
