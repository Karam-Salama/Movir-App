import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movir_app/core/utils/app_colors.dart';
import 'package:movir_app/core/utils/app_strings.dart';
import 'package:movir_app/modules/booking/presentation/cubits/booking_states.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../../core/widgets/custom_btn.dart';
import '../../../home/data/models/movie_details_model .dart';
import '../cubits/booking_cubit.dart';
import '../views/summary_view.dart';
import 'booking_view_app_bar.dart';
import 'cinemas_list_view_bloc_builder.dart';
import 'seats_section.dart';
import 'select_date_bloc_builder.dart';
import 'select_time_bloc_builder.dart';

class BookingViewBody extends StatelessWidget {
  const BookingViewBody({super.key, required this.movieDetailsModel});
  final MovieDetailsModel movieDetailsModel;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<BookingCubit, BookingStates>(
        builder: (context, state) {
          final bookingCubit = context.read<BookingCubit>();

          return Container(
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(20, 16, 20, 40),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAppBar(text: AppStrings.selectSeatsSubtitle),
                  const SizedBox(height: 16),
                  Text(
                    AppStrings.selectCinemaSubtitle,
                    style: AppTextStyle.Kanit400style16White.copyWith(
                        fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  const CinemasListViewBlocBuilder(),
                  const SizedBox(height: 16),
                  Text(
                    AppStrings.selectDateSubtitle,
                    style: AppTextStyle.Kanit400style16White.copyWith(
                        fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  const SelectDateBlocBuilder(),
                  const SizedBox(height: 16),
                  Text(
                    AppStrings.selectTimeSubtitle,
                    style: AppTextStyle.Kanit400style16White.copyWith(
                        fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  const SelectTimeBlocBuilder(),
                  const SizedBox(height: 16),
                  if (bookingCubit.selectedCinema != null)
                    SeatsSection(
                      movieDetailsModel: movieDetailsModel,
                      cinemaId: bookingCubit.selectedCinema!.id.toString(),
                    )
                  else
                    const Center(
                      child: Text(
                        'Please select cinema first',
                        style: TextStyle(color: AppColors.whiteColor),
                      ),
                    ),
                  const SizedBox(height: 24),
                  CustomButton(
                    text: AppStrings.bookNow,
                    style: AppTextStyle.Kanit700style16Black,
                    backGroundColor: AppColors.primaryColor,
                    mainAxisAlignment: MainAxisAlignment.center,
                    onPressed: () async {
                      print('Selected seats: ${bookingCubit.selectedSeats}');
                      if (bookingCubit.selectedSeats.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Please select at least one seat')),
                        );
                        return;
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider.value(
                            value: bookingCubit,
                            child: SummaryView(
                                movieDetailsModel: movieDetailsModel),
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
