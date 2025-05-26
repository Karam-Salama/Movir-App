import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../cubits/booking_cubit.dart';
import '../cubits/booking_states.dart';
import 'select_date_widget.dart';

class SelectDateBlocBuilder extends StatelessWidget {
  const SelectDateBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingCubit, BookingStates>(
      buildWhen: (previous, current) =>
          current is DatesLoadingState ||
          current is DatesSuccessState ||
          current is DatesErrorState ||
          current is DateSelectedState,
      builder: (context, state) {
        if (state is DatesLoadingState) {
          return const Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor));
        }

        if (state is DatesErrorState) {
          return Text(state.error);
        }

        if (state is DatesSuccessState || state is DateSelectedState) {
          return const SelectDateWidget();
        }

        return const SizedBox();
      },
    );
  }
}
