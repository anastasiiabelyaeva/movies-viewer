import 'package:films_viewer/app/models/film_card_model.dart';
import 'package:films_viewer/app/widgets/main_page.dart';
import 'package:films_viewer/features/home/pages/detail_page.dart';
import 'package:films_viewer/features/home/pages/empty_page.dart';
import 'package:films_viewer/features/home/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:films_viewer/app/other/data.dart';

void main() {
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
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      onGenerateRoute: (settings) {
        if (settings.name == MainPage.routeName) {
          return MaterialPageRoute(
            builder: (context) {
              return const MainPage();
            },
          );
        }

        if (settings.name == SettingsPage.routeName) {
          final SettingsArguments arguments =
              settings.arguments as SettingsArguments;
          return MaterialPageRoute(
            builder: (context) {
              return SettingsPage(
                arguments: arguments,
              );
            },
          );
        }
        if (settings.name == DetailPage.routeName) {
          final FilmCardModel arguments = settings.arguments as FilmCardModel;
          return MaterialPageRoute(builder: (context) {
            return DetailPage(model: arguments);
          });
        }
        return MaterialPageRoute(builder: (_) {
          return const EmptyPage();
        });
      },
    );
  }
}
