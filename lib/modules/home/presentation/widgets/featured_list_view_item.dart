import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import '../../../../core/utils/api_const.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../data/models/movie_model.dart';
import '../cubit/home_cubit.dart';
import '../views/movie_details_view.dart';

class FeaturedListViewItem extends StatelessWidget {
  const FeaturedListViewItem({super.key, required this.movieModel});
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
      child: Container(
        width: itemWidth * 0.5,
        decoration: BoxDecoration(
          color: AppColors.darkColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Color(0x19000000),
              spreadRadius: 0,
              blurRadius: 25,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Column(
                children: [
                  movieModel.posterPath != null
                      ? Flexible(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                              bottomLeft: Radius.circular(16),
                              bottomRight: Radius.circular(16),
                            ),
                            child: Image.network(
                              '${APIImageUrls.baseImageUrl}${movieModel.posterPath}',
                              fit: BoxFit.fill,
                              width: double.infinity,
                            ),
                          ),
                        )
                      : Container(
                          color: Colors.grey,
                          height: 100,
                          width: 100,
                        ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movieModel.title!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyle.Kanit500style32White.copyWith(
                            fontSize: 12,
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
                  )
                ],
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.favorite_outline,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
