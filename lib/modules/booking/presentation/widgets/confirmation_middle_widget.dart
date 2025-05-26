import 'package:flutter/material.dart';

import '../../../../core/utils/app_assets.dart';
import '../../data/model/booking_model.dart';
import 'custom_confirmation_middle_row.dart';

class ConfirmationMiddleWidget extends StatelessWidget {
  const ConfirmationMiddleWidget({super.key, required this.booking});
  final Booking booking;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomConfirmationMiddleRow(text1: "Cinema", text2: booking.cinemaName),
        const SizedBox(height: 12),
        CustomConfirmationMiddleRow(text1: "Date", text2: booking.date),
        const SizedBox(height: 12),
        CustomConfirmationMiddleRow(text1: "Time", text2: booking.time),
        const SizedBox(height: 12),
        CustomConfirmationMiddleRow(
            text1: "Seat", text2: booking.seats.join(', ')),
        const SizedBox(height: 20),
        Image.asset(Assets.assetsImagesDividerImage),
        const SizedBox(height: 20),
        Image.asset(Assets.assetsImagesBarCodeImage),
      ],
    );
  }
}
