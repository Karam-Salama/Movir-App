import 'package:flutter/material.dart';
import 'package:movir_app/core/utils/app_colors.dart';
import 'package:movir_app/core/utils/app_strings.dart';
import 'package:movir_app/core/widgets/custom_btn.dart';
import 'package:readmore/readmore.dart';
import '../../../../core/functions/formate_runtime.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../booking/presentation/views/booking_view.dart';
import '../../data/models/movie_details_model .dart';
import 'movie_crew_bloc_builder.dart';
import 'movie_reviews_bloc_builder.dart';

class MovieDetailsMiddleSection extends StatelessWidget {
  const MovieDetailsMiddleSection({super.key, required this.movieDetailsModel});
  final MovieDetailsModel movieDetailsModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(24, 24, 24, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            movieDetailsModel.title!,
            style: AppTextStyle.Kanit500style32White.copyWith(
              fontSize: 20,
              color: AppColors.lighterGrey,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            formattedRuntime(movieDetailsModel.runtime!),
            style: AppTextStyle.Kanit500style32White.copyWith(
              fontSize: 16,
              color: AppColors.lightGrey2,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: movieDetailsModel.genres!.length,
              separatorBuilder: (context, index) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.transparent,
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(
                      color: AppColors.lightGrey2,
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      movieDetailsModel.genres![index].name,
                      style: AppTextStyle.Kanit500style32White.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.lightGrey2,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(
                Icons.star,
                color: AppColors.yellowColor,
                size: 16,
              ),
              const SizedBox(width: 4),
              Text(
                '${movieDetailsModel.voteAverage.toString()} / 10',
                style: AppTextStyle.Kanit500style32White.copyWith(
                  fontSize: 16,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '(${movieDetailsModel.voteCount} votes)',
                style: AppTextStyle.Kanit500style32White.copyWith(
                  fontSize: 16,
                  color: AppColors.lightGrey2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          Divider(
            color: AppColors.lightGrey2,
            thickness: 1,
          ),
          const SizedBox(height: 40),
          Text(
            AppStrings.aboutMovie,
            style: AppTextStyle.Kanit500style32White.copyWith(
              fontSize: 20,
              color: AppColors.lighterGrey,
            ),
          ),
          const SizedBox(height: 8),
          ReadMoreText(
            movieDetailsModel.overview!,
            trimLines: 3,
            trimMode: TrimMode.Line,
            trimCollapsedText: ' view more',
            trimExpandedText: ' read less',
            moreStyle: AppTextStyle.Kanit500style32White.copyWith(
              fontSize: 14,
              color: AppColors.lighterGrey,
            ),
            lessStyle: AppTextStyle.Kanit500style32White.copyWith(
              fontSize: 14,
              color: AppColors.lighterGrey,
            ),
            style: AppTextStyle.Kanit400style16White.copyWith(
              fontSize: 14,
              color: AppColors.lightGrey2,
            ),
          ),
          const SizedBox(height: 40),
          Text(
            AppStrings.castSubtitle,
            style: AppTextStyle.Kanit500style32White.copyWith(
              fontSize: 20,
              color: AppColors.lighterGrey,
            ),
          ),
          const SizedBox(height: 8),
          MovieCrewBlocBuilder(),
          const SizedBox(height: 40),
          Text(
            AppStrings.reviewsSubtitle,
            style: AppTextStyle.Kanit500style32White.copyWith(
              fontSize: 20,
              color: AppColors.lighterGrey,
            ),
          ),
          const SizedBox(height: 8),
          const MovieReviewsBlocBuilder(),
          const SizedBox(height: 40),
          Divider(
            color: AppColors.lightGrey2,
            thickness: 1,
          ),
          const SizedBox(height: 40),
          CustomButton(
            text: AppStrings.selectSeats,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookingView(
                    movieDetailsModel: movieDetailsModel,
                  ),
                ),
              );
            },
            style: AppTextStyle.Kanit500style18Black,
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ],
      ),
    );
  }
}
