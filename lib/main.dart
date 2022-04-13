import 'package:flutter/material.dart';

enum Language { english, spanish, unknown }
void main() {
  List<HorrorMovie> horrorFilmList = <HorrorMovie>[];
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
      'TheShining.png',
      7.774,
      '23.05.1980',
      'Писатель приезжает с семьей в загадочный отель',
      'english');
  addMovie(
      horrorFilmList,
      '3 330',
      'La monja',
      'LaMonja.png',
      6.345,
      '12.05.2005',
      'Шесть девочек попадают в интернат под присмотр монахинь',
      'spanish');
  debugPrint('${filteredList(horrorFilmList, 'voteAverage', 6.4)}');
  printMovies(horrorFilmList);
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
