import 'package:flutter/material.dart';
import 'package:films_viewer/app/other/data.dart';

class MovieWidget extends StatelessWidget {
  const MovieWidget(
      {required this.title,
      required this.picture,
      required this.language,
      required this.voteAverage,
      Key? key})
      : super(key: key);

  final String title;
  final String picture;
  final Language language;
  final double voteAverage;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 68, 52, 49),
        border: Border.all(
          color: const Color.fromARGB(255, 65, 68, 62),
          width: 8,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(children: [
        Image.asset(
          'assets/' + picture,
        ),
        Text(title + ' (Язык: ' + language.toPrettyString() + ')',
            style: const TextStyle(
                color: Color.fromARGB(255, 235, 208, 208),
                fontFamily: 'Verdana',
                fontSize: 24)),
      ]),
    );
  }
}
