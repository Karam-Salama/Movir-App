import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_assets.dart';
import '../../../home/data/models/movie_details_model .dart';
import '../cubits/booking_cubit.dart';
import '../widgets/summary_view_body.dart';

class SummaryView extends StatelessWidget {
  const SummaryView({
    super.key,
    required this.movieDetailsModel,
  });
  final MovieDetailsModel movieDetailsModel;

  @override
  Widget build(BuildContext context) {
    final bookingCubit = context.read<BookingCubit>();
    if (bookingCubit.selectedSeats.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please select at least one seat')),
        );
        Navigator.pop(context);
      });
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }
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
          child: SummaryViewBody(movieDetailsModel: movieDetailsModel)),
    );
  }
}
