import 'package:flutter/material.dart';

import '../../../../core/functions/enum_paymentMethods.dart';
import '../../data/model/booking_model.dart';
import '../../data/server/models/cinema_model.dart';

@immutable
sealed class BookingStates {}

class BookingInitialState extends BookingStates {}

class CinemasLoadingState extends BookingStates {}

class CinemasSuccessState extends BookingStates {
  final List<CinemaModel> cinemas;

  CinemasSuccessState(this.cinemas);
}

class CinemasErrorState extends BookingStates {
  final String error;

  CinemasErrorState(this.error);
}

class DateSelectedState extends BookingStates {
  final DateTime date;

  DateSelectedState(this.date);
}

class TimeSelectedState extends BookingStates {
  final String time;

  TimeSelectedState(this.time);
}

class CinemaSelectedState extends BookingStates {
  final CinemaModel cinema;

  CinemaSelectedState(this.cinema);
}

// للتواريخ
class DatesLoadingState extends BookingStates {}

class DatesSuccessState extends BookingStates {
  final List<DateTime> dates;

  DatesSuccessState(this.dates);
}

class DatesErrorState extends BookingStates {
  final String error;

  DatesErrorState(this.error);
}

// للأوقات
class TimesLoadingState extends BookingStates {}

class TimesSuccessState extends BookingStates {
  final List<String> times;

  TimesSuccessState(this.times);
}

class TimesErrorState extends BookingStates {
  final String error;

  TimesErrorState(this.error);
}

class SeatSelectionUpdatedState extends BookingStates {
  final List<String> reservedSeats;
  final List<String> selectedSeats;

  SeatSelectionUpdatedState({
    required this.reservedSeats,
    required this.selectedSeats,
  });
}

class BookingStateChanged extends BookingStates {}

class BookingLoading extends BookingStates {}

class BookingSuccess extends BookingStates {
  final Booking booking;
  BookingSuccess(this.booking);
}

class BookingError extends BookingStates {
  final String message;
  BookingError(this.message);
}

class PaymentMethodChangedState extends BookingStates {
  final PaymentMethod method;
  PaymentMethodChangedState(this.method);
}

class SeatsLoadingState extends BookingStates {}

class SeatsLoadedState extends BookingStates {}

class SeatsErrorState extends BookingStates {
  final String error;
  SeatsErrorState(this.error);
}

class TicketsLoading extends BookingStates {}

class TicketsSuccess extends BookingStates {
  final List<Booking> tickets;
  TicketsSuccess(this.tickets);
}

class TicketsError extends BookingStates {
  final String message;
  TicketsError(this.message);
}

class BookingDeletedLoading extends BookingStates {}

class BookingDeletedSuccess extends BookingStates {
  final String bookingId;
  BookingDeletedSuccess(this.bookingId);
}

class BookingDeletedError extends BookingStates {
  final String message;
  BookingDeletedError(this.message);
}
