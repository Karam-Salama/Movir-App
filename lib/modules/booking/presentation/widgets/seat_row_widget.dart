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
  });

  final int seatCount;
  final int rowNumber;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final seatSize = (screenWidth - 80) / 11;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(seatCount, (index) {
          String seatId = 'R$rowNumber-S$index';

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: BlocBuilder<BookingCubit, BookingStates>(
              builder: (context, state) {
                final cubit = context.read<BookingCubit>();
                final isSelected = cubit.isSeatSelected(seatId);

                return InkWell(
                  onTap: () {
                    cubit.toggleSeatSelection(seatId);
                  },
                  child: Container(
                    width: seatSize,
                    height: seatSize,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primaryColor.withOpacity(0.7)
                          : AppColors.lightGrey2.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.primaryColor
                            : AppColors.lightGrey2.withOpacity(0.5),
                        width: 1,
                      ),
                    ),
                    child: Icon(
                      Icons.chair,
                      color: isSelected ? Colors.white : AppColors.lightGrey2,
                      size: seatSize * 0.6,
                    ),
                  ),
                );
              },
            ),
          );
        }),
      ),
    );
  }
}
