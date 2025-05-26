import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movir_app/modules/booking/presentation/views/checkout_view.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../../core/widgets/custom_btn.dart';
import '../../../home/data/models/movie_details_model .dart';
import '../cubits/booking_cubit.dart';
import 'booking_view_app_bar.dart';
import 'sammay_section.dart';

class SummaryViewBody extends StatelessWidget {
  const SummaryViewBody({super.key, required this.movieDetailsModel});
  final MovieDetailsModel movieDetailsModel;

  @override
  Widget build(BuildContext context) {
    final bookingCubit = context.read<BookingCubit>();
    return SafeArea(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.fromLTRB(20, 16, 20, 40),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(text: AppStrings.summary),
              const SizedBox(height: 30),
              SammaySection(movieDetailsModel: movieDetailsModel),
              const SizedBox(height: 24),
              CustomButton(
                text: AppStrings.checkout,
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider.value(
                        value: bookingCubit,
                        child:
                            CheckoutView(movieDetailsModel: movieDetailsModel),
                      ),
                    ),
                  );
                },
                style: AppTextStyle.Kanit700style16Black,
                backGroundColor: AppColors.primaryColor,
                mainAxisAlignment: MainAxisAlignment.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
