import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import '../../../../core/utils/api_const.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../home/data/models/movie_model.dart';
import '../../../home/presentation/cubit/home_cubit.dart';
import '../../../home/presentation/views/movie_details_view.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({super.key, required this.movieModel});
  final MovieModel movieModel;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () {
        PersistentNavBarNavigator.pushNewScreen(
          context,
          screen: MovieDetailsView(movieModel: movieModel),
          withNavBar: false,
          pageTransitionAnimation: PageTransitionAnimation.cupertino,
        );
      },
      child: Container(
        width: double.infinity,
        height: width * 0.4,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: AssetImage(Assets.assetsImagesReviewCard),
            fit: BoxFit.cover,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 100,
              height: 120,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    movieModel.posterPath == null
                        ? "${APIImageUrls.baseImageUrl}/kyeqWdyUXW608qlYkRqosgbbJyK.jpg"
                        : '${APIImageUrls.baseImageUrl}${movieModel.posterPath}',
                  ),
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    movieModel.title!,
                    style: AppTextStyle.Kanit400style16White,
                    softWrap: true,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    movieModel.genreIds == null
                        ? "Genre"
                        : context
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
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "${movieModel.voteAverage.toString()} / 10",
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
          ],
        ),
      ),
    );
  }
}
