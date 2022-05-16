import 'package:films_viewer/app/models/film_card_model.dart';
import 'package:flutter/foundation.dart';

enum Language { english, spanish, unknown }

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
    for (var element in Language.values) {
      if (element.name == language) currentLanguage = element;
    }
    return currentLanguage;
  }
}

class Film extends Movie with MovieLanguage {
  Film(String id, String title, String picture, double voteAverage,
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

Future printMovies(List<Film> movieList) async {
  for (var index = 0; index < movieList.length; index++) {
    await Future.delayed(const Duration(seconds: 2));
    if (kDebugMode) ('Movie ${movieList[index].title}');
  }
}

List<String> filmTitles(List<Film> list) {
  List<String> _filmTitles = <String>[];
  for (int index = 0; index < list.length; index++) {
    _filmTitles.add(list[index].title);
  }
  return _filmTitles;
}

List<FilmCardModel> filmCardData() {
  List<FilmCardModel> model = <FilmCardModel>[
    const FilmCardModel(
        id: 849,
        title: 'Чужой',
        picture:
            'https://www.ubuy.vn/productimg/?image=aHR0cHM6Ly9tLm1lZGlhLWFtYXpvbi5jb20vaW1hZ2VzL0kvQTFxa0IyNjVZckwuX0FDX1NMMTUwMF8uanBn.jpg',
        voteAverage: 8.063,
        releaseDate: '25.03.1979',
        description:
            'Группа космонавтов высаживается на неизвестной планете и знакомится с ксеноморфом',
        language: 'english'),
    const FilmCardModel(
        id: 980,
        title: 'Сияние',
        picture:
            'https://avatars.mds.yandex.net/get-kinopoisk-image/1946459/1fa0e38c-f67d-4177-b012-720a93c107f5/1920x',
        voteAverage: 7.774,
        releaseDate: '23.05.1980',
        description: 'Писатель приезжает с семьей в загадочный отель',
        language: 'english'),
    const FilmCardModel(
        id: 123,
        title: '1408',
        picture:
            'https://avatars.mds.yandex.net/get-kinopoisk-image/1900788/b56c5f7f-c34f-43d1-baa9-0923dbb1669c/orig',
        voteAverage: 6.7,
        releaseDate: '12.06.2007',
        description:
            'Скептик-писатель селится в номере, где умерли 56 человек. ',
        language: 'english'),
    const FilmCardModel(
        id: 45667,
        title: 'Оно',
        picture:
            'https://avatars.mds.yandex.net/get-kinopoisk-image/1600647/e88f5323-6dce-4617-b3d9-3fed1bf477bc/1920x',
        voteAverage: 5.3,
        releaseDate: '05.09.2017',
        description: 'Злобный клоун терроризирует подростков',
        language: 'english'),
    const FilmCardModel(
        id: 45668,
        title: 'Приют',
        picture:
            'https://avatars.mds.yandex.net/get-kinopoisk-image/1629390/9fb500bb-785a-42ed-8d4f-64a7b80db4b4/1920x',
        voteAverage: 5.7,
        releaseDate: '20.05.2007',
        description:
            'Через тридцать лет Лаура возвращается в дом своего детства с мужем и семилетним сыном Симоном. Она мечтает восстановить его и открыть для новых маленьких посетителей. Однако в день открытия приюта обнаруживается, что Симон бесследно исчез.',
        language: 'spanish'),
  ];
  return model;
}
