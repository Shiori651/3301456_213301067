import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:kitap_sarayi_app/api/Models/version.dart';

class VersionProvider extends ChangeNotifier {
  Version? android;
  Version? ios;

  Future<void> getVersion() async {
    final DocumentSnapshot snapshotand = await FirebaseFirestore.instance
        .collection('version')
        .doc("android")
        .get();

    android = Version.fromJson(snapshotand.data()! as Map<String, dynamic>);
    final DocumentSnapshot snapshotiso =
        await FirebaseFirestore.instance.collection('version').doc("ios").get();

    ios = Version.fromJson(snapshotiso.data()! as Map<String, dynamic>);
    notifyListeners();
  }

  Future<void> updateVersion({
    required Version android,
    required Version ios,
  }) async {
    await FirebaseFirestore.instance
        .collection('version')
        .doc("android")
        .update(android.toJson());
    await FirebaseFirestore.instance
        .collection('version')
        .doc("ios")
        .update(ios.toJson());
  }
}

final versionProvider =
    ChangeNotifierProvider<VersionProvider>((ref) => VersionProvider());
