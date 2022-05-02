import 'package:flutter/material.dart';

List<HorrorMovie> horrorFilmList = <HorrorMovie>[];
enum Language { english, spanish, unknown }
void main() {
  addMovie(
      horrorFilmList,
      '849 719',
      'Чужой',
      'alien.jpg',
      8.063,
      '25.05.1979',
      'Группа космонавтов высаживается на неизвестной планете и знакомится с ксеноморфом',
      'english');
  addMovie(
      horrorFilmList,
      '980 008',
      'Сияние',
      'shining.jpeg',
      7.774,
      '23.05.1980',
      'Писатель приезжает с семьей в загадочный отель',
      'english');
  addMovie(horrorFilmList, '123', '1408', '1408.jpg', 6.7, '12.06.2007',
      'Скептик-писатель селится в номере, где умерли 56 человек. ', 'english');
  addMovie(horrorFilmList, '45667', 'Оно', 'it.jpg', 5.3, '05.09.2017',
      'Злобный клоун терроризирует подростков', 'english');
  addMovie(
      horrorFilmList,
      '45668',
      'Приют',
      'shelter.jpeg',
      5.7,
      '20.05.2007',
      'Самые счастливые годы Лаура провела в сиротском приюте на побережье. Любимые воспитатели заменили ей родителей, а друзья – братьев и сестер. Через тридцать лет Лаура возвращается в дом своего детства с мужем и семилетним сыном Симоном. Она мечтает восстановить его и открыть для новых маленьких посетителей. Однако в день открытия приюта обнаруживается, что Симон бесследно исчез. Лауре кажется, что дело в Томасе, вымышленном друге сына, с чьим призраком она столкнулась в день исчезновения.',
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
  final List<MovieWidget> _movieWidgets = <MovieWidget>[];
  List<MovieWidget> filteredWidgetList = <MovieWidget>[];
  bool isChecked = false;
  Language? _language = Language.english;
  void initState() {
    for (int index = 0; index < horrorFilmList.length; index++) {
      _movieWidgets.add(
        MovieWidget(
          title: horrorFilmList[index].title,
          picture: horrorFilmList[index].picture,
          language: horrorFilmList[index].movieLanguage(),
          voteAverage: horrorFilmList[index].voteAverage,
        ),
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          // PopupMenuButton(
          //     icon: Icon(Icons.more_horiz), itemBuilder: (context) => []),
          IconButton(
              onPressed: () {
                setState(() {
                  // List<MovieWidget> list = _movieWidgets

                  if (isChecked) {
                    filteredWidgetList = _movieWidgets
                        .where((element) => (element.voteAverage > 7 &&
                            element.language == _language))
                        .toList(growable: true);
                  } else {
                    filteredWidgetList = _movieWidgets
                        .where((element) => (element.language == _language))
                        .toList(growable: true);
                  }
                });
              },
              icon: const Icon(Icons.sort)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          // const LanguageRadioButtonList(),
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
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: filteredWidgetList.length,
            itemBuilder: (context, index) => filteredWidgetList[index],
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
      required this.voteAverage,
      Key? key})
      : super(key: key);

  final String title;
  final String picture;
  final Language language;
  final double voteAverage;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 56, 16, 10),
        border: Border.all(
          color: const Color.fromARGB(255, 119, 47, 47),
          width: 8,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(children: [
        Image.asset(
          'assets/' + picture,
        ),
        Text(title + ' (Язык: ' + language.toPrettyString() + ')',
            style: const TextStyle(
                color: Color.fromARGB(255, 235, 208, 208),
                fontFamily: 'Verdana',
                fontSize: 24)),
      ]),
    );
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
                language: item.movieLanguage(),
                voteAverage: item.voteAverage,
              );
            },
          ),
        )
      ],
    );
  }
}

class CheckBox extends StatefulWidget {
  const CheckBox({Key? key}) : super(key: key);

  @override
  _CheckBoxState createState() => _CheckBoxState();
}

class _CheckBoxState extends State<CheckBox> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      checkColor: Colors.white,
      title: const Text('Рейтинг > 7'),
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value!;
        });
      },
    );
  }
}

class LanguageRadioButtonList extends StatefulWidget {
  const LanguageRadioButtonList({Key? key}) : super(key: key);

  @override
  _LanguageRadioButtonListState createState() =>
      _LanguageRadioButtonListState();
}

class _LanguageRadioButtonListState extends State<LanguageRadioButtonList> {
  Language? _language = Language.english;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
    );
  }
}
