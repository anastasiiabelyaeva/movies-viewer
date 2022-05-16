import 'package:flutter/material.dart';

class RatingChip extends StatelessWidget {
  const RatingChip(this.voteAverage, {Key? key}) : super(key: key);
  final double voteAverage;
  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: const Icon(
        Icons.star,
        color: Colors.yellow,
      ),
      label: Text(
        voteAverage.toStringAsFixed(1),
        style: Theme.of(context)
            .textTheme
            .headline6
            ?.copyWith(color: Colors.white),
      ),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}
