import 'package:films_viewer/components/movie_widget.dart';
import 'package:films_viewer/main.dart';
import 'package:flutter/material.dart';
import 'package:films_viewer/data.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.title, required this.films})
      : super(key: key);
  final String title;
  late List<Film> films = <Film>[];

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  late TextEditingController _textEditingController;
  String textForSearch = '';
  bool isChecked = false;
  Language? _language = Language.english;
  final List<MovieWidget> defaultMovieWidgets = <MovieWidget>[];
  late List<MovieWidget> resultMovieWidgets = defaultMovieWidgets;
  @override
  void initState() {
    for (int index = 0; index < films.length; index++) {
      defaultMovieWidgets.add(MovieWidget(
          title: films[index].title,
          picture: films[index].picture,
          language: films[index].movieLanguage(),
          voteAverage: films[index].voteAverage));
    }

    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          Container(
            width: 300,
            height: 20,
            child: TextField(
              controller: _textEditingController,
              textCapitalization: TextCapitalization.words,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.search,
              style: TextStyle(
                  fontSize: 22, color: Color.fromARGB(255, 199, 204, 207)),
              decoration: InputDecoration(
                  filled: true,
                  icon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
            ),
          ),
          IconButton(
              onPressed: () {
                setState(() {
                  resultMovieWidgets = defaultMovieWidgets
                      .where((element) =>
                          (element.title.contains(_textEditingController.text)))
                      .toList(growable: true);
                });
                print(_textEditingController.text);
              },
              icon: Icon(Icons.search)),
          IconButton(
              onPressed: () {
                setState(() {
                  if (isChecked) {
                    resultMovieWidgets = defaultMovieWidgets
                        .where((element) =>
                            (element.voteAverage > 7) &&
                            element.language == _language)
                        .toList(growable: true);
                  } else {
                    resultMovieWidgets = defaultMovieWidgets
                        .where((element) => element.language == _language)
                        .toList(growable: true);
                  }
                });
              },
              icon: const Icon(Icons.sort)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: Language.values.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(Language.values[index].toPrettyString()),
                leading: Radio<Language>(
                  value: Language.values[index],
                  groupValue: _language,
                  onChanged: (Language? value) {
                    setState(() {
                      _language = value;
                    });
                  },
                ),
              ),
            ),
            CheckboxListTile(
              checkColor: Colors.white,
              title: const Text('Рейтинг > 7'),
              value: isChecked,
              onChanged: (bool? value) {
                setState(() {
                  isChecked = value!;
                });
              },
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: resultMovieWidgets.length,
              itemBuilder: (context, index) => resultMovieWidgets[index],
            )
          ],
        ),
      ),
    );
  }
}
