import 'package:flutter/material.dart';

List<HorrorMovie> horrorFilmList = <HorrorMovie>[];
enum Language { english, spanish, unknown }
void main() {
  addMovie(
      horrorFilmList,
      '849 719',
      'Alien',
      'alien.jpg',
      8.063,
      '25.05.1979',
      'Группа космонавтов высаживается на неизвестной планете и знакомится с ксеноморфом',
      'english');
  addMovie(
      horrorFilmList,
      '980 008',
      'The Shining',
      'spiderman.jpg',
      7.774,
      '23.05.1980',
      'Писатель приезжает с семьей в загадочный отель',
      'english');
  addMovie(
      horrorFilmList,
      '3 330',
      'La monja',
      'batman.jpg',
      6.345,
      '12.05.2005',
      'Шесть девочек попадают в интернат под присмотр монахинь',
      'spanish');
  debugPrint('${filteredList(horrorFilmList, 'voteAverage', 6.4)}');
  printMovies(horrorFilmList);
  runApp(const MyApp());
}

void addMovie(
    List<HorrorMovie> list,
    String id,
    String title,
    String picture,
    double voteAverage,
    String releaseDate,
    String description,
    String language) {
  HorrorMovie movie = HorrorMovie(
      id, title, picture, voteAverage, releaseDate, description, language);
  debugPrint('Movie language: ${movie.movieLanguage()}');
  debugPrint('Язык ${movie.movieLanguage().toPrettyString()}');
  list.add(movie);
}

abstract class Movie {
  String id;
  String title;
  String picture;
  double voteAverage;
  String releaseDate;
  String description;
  String language;

  Movie(this.id, this.title, this.picture, this.voteAverage, this.releaseDate,
      this.description, this.language);
}

mixin MovieLanguage on Movie {
  Language movieLanguage() {
    Language currentLanguage = Language.unknown;
    Language.values.forEach((element) {
      if (element.name == language) currentLanguage = element;
    });
    return currentLanguage;
  }
}

class HorrorMovie extends Movie with MovieLanguage {
  HorrorMovie(String id, String title, String picture, double voteAverage,
      String releaseDate, String description, String language)
      : super(id, title, picture, voteAverage, releaseDate, description,
            language);
}

extension LanguageToRusString on Language {
  String toPrettyString() {
    switch (this) {
      case Language.english:
        return 'Английский';
      case Language.spanish:
        return 'Испанский';
      default:
        return 'Неизвестный';
    }
  }
}

Future printMovies(List<HorrorMovie> movieList) async {
  for (var index = 0; index < movieList.length; index++) {
    await new Future.delayed(new Duration(seconds: 2));
    debugPrint('Movie ${movieList[index].title}');
  }
}

List<String> filteredList(
    List<HorrorMovie> list, String property, double value) {
  List<String> resultList = <String>[];
  List<HorrorMovie> filteredList = <HorrorMovie>[];
  if (property == 'voteAverage') {
    filteredList = list
        .where((element) => (element.voteAverage > value))
        .toList(growable: false);
  }
  for (var index = 0; index < filteredList.length; index++) {
    resultList.add(filteredList[index].title);
  }
  return resultList;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home: MyHomePage(title: 'Flutter Demo Home Page'),
        home: const MyHomePage(title: 'Movie House'));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<MovieWidget> _movieWidgets = <MovieWidget>[];
  final nameController = TextEditingController();
  String UserName = '';
  int val = -1;

  void initState() {
    for (int index = 0; index < horrorFilmList.length; index++) {
      _movieWidgets.add(MovieWidget(
          title: horrorFilmList[index].title,
          picture: horrorFilmList[index].picture,
          language: horrorFilmList[index].movieLanguage()));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      // body: WidgetList()
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          Row(
            children: <Widget>[
              ElevatedButton(
                  onPressed: () {
                    print('Button 2');
                  },
                  child: Text('Применить'))
            ],
          ),
          // ElevatedButton(
          //     onPressed: () {
          //       print('dddd');
          //       for (int index = 0; index < _movieWidgets.length; index++) {
          //         if (_movieWidgets[index].title == "Alien") {
          //           setState(() {
          //             _movieWidgets.remove(_movieWidgets[index]);
          //             // _movieWidgets.add(_movieWidgets[0]);
          //           });
          //         }
          //       }
          //     },
          //     child: Text('Применить')),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: _movieWidgets.length,
            itemBuilder: (context, index) => _movieWidgets[index],
            // itemCount: horrorFilmList.length,
            // itemBuilder: (context, index) {
            //   final item = horrorFilmList[index];
            //   return MovieWidget(
            //       title: item.title,
            //       picture: item.picture,
            //       language: item.movieLanguage());
            // },
          )
        ]),
      ),
    );
  }
}

class MovieWidget extends StatelessWidget {
  const MovieWidget(
      {required this.title,
      required this.picture,
      required this.language,
      Key? key})
      : super(key: key);

  final String title;
  final String picture;
  final Language language;
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.grey,
        child: Column(children: [
          Text(title),
          Image.asset(
            'assets/' + picture,
          ),
          Text('Язык: ' + language.toPrettyString())
        ]));
  }
}

class WidgetList extends StatelessWidget {
  const WidgetList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: horrorFilmList.length,
            itemBuilder: (context, index) {
              final item = horrorFilmList[index];
              return MovieWidget(
                  title: item.title,
                  picture: item.picture,
                  language: item.movieLanguage());
            },
          ),
        )
      ],
    );
  }
}
