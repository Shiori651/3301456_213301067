import 'package:flutter/material.dart';
import 'package:kitap_sarayi_app/AppManager/Pages/book_add_page.dart';
import 'package:kitap_sarayi_app/AppManager/Pages/popular_book_change.dart';
import 'package:kitap_sarayi_app/AppManager/Pages/version_conteoller.dart';

enum IconConstants { importexcel, popularbooks, versionChecking }

extension IconContantsGet on IconConstants {
  Image get topng => Image.asset(
        "assets/Icons/ic_$name.png",
        fit: BoxFit.contain,
      );
  Text totitle() {
    switch (this) {
      case IconConstants.importexcel:
        return customText("Excel'den Kitap Ekle");
      case IconConstants.popularbooks:
        return customText("Popüler Kitapları Değiştir");
      case IconConstants.versionChecking:
        return customText(
          "En Düşük Kullanılabilir Version",
        );
    }
  }

  Widget toPage() {
    switch (this) {
      case IconConstants.importexcel:
        return const BookAddPage();
      case IconConstants.popularbooks:
        return const PopularBookChange();
      case IconConstants.versionChecking:
        return const VersionControlPage();
    }
  }

  Text customText(String title) => Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      );
}
