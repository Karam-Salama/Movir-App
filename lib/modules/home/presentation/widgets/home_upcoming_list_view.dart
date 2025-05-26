import 'package:flutter/material.dart';

import '../../data/models/movie_model.dart';
import 'featured_list_view_item.dart';

class HomeUpcomingListView extends StatelessWidget {
  const HomeUpcomingListView({super.key, required this.movies});
  final List<MovieModel> movies;

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
            child: FeaturedListViewItem(movieModel: movies[index]),
          );
        },
      ),
    );
  }
}
