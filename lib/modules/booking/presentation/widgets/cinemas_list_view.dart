import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../cubits/booking_cubit.dart';
import '../cubits/booking_states.dart';

class CinemasListView extends StatelessWidget {
  const CinemasListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingCubit, BookingStates>(
      builder: (context, state) {
        final bookingCubit = context.read<BookingCubit>();
        final cinemas = bookingCubit.cinemas;
        final selectedCinema = bookingCubit.selectedCinema;

        if (cinemas.isEmpty) return const SizedBox();

        return SizedBox(
          height: 70,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: cinemas.length,
            itemBuilder: (context, index) {
              final cinema = cinemas[index];
              final isSelected = cinema == selectedCinema;

              return GestureDetector(
                onTap: () => bookingCubit.selectCinema(cinema),
                child: Container(
                  width: 150,
                  margin: const EdgeInsets.only(right: 8),
                  padding: const EdgeInsets.all(12),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cinema.name,
                        style: TextStyle(
                          color: isSelected
                              ? AppColors.primaryColor
                              : AppColors.whiteColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: isSelected
                                ? AppColors.primaryColor
                                : AppColors.lightGrey2,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              cinema.location,
                              style: TextStyle(
                                color: isSelected
                                    ? AppColors.primaryColor
                                    : AppColors.lightGrey2,
                                fontSize: 12,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
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
