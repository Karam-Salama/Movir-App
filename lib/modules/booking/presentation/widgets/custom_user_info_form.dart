import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import '../../../../core/functions/enum_paymentMethods.dart';
import '../../../../core/functions/validation.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../../core/widgets/custom_btn.dart';
import '../../../home/data/models/movie_details_model .dart';
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
    final bookingCubit = context.read<BookingCubit>();
    return BlocConsumer<BookingCubit, BookingStates>(
      listener: (context, state) {
        if (state is BookingError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
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
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  AppStrings.paymentMethod,
                  style:
                      AppTextStyle.Kanit400style16White.copyWith(fontSize: 18),
                ),
              ),
              const SizedBox(height: 8),
              CustomPaymentMethod(
                method: PaymentMethod.wallet,
                selectedMethod: bookingCubit.selectedPaymentMethod,
                onChanged: (method) {
                  if (method != null) {
                    bookingCubit.selectPaymentMethod(method);
                  }
                },
              ),
              const SizedBox(height: 8),
              CustomPaymentMethod(
                method: PaymentMethod.visa,
                selectedMethod: bookingCubit.selectedPaymentMethod,
                onChanged: (method) {
                  if (method != null) {
                    bookingCubit.selectPaymentMethod(method);
                  }
                },
              ),
              const SizedBox(height: 8),
              CustomPaymentMethod(
                method: PaymentMethod.paypal,
                selectedMethod: bookingCubit.selectedPaymentMethod,
                onChanged: (method) {
                  if (method != null) {
                    bookingCubit.selectPaymentMethod(method);
                  }
                },
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
                      text: AppStrings.payNow,
                      onPressed: () => _handlePayment(context, bookingCubit),
                    ),
            ],
          ),
        );
      },
    );
  }

  void _handlePayment(BuildContext context, BookingCubit bookingCubit) async {
    if (bookingCubit.checkoutFormKey.currentState!.validate()) {
      bookingCubit.checkoutFormKey.currentState!.save();

      switch (bookingCubit.selectedPaymentMethod) {
        case PaymentMethod.paypal:
          _handlePayWithPayPal(context, bookingCubit);
          break;
        case PaymentMethod.visa:
          // Implement visa payment
          break;
        case PaymentMethod.wallet:
          // Implement wallet payment
          break;
      }
    } else {
      setState(() {
        bookingCubit.checkoutAutoValidateMode = AutovalidateMode.always;
      });
    }
  }

  void _handlePayWithPayPal(
      BuildContext context, BookingCubit bookingCubit) async {
    if (bookingCubit.checkoutFormKey.currentState!.validate()) {
      bookingCubit.checkoutFormKey.currentState!.save();
      final totalPrice = bookingCubit.selectedSeats.length * 40;

      final paypalPayment = PaypalPaymentEntity(
        description: 'Movie Ticket for ${widget.movieDetailsModel.title}',
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
              try {
                final paymentId = params['paymentId'] ??
                    'pay_${DateTime.now().millisecondsSinceEpoch}';
                final result =
                    await bookingCubit.confirmBooking(paymentId: paymentId);

                result.fold(
                  (error) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(error)));
                    return error;
                  },
                  (booking) async {
                    // إعادة تحميل المقاعد المحجوزة قبل الانتقال
                    await bookingCubit.loadReservedSeats();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ConfirmationView(booking: booking),
                      ),
                    );
                    return booking;
                  },
                );
              } catch (e) {
                return 'Error: ${e.toString()}';
              }
            },
            onError: (error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Payment failed: $error')),
              );
            },
            onCancel: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Payment cancelled')),
              );
            },
          ),
        ),
      );
    } else {
      setState(() {
        bookingCubit.checkoutAutoValidateMode = AutovalidateMode.always;
      });
    }
  }
}

class CustomPaymentMethod extends StatelessWidget {
  const CustomPaymentMethod({
    super.key,
    required this.method,
    required this.selectedMethod,
    required this.onChanged,
  });
  final PaymentMethod method;
  final PaymentMethod? selectedMethod;
  final ValueChanged<PaymentMethod?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.primaryColor,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            _getIcon(),
            color: AppColors.primaryColor,
            size: 24,
          ),
          const SizedBox(width: 10),
          Text(method.name, style: AppTextStyle.Kanit400style16White),
          const Spacer(),
          Radio<PaymentMethod>(
            value: method,
            groupValue: selectedMethod,
            onChanged: onChanged,
            activeColor: AppColors.primaryColor,
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }

  IconData _getIcon() {
    switch (method) {
      case PaymentMethod.wallet:
        return Icons.account_balance_wallet;
      case PaymentMethod.visa:
        return Icons.credit_card;
      case PaymentMethod.paypal:
        return Icons.paypal;
    }
  }
}
