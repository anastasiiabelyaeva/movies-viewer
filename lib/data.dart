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
      // Language.values.forEach((element) {
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
    if (kDebugMode) print('Movie ${movieList[index].title}');
  }
}
