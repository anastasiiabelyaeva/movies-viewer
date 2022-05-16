import 'package:films_viewer/app/widgets/buttons/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:films_viewer/app/models/film_card_model.dart';
import 'package:films_viewer/app/widgets/image_network.dart';
import 'package:films_viewer/app/widgets/rating_chip.dart';
import 'package:films_viewer/app/widgets/buttons/primary_button.dart';

class FilmCard extends StatelessWidget {
  const FilmCard(
      {required this.id,
      required this.title,
      required this.picture,
      required this.voteAverage,
      required this.releaseDate,
      required this.description,
      required this.language,
      Key? key})
      : super(key: key);

  factory FilmCard.fromModel({required FilmCardModel model, Key? key}) {
    return FilmCard(
      id: model.id,
      title: model.title,
      picture: model.picture,
      voteAverage: model.voteAverage,
      releaseDate: model.releaseDate,
      description: model.description,
      language: model.language,
      key: key,
    );
  }
  final int id;
  final String title;
  final String picture;
  final double voteAverage;
  final String releaseDate;
  final String description;
  final String language;
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: const <BoxShadow>[
            BoxShadow(offset: Offset(1, 2), blurRadius: 5, spreadRadius: 2)
          ]),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: ImageNetwork(picture),
            ),
          ),
          Positioned(
            right: 4,
            top: 2,
            child: RatingChip(voteAverage),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: PrimaryButton(
                'More',
                onPressed: () {
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
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Text(
                title,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    shadows: [
                      Shadow(
                        blurRadius: 40.0,
                        color: Colors.black,
                      ),
                    ]),
              ),
            ),
          ),
          const Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(bottom: 1),
              child: FavoriteButton(),
            ),
          )
        ],
      ),
    );
  }
}
