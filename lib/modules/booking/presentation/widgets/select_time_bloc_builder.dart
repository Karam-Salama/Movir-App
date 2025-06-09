import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/booking_cubit.dart';
import '../cubits/booking_states.dart';
import 'select_time_widget.dart';
import '../../../../core/utils/app_colors.dart';

class SelectTimeBlocBuilder extends StatelessWidget {
  const SelectTimeBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingCubit, BookingStates>(
      buildWhen: (previous, current) =>
          current is TimesLoadingState ||
          current is TimesSuccessState ||
          current is TimesErrorState ||
          current is TimeSelectedState,
      builder: (context, state) {
        if (state is TimesLoadingState) {
          return const Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor));
        }

        if (state is TimesErrorState) {
          return Text(
            state.error,
            style: const TextStyle(color: AppColors.whiteColor),
          );
        }

        if (state is TimesSuccessState || state is TimeSelectedState) {
          return const SelectTimeWidget();
        }

        return const SizedBox();
      },
    );
  }
}
