import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../wishlist/presentation/cubit/favorite_cubit.dart';
import '../../../wishlist/presentation/cubit/favorite_states.dart';
import '../../data/models/movie_model.dart';
import 'featured_list_view_item.dart';

class HomeNowPlayingListView extends StatelessWidget {
  const HomeNowPlayingListView({super.key, required this.movies});
  final List<MovieModel> movies;

  @override
  Widget build(BuildContext context) {
    var itemHeight = MediaQuery.of(context).size.height;
    return BlocBuilder<FavoriteCubit, FavoriteStates>(
      builder: (context, state) {
        final favoriteCubit = context.read<FavoriteCubit>();

        return SizedBox(
          height: itemHeight * 0.35,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: FeaturedListViewItem(
                  movieModel: movies[index],
                  isFavorite: favoriteCubit
                      .isMovieInFavorites(movies[index].id.toString()),
                  onTap: () {
                    final isFavorite = favoriteCubit
                        .isMovieInFavorites(movies[index].id.toString());
                    if (isFavorite) {
                      favoriteCubit.removeMovieFromFavorites(
                          movieId: movies[index].id.toString());
                    } else {
                      favoriteCubit.addMovieToFavorites(
                          movieId: movies[index].id.toString());
                    }
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}
