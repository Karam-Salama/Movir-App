import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';

import '../../../../core/functions/formate_runtime.dart';
import '../../../../core/functions/validation.dart';
import '../../../../core/utils/api_const.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../../core/widgets/custom_btn.dart';
import '../../../home/data/models/movie_details_model .dart';
import '../../data/helpers/booking_database_helper.dart';
import '../../data/model/booking_model.dart';
import '../../domain/entities/paypal_payment_entity.dart';
import '../cubits/booking_cubit.dart';
import '../cubits/booking_states.dart';
import '../views/confirmation_view.dart';
import 'custom_user_info_text_form_field.dart';

class CustomUserInfoForm extends StatefulWidget {
  const CustomUserInfoForm({super.key, required this.movieDetailsModel});
  final MovieDetailsModel movieDetailsModel;
  @override
  State<CustomUserInfoForm> createState() => _CustomUserInfoFormState();
}

class _CustomUserInfoFormState extends State<CustomUserInfoForm> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookingCubit, BookingStates>(
      listener: (context, state) {
        if (state is BookingSuccess) {
          Navigator.pop(context);
        } else if (state is BookingError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
      },
      builder: (context, state) {
        final bookingCubit = context.read<BookingCubit>();
        final totalPrice = bookingCubit.selectedSeats.length * 40;

        return Form(
          key: bookingCubit.checkoutFormKey,
          autovalidateMode: bookingCubit.checkoutAutoValidateMode,
          child: Column(
            children: [
              CustomUserInfoTextFormField(
                hintText: AppStrings.fullName,
                keyboardType: TextInputType.name,
                onSaved: (name) {
                  bookingCubit.name = name;
                },
                validator: Validation.validateName,
              ),
              const SizedBox(height: 16),
              CustomUserInfoTextFormField(
                hintText: AppStrings.email,
                keyboardType: TextInputType.emailAddress,
                onSaved: (email) {
                  bookingCubit.email = email;
                },
                validator: Validation.validateEmail,
              ),
              const SizedBox(height: 16),
              CustomUserInfoTextFormField(
                hintText: AppStrings.phone,
                keyboardType: TextInputType.phone,
                onSaved: (phone) {
                  bookingCubit.phone = phone;
                },
                validator: Validation.validatePhone,
              ),
              const SizedBox(height: 30),
              state is BookingLoading
                  ? const CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    )
                  : CustomButton(
                      style: AppTextStyle.Kanit700style16Black,
                      backGroundColor: AppColors.primaryColor,
                      mainAxisAlignment: MainAxisAlignment.center,
                      text: AppStrings.payWithPayPal,
                      onPressed: () async {
                        if (bookingCubit.checkoutFormKey.currentState!
                            .validate()) {
                          bookingCubit.checkoutFormKey.currentState!.save();
                          final booking = Booking(
                            userId: bookingCubit.uid,
                            movieId: widget.movieDetailsModel.id!.toString(),
                            cinemaId:
                                bookingCubit.selectedCinema!.id.toString(),
                            movieName: widget.movieDetailsModel.title!,
                            movieCategories: widget.movieDetailsModel.genres!
                                .map((e) => e.name)
                                .toList(),
                            moviePoster: APIImageUrls.baseImageUrl +
                                widget.movieDetailsModel.posterPath!,
                            movieDuration: formattedRuntime(
                                widget.movieDetailsModel.runtime!),
                            cinemaName: bookingCubit.selectedCinema!.name,
                            date: bookingCubit.selectedDate!.toIso8601String(),
                            time: bookingCubit.selectedTime!,
                            seats: bookingCubit.selectedSeats,
                            totalPrice: totalPrice,
                          );

                          final paypalPayment = PaypalPaymentEntity(
                            description:
                                'Movie Ticket for ${booking.movieName}',
                            currency: 'USD',
                            amount: totalPrice.toString(),
                          );

                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => PaypalCheckoutView(
                                sandboxMode: true,
                                clientId: KClientId,
                                secretKey: KClientSecret,
                                transactions: [paypalPayment.toJson()],
                                note: "Thank you for booking.",
                                onSuccess: (params) async {
                                  print('Payment success, saving booking...');
                                  try {
                                    await BookingDatabase.insertBooking(
                                        booking);
                                    print(
                                        'Booking saved successfully: ${booking.seats}');
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            BlocProvider.value(
                                          value: bookingCubit,
                                          child: ConfirmationView(
                                            booking: booking,
                                          ),
                                        ),
                                      ),
                                    );
                                  } catch (e) {
                                    print('Error saving booking: $e');
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text('Error saving booking: $e')),
                                    );
                                  }
                                },
                                onError: (error) {},
                                onCancel: () {},
                              ),
                            ),
                          );
                        } else {
                          setState(() {
                            bookingCubit.checkoutAutoValidateMode =
                                AutovalidateMode.always;
                          });
                        }
                      },
                    ),
            ],
          ),
        );
      },
    );
  }
}
