import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movir_app/modules/wishlist/presentation/cubit/favorite_cubit.dart';

import '../../../../core/utils/api_const.dart';
import '../../../wishlist/presentation/cubit/favorite_states.dart';
import '../../data/models/movie_details_model .dart';

class MovieDetailsHeaderSection extends StatelessWidget {
  const MovieDetailsHeaderSection({super.key, required this.movieDetailsModel});
  final MovieDetailsModel movieDetailsModel;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return BlocBuilder<FavoriteCubit, FavoriteStates>(
      builder: (context, state) {
        final favoriteCubit = context.read<FavoriteCubit>();
        final isFavorite =
            favoriteCubit.isMovieInFavorites(movieDetailsModel.id.toString());

        return Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: double.infinity,
              height: height * 0.4,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    APIImageUrls.baseImageUrl + movieDetailsModel.backdropPath!,
                  ),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            Positioned(
              top: 40,
              right: 24,
              child: InkWell(
                onTap: () {
                  if (isFavorite) {
                    favoriteCubit.removeMovieFromFavorites(
                        movieId: movieDetailsModel.id.toString());
                  } else {
                    favoriteCubit.addMovieToFavorites(
                        movieId: movieDetailsModel.id.toString());
                  }
                },
                child: Container(
                  width: 40,
                  height: 40,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Icon(
                    Icons.favorite,
                    color: isFavorite ? Colors.red : Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 40,
              left: 24,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: 40,
                  height: 40,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
