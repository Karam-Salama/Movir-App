import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/functions/enum_paymentMethods.dart';
import '../../../home/data/models/movie_details_model .dart';
import '../../data/server/models/cinema_model.dart';
import '../../domain/repos/booking_repo.dart';
import 'booking_states.dart';

class BookingCubit extends Cubit<BookingStates> {
  final BookingRepo bookingRepo;
  BookingCubit({required this.bookingRepo}) : super(BookingInitialState());

  String? name;
  String? phone;
  String? email;
  GlobalKey<FormState> checkoutFormKey = GlobalKey<FormState>();
  AutovalidateMode checkoutAutoValidateMode = AutovalidateMode.disabled;

  PaymentMethod paymentMethod = PaymentMethod.visa;

  List<DateTime> availableDates = [];
  DateTime? selectedDate;

  List<String> availableTimes = [];
  String? selectedTime;

  CinemaModel? selectedCinema;
  List<CinemaModel> cinemas = [];

  List<String> selectedSeats = [];

  Future<void> confirmBooking(MovieDetailsModel movie) async {
    emit(BookingLoading());
    try {
      // Validate all fields
      if (name!.isEmpty || phone!.isEmpty || email!.isEmpty) {
        emit(BookingError('All fields are required'));
      }

      // Here you would typically:
      // 1. Process payment (based on paymentMethod)
      // 2. Save booking to database/API
      // 3. Send confirmation email

      await Future.delayed(const Duration(seconds: 2)); // Simulate API call

      emit(BookingSuccess());
    } catch (e) {
      emit(BookingError(e.toString()));
    }
  }

  void changePaymentMethod(PaymentMethod method) {
    paymentMethod = method;
    emit(PaymentMethodChangedState(method));
  }

  void toggleSeatSelection(String seatId) {
    if (selectedSeats.contains(seatId)) {
      selectedSeats.remove(seatId);
    } else {
      selectedSeats.add(seatId);
    }
    emit(SeatSelectionUpdatedState());
  }

  bool isSeatSelected(String seatId) {
    return selectedSeats.contains(seatId);
  }

  Future<void> getCinemas() async {
    emit(CinemasLoadingState());
    final cinemas = await bookingRepo.getCinemas();
    cinemas.fold(
      (failure) => emit(CinemasErrorState(failure)),
      (cinemas) => emit(CinemasSuccessState(cinemas)),
    );
  }

  void selectCinema(CinemaModel cinema) {
    selectedCinema = cinema;
    emit(CinemaSelectedState(cinema));
  }

  Future<void> getAvailableDates() async {
    emit(DatesLoadingState());
    final result = await bookingRepo.getAvailableDates();
    result.fold(
      (failure) => emit(DatesErrorState(failure)),
      (dates) {
        availableDates = dates;
        emit(DatesSuccessState(dates));
        if (dates.isNotEmpty) {
          selectDate(dates.first); // اختياري
        }
      },
    );
  }

  Future<void> getAvailableTimes(DateTime date) async {
    emit(TimesLoadingState());
    final result = await bookingRepo.getAvailableTimes(date);
    result.fold(
      (failure) => emit(TimesErrorState(failure)),
      (times) {
        availableTimes = times;
        emit(TimesSuccessState(times));
        if (times.isNotEmpty) {
          selectTime(times.first); // اختياري
        }
      },
    );
  }

  void selectDate(DateTime date) {
    selectedDate = date;
    emit(DateSelectedState(date));
  }

  void selectTime(String time) {
    selectedTime = time;
    emit(TimeSelectedState(time));
  }
}
