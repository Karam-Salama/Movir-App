import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movir_app/modules/booking/presentation/cubits/booking_cubit.dart';
import 'package:movir_app/modules/home/data/models/movie_details_model%20.dart';

import '../../../../core/service/service_locator.dart';
import '../../../../core/utils/app_assets.dart';
import '../../domain/repos/booking_repo.dart';
import '../widgets/booking_view_body.dart';

class BookingView extends StatelessWidget {
  const BookingView({super.key, required this.movieDetailsModel});
  static const String routeName = '/booking_view';
  final MovieDetailsModel movieDetailsModel;

  @override
  Widget build(BuildContext context) {
    final bookingCubit = BookingCubit(bookingRepo: getIt<BookingRepo>())
      ..initMovieDetails(movieDetailsModel)
      ..loadInitialData()
      ..getCinemas()
      ..getAvailableDates();

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.assetsImagesHomeBg),
            fit: BoxFit.cover,
          ),
        ),
        child: BlocProvider.value(
          value: bookingCubit,
          child: BookingViewBody(movieDetailsModel: movieDetailsModel),
        ),
      ),
    );
  }
}
