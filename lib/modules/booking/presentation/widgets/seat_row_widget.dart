import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../cubits/booking_cubit.dart';
import '../cubits/booking_states.dart';

class SeatRowWidget extends StatelessWidget {
  const SeatRowWidget({
    super.key,
    required this.seatCount,
    required this.rowNumber,
    required this.movieId,
    required this.cinemaId,
  });
  final int seatCount;
  final int rowNumber;
  final String movieId;
  final String cinemaId;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingCubit, BookingStates>(
      builder: (context, state) {
        final bookingCubit = context.read<BookingCubit>();
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(seatCount, (index) {
              String seatId = '$rowNumber-$index';
              bool isReserved = bookingCubit.isSeatReserved(seatId);
              bool isSelected = bookingCubit.isSeatSelected(seatId);

              print(
                  'Seat $seatId - Reserved: $isReserved, Selected: $isSelected');

              return SeatItem(
                seatId: seatId,
                isReserved: isReserved,
                isSelected: isSelected,
                onTap: isReserved
                    ? null
                    : () => bookingCubit.toggleSeatSelection(seatId),
              );
            }),
          ),
        );
      },
    );
  }
}

class SeatItem extends StatelessWidget {
  final String seatId;
  final bool isReserved;
  final bool isSelected;
  final VoidCallback? onTap;

  const SeatItem({
    super.key,
    required this.seatId,
    required this.isReserved,
    required this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final seatSize = (screenWidth - 80) / 11;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: seatSize,
          height: seatSize,
          decoration: BoxDecoration(
            color: isReserved
                ? Colors.white
                : isSelected
                    ? AppColors.primaryColor.withOpacity(0.7)
                    : AppColors.lightGrey2.withOpacity(0.2),
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: isReserved
                  ? Colors.white
                  : isSelected
                      ? AppColors.primaryColor
                      : AppColors.lightGrey2.withOpacity(0.5),
            ),
          ),
          child: Icon(
            Icons.chair,
            color: isReserved
                ? Colors.black
                : isSelected
                    ? Colors.white
                    : AppColors.lightGrey2,
            size: seatSize * 0.6,
          ),
        ),
      ),
    );
  }
}
