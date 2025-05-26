import 'package:flutter/material.dart';

import '../../../../core/utils/app_assets.dart';
import '../../data/model/booking_model.dart';
import '../widgets/confirmation_view_body.dart';

class ConfirmationView extends StatelessWidget {
  const ConfirmationView({super.key, required this.booking});
  final Booking booking;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Assets.assetsImagesHomeBg),
              fit: BoxFit.cover,
            ),
          ),
          child: ConfirmationViewBody(booking: booking)),
    );
  }
}
