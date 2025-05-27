import 'package:flutter/material.dart';

import '../../../../core/functions/navigation.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../../core/widgets/custom_btn.dart';
import '../../../bottom_nav_bar.dart';
import '../../data/model/booking_model.dart';
import 'confirmation_header_widget.dart';
import 'confirmation_middle_widget.dart';

class ConfirmationViewBody extends StatelessWidget {
  const ConfirmationViewBody({super.key, required this.booking});
  final Booking booking;

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
            Image.asset(Assets.assetsImagesSuccessfulImage),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              height: 420,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Assets.assetsImagesCardBgImage),
                  fit: BoxFit.fill,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.2),
                    BlendMode.darken,
                  ),
                ),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryColor.withOpacity(0.25),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ConfirmationHeaderWidget(booking: booking),
                  const SizedBox(height: 20),
                  ConfirmationMiddleWidget(booking: booking),
                ],
              ),
            ),
            const SizedBox(height: 16),
            CustomButton(
                style: AppTextStyle.Kanit700style16Black,
                backGroundColor: AppColors.primaryColor,
                mainAxisAlignment: MainAxisAlignment.center,
                text: AppStrings.backToHome,
                onPressed: () {
                  customNavigate(context, BottomNavBar.routeName);
                }),
          ],
        ),
      ),
    ));
  }
}
