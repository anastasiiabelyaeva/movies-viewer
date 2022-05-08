import 'package:films_viewer/components/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:films_viewer/data.dart';

late List<Film> films = <Film>[];
void main() {
  films.add(Film(
      '849',
      'Чужой',
      'alien.jpg',
      8.063,
      '25.03.1979',
      'Группа космонавтов высаживается на неизвестной планете и знакомится с ксеноморфом',
      'english'));
  films.add(Film('980 008', 'Сияние', 'shining.jpeg', 7.774, '23.05.1980',
      'Писатель приезжает с семьей в загадочный отель', 'english'));
  films.add(Film('123', '1408', '1408.jpg', 6.7, '12.06.2007',
      'Скептик-писатель селится в номере, где умерли 56 человек. ', 'english'));
  films.add(Film('45667', 'Оно', 'it.jpg', 5.3, '05.09.2017',
      'Злобный клоун терроризирует подростков', 'english'));
  films.add(Film(
      '45668',
      'Приют',
      'shelter.jpeg',
      5.7,
      '20.05.2007',
      'Самые счастливые годы Лаура провела в сиротском приюте на побережье. Любимые воспитатели заменили ей родителей, а друзья – братьев и сестер. Через тридцать лет Лаура возвращается в дом своего детства с мужем и семилетним сыном Симоном. Она мечтает восстановить его и открыть для новых маленьких посетителей. Однако в день открытия приюта обнаруживается, что Симон бесследно исчез. Лауре кажется, что дело в Томасе, вымышленном друге сына, с чьим призраком она столкнулась в день исчезновения.',
      'spanish'));
  // debugPrint('${filteredList(films, 'voteAverage', 6.4)}');
  // printMovies(films);
  runApp(const MyApp());
}

List<String> filteredList(List<Film> list, String property, double value) {
  List<String> resultList = <String>[];
  List<Film> filteredList = <Film>[];
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
      debugShowCheckedModeBanner: false,
      title: '',
      theme: ThemeData(primarySwatch: Colors.red),
      home: HomePage(
        // title: "Movie House",

        title: '',
        films: films,
      ),
    );
  }
}
