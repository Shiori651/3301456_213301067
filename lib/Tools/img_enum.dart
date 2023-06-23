import 'package:flutter/material.dart';
import 'package:kitap_sarayi_app/Pages/SplashCategory/splash_category_view.dart';

import 'package:kitap_sarayi_app/api/Service/service_database.dart';

class ContainerCategory extends StatelessWidget {
  ContainerCategory({super.key});
  final categorys = FirebaseGet().categories;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Kategoriler",
            ),
            SizedBox()
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categorys.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 15),
                child: GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    // ignore: inference_failure_on_instance_creation
                    MaterialPageRoute(
                      builder: (context) =>
                          CategoryPage(category: categorys[index]),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    child: ContainerGet(categorys[index]),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget ContainerGet(String name) {
    return switch (name) {
      "Türk Klasikleri" =>
        Containerget(imgname.turkklasikler.name, categorys[0]),
      "Türk Romanı" => Containerget(imgname.turkroman.name, categorys[1]),
      "Dünya Roman" => Containerget(imgname.dunyaroman.name, categorys[2]),
      "Fantastik" => Containerget(imgname.fantastik.name, categorys[3]),
      "Polisiye" => Containerget(imgname.polisiye.name, categorys[4]),
      "Korku Gerilim" => Containerget(imgname.korkugerilim.name, categorys[5]),
      "Bilim Kurgu" => Containerget(imgname.bilimkurgu.name, categorys[6]),
      "Macera" => Containerget(imgname.macera.name, categorys[7]),
      "Romantik" => Containerget(imgname.romantik.name, categorys[8]),
      _ => Image.asset("")
    };
  }

  Container Containerget(String name, String category) => Container(
        width: 200,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: getimg(name),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.3),
              BlendMode.darken,
            ),
          ),
        ),
        child: Center(
          child: Text(
            category,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      );

  ImageProvider<Object> getimg(String name) =>
      AssetImage("assets/Logo/ic_$name.jpg");
}

enum imgname {
  turkklasikler,
  turkroman,
  dunyaroman,
  fantastik,
  bilimkurgu,
  romantik,
  macera,
  polisiye,
  korkugerilim;
}
