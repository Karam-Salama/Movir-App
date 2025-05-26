import 'package:flutter/material.dart';

import '../../../../core/utils/api_const.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../data/model/booking_model.dart';

class ConfirmationHeaderWidget extends StatelessWidget {
  const ConfirmationHeaderWidget({super.key, required this.booking});
  final Booking booking;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 80,
          height: 110,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                APIImageUrls.baseImageUrl + booking.moviePoster,
              ),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                booking.movieName,
                style: AppTextStyle.Kanit400style16White.copyWith(
                  color: AppColors.blackColor,
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 40,
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: booking.movieCategories.length,
                  separatorBuilder: (context, index) => const Text(", "),
                  itemBuilder: (context, index) {
                    return Text(
                      booking.movieCategories[index],
                      style: AppTextStyle.Kanit400style16White.copyWith(
                        fontSize: 14,
                        color: AppColors.blackColor,
                      ),
                    );
                  },
                ),
              ),
              Text(
                booking.movieDuration,
                style: AppTextStyle.Kanit400style16White.copyWith(
                  fontSize: 14,
                  color: AppColors.blackColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
