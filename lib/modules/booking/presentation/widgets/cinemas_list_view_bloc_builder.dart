import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../cubits/booking_cubit.dart';
import '../cubits/booking_states.dart';
import 'cinemas_list_view.dart';

class CinemasListViewBlocBuilder extends StatelessWidget {
  const CinemasListViewBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingCubit, BookingStates>(
      buildWhen: (previous, current) =>
          current is CinemasLoadingState ||
          current is CinemasSuccessState ||
          current is CinemasErrorState ||
          current is CinemaSelectedState,
      builder: (context, state) {
        if (state is CinemasLoadingState) {
          return const Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor));
        }

        if (state is CinemasErrorState) {
          return Text(state.error);
        }

        if (state is CinemasSuccessState) {
          context.read<BookingCubit>().cinemas = state.cinemas;
          if (state.cinemas.isNotEmpty) {
            context.read<BookingCubit>().selectCinema(state.cinemas.first);
          }
          return const CinemasListView();
        }

        if (state is CinemaSelectedState) {
          return const CinemasListView();
        }

        return const SizedBox();
      },
    );
  }
}
