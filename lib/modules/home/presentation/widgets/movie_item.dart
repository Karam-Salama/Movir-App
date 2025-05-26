import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movir_app/core/utils/app_text_styles.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import '../../../../core/utils/api_const.dart';
import '../../../../core/utils/app_assets.dart';
import '../../data/models/movie_model.dart';
import '../cubit/home_cubit.dart';
import '../views/movie_details_view.dart';

class MovieItem extends StatelessWidget {
  const MovieItem({super.key, required this.movieModel});
  final MovieModel movieModel;

  @override
  Widget build(BuildContext context) {
    var itemWidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        PersistentNavBarNavigator.pushNewScreen(
          context,
          screen: MovieDetailsView(movieModel: movieModel),
          withNavBar: false,
          pageTransitionAnimation: PageTransitionAnimation.cupertino,
        );
      },
      child: Stack(
        children: [
          Container(
            width: itemWidth * 0.85,
            height: itemWidth * 0.6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: NetworkImage(
                  '${APIImageUrls.baseImageUrl}${movieModel.backdropPath}',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned.fill(
            top: 150,
            child: Container(
              width: itemWidth * 0.65,
              height: itemWidth * 0.2,
              margin: const EdgeInsets.symmetric(horizontal: 12),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: const DecorationImage(
                  image: AssetImage(Assets.assetsImagesMovieDetailsCard),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movieModel.title!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle.Kanit500style32White.copyWith(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    context
                        .read<HomeCubit>()
                        .getCategoryNamesString(movieModel.genreIds!),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle.Kanit400style12Grey,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        movieModel.voteAverage.toString(),
                        style: AppTextStyle.Kanit400style12Grey,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '(${movieModel.voteCount})',
                        style: AppTextStyle.Kanit400style12Grey,
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
