import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../cubits/booking_cubit.dart';
import '../cubits/booking_states.dart';

class SelectDateWidget extends StatelessWidget {
  const SelectDateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingCubit, BookingStates>(
      builder: (context, state) {
        final bookingCubit = context.read<BookingCubit>();
        final dates = bookingCubit.availableDates;
        final selectedDate = bookingCubit.selectedDate;

        if (dates.isEmpty) return const SizedBox();

        return Column(
          children: [
            SizedBox(
              height: 70,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: dates.length,
                itemBuilder: (context, index) {
                  final date = dates[index];
                  final isSelected = date == selectedDate;
                  return GestureDetector(
                    onTap: () => bookingCubit.selectDate(date),
                    child: Container(
                      width: 60,
                      margin: const EdgeInsets.only(right: 8),
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _getShortWeekday(date),
                            style: TextStyle(
                              color: isSelected
                                  ? AppColors.primaryColor
                                  : AppColors.whiteColor,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _getDayMonth(date),
                            style: TextStyle(
                              color: isSelected
                                  ? AppColors.primaryColor
                                  : AppColors.whiteColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  String _getShortWeekday(DateTime date) {
    const weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return weekdays[date.weekday - 1];
  }

  String _getDayMonth(DateTime date) {
    return '${date.day}/${date.month}';
  }
}
