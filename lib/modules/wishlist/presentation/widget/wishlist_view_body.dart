import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movir_app/modules/wishlist/presentation/cubit/favorite_states.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../home/presentation/widgets/featured_list_view_item.dart';
import '../../../home/presentation/widgets/shimmer_movies_list_view.dart';
import '../cubit/favorite_cubit.dart';

class WishlistViewBody extends StatelessWidget {
  const WishlistViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.fromLTRB(20, 16, 20, 40),
        child: BlocBuilder<FavoriteCubit, FavoriteStates>(
          builder: (context, state) {
            if (state is FavoritesMoviesLoading) {
              return const ShimmerFavoriteList();
            }

            if (state is FavoritesMoviesError) {
              return Center(child: Text(state.message));
            }

            if (state is FavoritesMoviesEmpty) {
              return Center(
                child: Text(
                  'No favorite movies yet',
                  style: AppTextStyle.Kanit500style16LighterGrey,
                ),
              );
            }

            if (state is FavoritesMoviesLoaded) {
              final favoriteCubit = context.read<FavoriteCubit>();

              return GridView.builder(
                padding: const EdgeInsets.all(8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: state.movies.length,
                itemBuilder: (context, index) {
                  return FeaturedListViewItem(
                    movieModel: state.movies[index],
                    isFavorite: favoriteCubit
                        .isMovieInFavorites(state.movies[index].id.toString()),
                    onTap: () {
                      final isFavorite = favoriteCubit.isMovieInFavorites(
                          state.movies[index].id.toString());
                      if (isFavorite) {
                        favoriteCubit.removeMovieFromFavorites(
                            movieId: state.movies[index].id.toString());
                      } else {
                        favoriteCubit.addMovieToFavorites(
                            movieId: state.movies[index].id.toString());
                      }
                    },
                  );
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class ShimmerFavoriteList extends StatelessWidget {
  const ShimmerFavoriteList({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.73,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        return const ShimmerMovieItem();
      },
    );
  }
}
