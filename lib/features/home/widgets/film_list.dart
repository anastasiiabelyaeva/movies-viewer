import 'package:films_viewer/app/models/film_card_model.dart';
import 'package:flutter/material.dart';
import 'package:films_viewer/app/widgets/film_tile.dart';
import 'package:films_viewer/app/other/data.dart';

// ignore: must_be_immutable
class FilmList extends StatelessWidget {
  FilmList({required this.filmWidgetList, Key? key}) : super(key: key);
  List<FilmCardModel> filmWidgetList = filmCardData();
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: filmWidgetList.length,
        itemBuilder: (context, index) =>
            FilmTile.fromModel(model: filmWidgetList[index]));
  }
}
