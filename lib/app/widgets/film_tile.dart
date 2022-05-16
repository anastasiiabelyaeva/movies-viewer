import 'package:films_viewer/app/models/film_card_model.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FilmTile extends StatelessWidget {
  FilmTile(
      {required this.id,
      required this.title,
      required this.picture,
      required this.voteAverage,
      required this.releaseDate,
      required this.description,
      required this.language,
      required this.checkable,
      Key? key})
      : super(key: key);
  final int id;
  final String title;
  final String picture;
  final double voteAverage;
  final String releaseDate;
  final String description;
  final String language;
  late bool checkable = false;
  factory FilmTile.fromModel(
      {required FilmCardModel model, required bool checkable, Key? key}) {
    return FilmTile(
      id: model.id,
      title: model.title,
      picture: model.picture,
      voteAverage: model.voteAverage,
      releaseDate: model.releaseDate,
      description: model.description,
      language: model.language,
      checkable: checkable,
    );
  }

  @override
  Widget build(BuildContext context) {
    return (checkable)
        ? InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/detail',
                  arguments: FilmCardModel(
                      id: id,
                      title: title,
                      picture: picture,
                      voteAverage: voteAverage,
                      releaseDate: releaseDate,
                      description: description,
                      language: language));
            },
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Image.network(picture, loadingBuilder:
                        (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return const Center(child: CircularProgressIndicator());
                })),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Название: ' + title,
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            children: <Widget>[
                              const Padding(
                                padding: EdgeInsets.only(right: 8),
                                child: Icon(Icons.star, color: Colors.yellow),
                              ),
                              Text(
                                voteAverage.toStringAsFixed(1),
                                style: TextStyle(
                                  fontSize: 16,
                                  color: (voteAverage < 4)
                                      ? Colors.red
                                      : (voteAverage >= 8)
                                          ? Colors.green
                                          : Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16, bottom: 8),
                          child: Text(
                            'Дата выхода: $releaseDate',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                        Text(
                          description,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        : Row(
            children: <Widget>[
              Expanded(
                  child: Image.network(picture, loadingBuilder:
                      (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return const Center(child: CircularProgressIndicator());
              })),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Название: ' + title,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          children: <Widget>[
                            const Padding(
                              padding: EdgeInsets.only(right: 8),
                              child: Icon(Icons.star, color: Colors.yellow),
                            ),
                            Text(
                              voteAverage.toStringAsFixed(1),
                              style: TextStyle(
                                fontSize: 16,
                                color: (voteAverage < 4)
                                    ? Colors.red
                                    : (voteAverage >= 8)
                                        ? Colors.green
                                        : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16, bottom: 8),
                        child: Text(
                          'Дата выхода: $releaseDate',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                      Text(
                        description,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
  }
}
