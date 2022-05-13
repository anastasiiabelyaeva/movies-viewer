import 'package:flutter/material.dart';
import 'package:films_viewer/app/models/film_card_model.dart';
import 'package:films_viewer/app/other/data.dart';
import 'package:films_viewer/app/widgets/film_card.dart';

// ignore: must_be_immutable
class FilmGrid extends StatelessWidget {
  FilmGrid({required this.filmWidgetList, Key? key}) : super(key: key);
  List<FilmCardModel> filmWidgetList = filmCardData();
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: filmWidgetList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: FilmCard.fromModel(model: filmWidgetList[index]),
          );
        },
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 2 / 3));
  }
}
