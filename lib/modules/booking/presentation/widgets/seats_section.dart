import 'package:flutter/material.dart';

import '../../../../core/utils/api_const.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../home/data/models/movie_details_model .dart';
import 'seat_row_widget.dart';
import 'seat_status_widget.dart';

class SeatsSection extends StatelessWidget {
  const SeatsSection({
    super.key,
    required this.movieDetailsModel,
    required this.cinemaId,
  });
  final MovieDetailsModel movieDetailsModel;
  final String cinemaId;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Assets.assetsImagesReviewCard),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryColor.withOpacity(0.4),
                  blurRadius: 20,
                  spreadRadius: 2,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Container(
              width: double.infinity,
              height: 120,
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
          ),
          const SizedBox(height: 16),
          SeatRowWidget(
            seatCount: 6,
            rowNumber: 1,
            movieId: movieDetailsModel.id.toString(),
            cinemaId: cinemaId,
          ),
          SeatRowWidget(
            seatCount: 8,
            rowNumber: 2,
            movieId: movieDetailsModel.id.toString(),
            cinemaId: cinemaId,
          ),
          SeatRowWidget(
            seatCount: 8,
            rowNumber: 3,
            movieId: movieDetailsModel.id.toString(),
            cinemaId: cinemaId,
          ),
          SeatRowWidget(
            seatCount: 8,
            rowNumber: 4,
            movieId: movieDetailsModel.id.toString(),
            cinemaId: cinemaId,
          ),
          SeatRowWidget(
            seatCount: 6,
            rowNumber: 5,
            movieId: movieDetailsModel.id.toString(),
            cinemaId: cinemaId,
          ),
          const SizedBox(height: 8),
          Divider(
            color: AppColors.lightGrey2.withOpacity(0.5),
            thickness: 1,
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SeatStatusWidget(
                text: AppStrings.reserved,
                color: AppColors.whiteColor,
              ),
              SeatStatusWidget(
                text: AppStrings.available,
                color: AppColors.lightGrey2,
              ),
              SeatStatusWidget(
                text: AppStrings.selected,
                color: AppColors.primaryColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
