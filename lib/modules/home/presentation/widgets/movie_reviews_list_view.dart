import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

import '../../../../core/utils/api_const.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../data/models/review_model.dart';

class MovieReviewsListView extends StatelessWidget {
  const MovieReviewsListView({super.key, required this.reviewList});
  final List<MovieReviewModel> reviewList;

  @override
  Widget build(BuildContext context) {
    if (reviewList.isEmpty) {
      return SizedBox(
        height: 120,
        child: Center(
          child: Text(
            'No reviews available',
            style: AppTextStyle.Kanit400style16White,
          ),
        ),
      );
    }

    return SizedBox(
      height: 150,
      child: ListView.builder(
        itemCount: reviewList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final review = reviewList[index];
          return Container(
            width: MediaQuery.of(context).size.width * 0.8,
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: const DecorationImage(
                image: AssetImage(Assets.assetsImagesReviewCard),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Author info row
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: AppColors.lightGrey2,
                        backgroundImage: _getAuthorImage(review),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          review.authorDetails?.username?.isNotEmpty ?? false
                              ? review.authorDetails!.username!
                              : 'Anonymous',
                          style: AppTextStyle.Kanit500style32White.copyWith(
                            fontSize: 16,
                            color: AppColors.lighterGrey,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      // Rating
                      if (review.authorDetails?.rating != null)
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.star,
                              color: AppColors.primaryColor,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              review.authorDetails!.rating.toString(),
                              style: AppTextStyle.Kanit500style32White.copyWith(
                                fontSize: 14,
                                color: AppColors.lighterGrey,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Review content
                  Expanded(
                    child: SingleChildScrollView(
                      child: ReadMoreText(
                        review.content ?? 'No review content',
                        trimLines: 3,
                        trimMode: TrimMode.Line,
                        trimCollapsedText: ' more',
                        trimExpandedText: ' less',
                        moreStyle: AppTextStyle.Kanit500style32White.copyWith(
                          fontSize: 14,
                          color: AppColors.primaryColor,
                        ),
                        lessStyle: AppTextStyle.Kanit500style32White.copyWith(
                          fontSize: 14,
                          color: AppColors.primaryColor,
                        ),
                        style: AppTextStyle.Kanit400style16White.copyWith(
                          fontSize: 14,
                          color: AppColors.lightGrey2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  ImageProvider? _getAuthorImage(MovieReviewModel review) {
    if (review.authorDetails?.avatarPath == null) {
      return const AssetImage(Assets.assetsImagesUserAvatar);
    }

    // Handle cases where avatarPath might be a full URL
    final avatarPath = review.authorDetails!.avatarPath!;
    if (avatarPath.startsWith('http')) {
      return NetworkImage(avatarPath);
    }

    return NetworkImage(
      '${APIImageUrls.baseImageUrl}$avatarPath',
    );
  }
}
