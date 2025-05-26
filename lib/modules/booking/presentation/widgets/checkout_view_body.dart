import 'package:flutter/material.dart';

import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../home/data/models/movie_details_model .dart';
import 'booking_view_app_bar.dart';
import 'custom_user_info_form.dart';

class CheckoutViewBody extends StatelessWidget {
  const CheckoutViewBody({super.key, required this.movieDetailsModel});
  final MovieDetailsModel movieDetailsModel;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.fromLTRB(20, 16, 20, 40),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(text: AppStrings.checkout),
              const SizedBox(height: 30),
              Text(
                AppStrings.customerInfo,
                style: AppTextStyle.Kanit400style16White.copyWith(fontSize: 18),
              ),
              const SizedBox(height: 8),
              CustomUserInfoForm(movieDetailsModel: movieDetailsModel),
            ],
          ),
        ),
      ),
    );
  }
}
