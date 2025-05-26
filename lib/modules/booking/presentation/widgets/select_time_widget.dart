import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../cubits/booking_cubit.dart';
import '../cubits/booking_states.dart';

class SelectTimeWidget extends StatelessWidget {
  const SelectTimeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingCubit, BookingStates>(
      builder: (context, state) {
        final bookingCubit = context.read<BookingCubit>();
        final times = bookingCubit.availableTimes;
        final selectedTime = bookingCubit.selectedTime;

        return SizedBox(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: times.length,
            itemBuilder: (context, index) {
              final time = times[index];
              final isSelected = time == selectedTime;

              return GestureDetector(
                onTap: () => bookingCubit.selectTime(time),
                child: Container(
                  margin: const EdgeInsets.only(right: 8),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.darkColor
                        : AppColors.transparent,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.primaryColor
                          : AppColors.lightGrey2,
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      time,
                      style: TextStyle(
                        color: isSelected
                            ? AppColors.primaryColor
                            : AppColors.whiteColor,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
