import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:kitap_sarayi_app/api/Service/servis_auth.dart';

class BookAddPage extends StatefulWidget {
  const BookAddPage({super.key});

  @override
  State<BookAddPage> createState() => _BookAddPageState();
}

class _BookAddPageState extends State<BookAddPage> {
  final headers = <String>[];
  final datas = <List<String>>[];
  int sayac = 0;
  String excelname = "";
  Future<void> filepicker() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
    );
    if (result != null) {
      // ignore: prefer_final_locals
      List<int> bytes = result.files.single.bytes!;
      excelname = result.files.single.name;
      final excel = Excel.decodeBytes(bytes);
      exceltoMap(excel);
    }
  }

  void exceltoMap(Excel excel) {
    headers.clear();
    datas.clear();
    final tablename = excel.tables.values.first.sheetName;

    final table = excel.tables[tablename];
    if (table != null) {
      for (final header in table.rows[0]) {
        if (header != null) {
          headers.add(header.value.toString());
        } else {
          return;
        }
      }
      for (var j = 1; j < table.maxRows; j++) {
        final data = <String>[];
        for (final celldata in table.rows[j]) {
          if (celldata != null) {
            data.add(celldata.value.toString());
          } else {
            data.add("");
          }
        }
        datas.add(data);
      }
      setState(() {});
    }
  }

  Future<void> addBooksToFirebase() async {
    try {
      final ref = FirebaseFirestore.instance.collection("books");
      for (final data in datas) {
        final value =
            headers.asMap().map((index, key) => MapEntry(key, data[index]));
        final DocumentReference docref = await ref.add(value);
        final docId = docref.id;
        await docref.update({'id': docId});
        sayac++;
        setState(() {});
      }
      // ignore: use_build_context_synchronously
      dialogShow(
        content: "${datas.length} veri başarıyla eklendi.",
        context: context,
        isRegisted: true,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Kitap Ekle")),
      body: Center(
        child: Padding(
          padding: padding(),
          child: Column(
            children: [
              excelCikarButton(),
              if (datas.isEmpty)
                const SizedBox()
              else
                Padding(
                  padding: padding(),
                  child: Column(
                    children: [
                      databaseAddButton(),
                      Padding(
                        padding: padding(),
                        child: (sayac != 0)
                            ? Text("$sayac/${datas.length} Veri Yüklendi")
                            : Text(
                                "$excelname dosyasında ${datas.length} veri bulunuyor.",
                              ),
                      ),
                      const Text("Kitap Listesi"),
                    ],
                  ),
                ),
              Expanded(
                child: showExcelData(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ListView showExcelData() {
    return ListView.builder(
      itemCount: datas.length,
      itemBuilder: (context, index) {
        return Text("${index + 1} -    ${datas[index][0]}");
      },
    );
  }

  ElevatedButton databaseAddButton() {
    return ElevatedButton.icon(
      icon: const Icon(Icons.add),
      onPressed: addBooksToFirebase,
      label: const Text("Veri Tabanına Ekle"),
    );
  }

  ElevatedButton excelCikarButton() {
    return ElevatedButton(
      onPressed: filepicker,
      child: const Text("Excel'den Çıkar"),
    );
  }

  EdgeInsets padding() => const EdgeInsets.all(10);
}
