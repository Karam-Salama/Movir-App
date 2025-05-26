import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../cubits/booking_cubit.dart';
import 'custom_sammary_middle_row.dart';

class SammaryMiddleWidget extends StatelessWidget {
  const SammaryMiddleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bookingCubit = context.read<BookingCubit>();
    final totalPrice = bookingCubit.selectedSeats.length * 40;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomSammaryMiddleRow(
          text1: "Cinema",
          text2: bookingCubit.selectedCinema?.name ?? 'Not selected',
        ),
        const SizedBox(height: 12),
        CustomSammaryMiddleRow(
            text1: "Date",
            text2:
                bookingCubit.selectedDate?.toLocal().toString().split(' ')[0] ??
                    'Not selected'),
        const SizedBox(height: 12),
        CustomSammaryMiddleRow(
            text1: "Time", text2: bookingCubit.selectedTime ?? 'Not selected'),
        const SizedBox(height: 12),
        CustomSammaryMiddleRow(
            text1: "Seat", text2: bookingCubit.selectedSeats.join(', ')),
        const SizedBox(height: 20),
        Divider(
          color: AppColors.lightGrey2,
          thickness: 1,
        ),
        const SizedBox(height: 8),
        CustomSammaryMiddleRow(text1: "Total", text2: "\$ ${totalPrice}"),
      ],
    );
  }
}
