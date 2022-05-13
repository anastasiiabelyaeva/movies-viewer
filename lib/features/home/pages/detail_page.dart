import 'package:films_viewer/app/models/film_card_model.dart';
import 'package:films_viewer/app/widgets/film_tile.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DetailPage extends StatefulWidget {
  DetailPage({required this.model, Key? key}) : super(key: key);
  late FilmCardModel model;
  static const String routeName = '/detail';
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Детальная информация'),
        ),
        body: Column(children: [
          FilmTile(
            id: widget.model.id,
            title: widget.model.title,
            picture: widget.model.picture,
            voteAverage: widget.model.voteAverage,
            releaseDate: widget.model.releaseDate,
            description: widget.model.description,
            language: widget.model.language,
          ),
        ]));
  }
}
