import 'package:films_viewer/app/models/film_card_model.dart';
import 'package:films_viewer/features/home/widgets/film_grid.dart';
import 'package:flutter/material.dart';
import 'package:films_viewer/app/other/data.dart';
import 'package:films_viewer/features/home/pages/settings_page.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({Key? key, required this.title}) : super(key: key);
  final String title;
  static const String routeName = 'catalogPage';

  @override
  _CatalogPageState createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  late TextEditingController _textEditingController;
  bool isChecked = false;
  Language? language = Language.english;
  List<FilmCardModel> films = filmCardData();
  List<FilmCardModel> resultFilmList = <FilmCardModel>[];
  @override
  void initState() {
    resultFilmList = films;
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {},
          ),
          title: Text(widget.title),
          actions: <Widget>[
            SizedBox(
              width: 200,
              height: 20,
              child: TextField(
                controller: _textEditingController,
                textCapitalization: TextCapitalization.words,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.search,
                style: const TextStyle(
                    fontSize: 22, color: Color.fromARGB(255, 199, 204, 207)),
                decoration: const InputDecoration(
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
              ),
            ),
            IconButton(
                onPressed: () {
                  setState(() {
                    resultFilmList = films
                        .where((element) => (element.title
                            .contains(_textEditingController.text)))
                        .toList(growable: true);
                  });
                },
                icon: const Icon(Icons.search)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.sort)),
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/settings',
                      arguments: const SettingsArguments(''));
                },
                icon: const Icon(Icons.settings)),
          ],
        ),
        body: FilmGrid(
          filmWidgetList: resultFilmList,
        ));
  }
}
