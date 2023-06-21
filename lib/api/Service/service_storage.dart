import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ShowImage extends StatelessWidget {
  const ShowImage({required this.imagePath, super.key});
  final String imagePath;
  @override
  Widget build(BuildContext context) {
    Future<String> poolImgUrl() async {
      return await FirebaseStorage.instance
          .ref()
          .child("books/$imagePath.jpg")
          .getDownloadURL();
    }

    return FutureBuilder(
      future: poolImgUrl(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (!snapshot.hasData) {
          return const Text('No Data');
        }
        return Image.network(
          snapshot.data.toString(),
          fit: BoxFit.fill,
        );
      },
    );
  }
}
