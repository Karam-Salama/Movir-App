import 'package:flutter/material.dart';

import '../../data/models/movie_model.dart';
import 'movie_item.dart';

class MovieListView extends StatelessWidget {
  final List<MovieModel> movies;

  const MovieListView({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    var itemHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      height: itemHeight * 0.35,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: MovieItem(movieModel: movies[index]),
          );
        },
      ),
    );
  }
}
