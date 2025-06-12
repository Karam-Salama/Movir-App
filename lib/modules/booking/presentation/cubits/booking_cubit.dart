// ignore_for_file: unnecessary_null_comparison

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/functions/enum_paymentMethods.dart';
import '../../../../core/utils/api_const.dart';
import '../../../home/data/models/movie_details_model .dart';
import '../../data/model/booking_model.dart';
import '../../data/server/models/cinema_model.dart';
import '../../domain/repos/booking_repo.dart';
import 'booking_states.dart';

class BookingCubit extends Cubit<BookingStates> {
  final BookingRepo bookingRepo;
  late MovieDetailsModel movieDetailsModel;

  BookingCubit({required this.bookingRepo}) : super(BookingInitialState());

  // User information
  String? name;
  String? phone;
  String? email;
  GlobalKey<FormState> checkoutFormKey = GlobalKey<FormState>();
  AutovalidateMode checkoutAutoValidateMode = AutovalidateMode.disabled;

  // Current userId
  String uid = FirebaseAuth.instance.currentUser!.uid;
  // Payment
  PaymentMethod paymentMethod = PaymentMethod.visa;

  // Booking details
  List<DateTime> availableDates = [];
  DateTime? selectedDate;
  List<String> availableTimes = [];
  String? selectedTime;
  CinemaModel? selectedCinema;
  List<CinemaModel> cinemas = [];

  // Seats management
  List<String> selectedSeats = [];
  List<String> _reservedSeats = [];

  /// Initialize movie details
  void initMovieDetails(MovieDetailsModel movie) {
    movieDetailsModel = movie;
  }

  /// Check if seat is reserved
  bool isSeatReserved(String seatId) {
    return _reservedSeats.contains(seatId);
  }

  /// Check if seat is selected
  bool isSeatSelected(String seatId) {
    return selectedSeats.contains(seatId);
  }

  /// Confirm booking and save to database

  Future<Either<String, Booking>> confirmBooking({String? paymentId}) async {
    if (uid == null ||
        selectedCinema == null ||
        selectedDate == null ||
        selectedTime == null ||
        selectedSeats.isEmpty) {
      emit(BookingError('Booking details are incomplete or no seats selected'));
      return Left('Booking details are incomplete or no seats selected');
    }

    emit(BookingLoading());

    try {
      final availability = await bookingRepo.areSeatsAvailable(
        movieId: movieDetailsModel.id.toString(),
        cinemaId: selectedCinema!.id.toString(),
        date: selectedDate!,
        time: selectedTime!,
        seats: selectedSeats,
      );

      return await availability.fold(
        (error) async {
          emit(BookingError(error));
          return Left(error);
        },
        (isAvailable) async {
          if (!isAvailable) {
            final error = 'Some seats are no longer available';
            emit(BookingError(error));
            return Left(error);
          }

          final booking = Booking(
            userId: uid,
            movieId: movieDetailsModel.id.toString(),
            movieName: movieDetailsModel.title!,
            moviePoster:
                APIImageUrls.baseImageUrl + movieDetailsModel.posterPath!,
            movieCategories:
                movieDetailsModel.genres!.map((e) => e.name).toList(),
            movieDuration: movieDetailsModel.runtime.toString(),
            cinemaId: selectedCinema!.id.toString(),
            cinemaName: selectedCinema!.name,
            date: selectedDate!,
            time: selectedTime!,
            seats: selectedSeats,
            paymentId: paymentId,
          );

          final result = await bookingRepo.bookMovie(booking);
          return result.fold(
            (error) {
              emit(BookingError(error));
              return Left(error);
            },
            (_) {
              emit(BookingSuccess(booking));
              return Right(booking);
            },
          );
        },
      );
    } catch (e) {
      final error = 'Failed to complete booking: ${e.toString()}';
      emit(BookingError(error));
      return Left(error);
    }
  }

  Future<void> loadInitialData() async {
    await getCinemas();
    await getAvailableDates();
    if (selectedDate != null) {
      await getAvailableTimes(selectedDate!);
    }
    if (selectedCinema != null &&
        selectedDate != null &&
        selectedTime != null) {
      await loadReservedSeats();
    }
  }

  Future<void> loadReservedSeats() async {
    if (selectedCinema == null ||
        selectedDate == null ||
        selectedTime == null) {
      return;
    }

    emit(SeatsLoadingState());

    final result = await bookingRepo.getReservedSeats(
      movieId: movieDetailsModel.id.toString(),
      cinemaId: selectedCinema!.id.toString(),
      date: selectedDate!,
      time: selectedTime!,
    );

    result.fold(
      (error) => emit(SeatsErrorState(error)),
      (reservedSeats) {
        _reservedSeats = reservedSeats;
        selectedSeats = []; // إعادة تعيين المقاعد المحددة
        emit(SeatsLoadedState());
        emit(SeatSelectionUpdatedState(
            reservedSeats: _reservedSeats,
            selectedSeats: selectedSeats)); // إعلام بالتحديث
      },
    );
  }

  /// Check if seats are available
  Future<bool> areSeatsAvailable(List<String> seatsToCheck) async {
    return !seatsToCheck.any((seat) => _reservedSeats.contains(seat));
  }

  /// Toggle seat selection
  void toggleSeatSelection(String seatId) {
    if (selectedSeats.contains(seatId)) {
      selectedSeats.remove(seatId);
    } else {
      selectedSeats.add(seatId);
    }
    emit(SeatSelectionUpdatedState(
        reservedSeats: _reservedSeats, selectedSeats: selectedSeats));
  }

  /// Change payment method
  void changePaymentMethod(PaymentMethod method) {
    paymentMethod = method;
    emit(PaymentMethodChangedState(method));
  }

  /// Get cinemas list
  Future<void> getCinemas() async {
    emit(CinemasLoadingState());
    final result = await bookingRepo.getCinemas();
    result.fold(
      (failure) => emit(CinemasErrorState(failure)),
      (cinemas) {
        this.cinemas = cinemas;
        emit(CinemasSuccessState(cinemas));
      },
    );
  }

  /// Select cinema and load reserved seats
  Future<void> selectCinema(CinemaModel cinema) async {
    selectedCinema = cinema;
    emit(CinemaSelectedState(cinema));

    selectedSeats = [];
    _reservedSeats = [];

    if (selectedDate != null && selectedTime != null) {
      await loadReservedSeats();
    }
    emit(SeatSelectionUpdatedState(
        reservedSeats: _reservedSeats, selectedSeats: selectedSeats));
  }

  Future<void> getAvailableDates() async {
    emit(DatesLoadingState());
    try {
      final result = await bookingRepo.getAvailableDates();
      result.fold(
        (failure) => emit(DatesErrorState(failure)),
        (dates) {
          availableDates = dates;
          emit(DatesSuccessState(dates));
          if (dates.isNotEmpty) {
            selectDate(dates.first); // سيحدث الحالة تلقائياً
          }
        },
      );
    } catch (e) {
      emit(DatesErrorState(e.toString()));
    }
  }

  Future<void> getAvailableTimes(DateTime date) async {
    emit(TimesLoadingState());
    try {
      final result = await bookingRepo.getAvailableTimes(date);
      result.fold(
        (failure) => emit(TimesErrorState(failure)),
        (times) {
          availableTimes = times;
          emit(TimesSuccessState(times));
          if (times.isNotEmpty) {
            selectTime(times.first); // سيحدث الحالة تلقائياً
          }
        },
      );
    } catch (e) {
      emit(TimesErrorState(e.toString()));
    }
  }

  void selectDate(DateTime date) async {
    selectedDate = date;
    emit(DateSelectedState(date));

    if (selectedCinema != null) {
      await getAvailableTimes(date);
    }

    if (selectedCinema != null && selectedTime != null) {
      await loadReservedSeats(); // إعادة تحميل المقاعد المحجوزة
    }
  }

  void selectTime(String time) {
    selectedTime = time;
    emit(TimeSelectedState(time));

    if (selectedCinema != null && selectedDate != null) {
      loadReservedSeats(); // إعادة تحميل المقاعد المحجوزة
    }
  }

  // في BookingCubit
  void getUserTickets() async {
    emit(TicketsLoading());
    try {
      final ticketsStream = bookingRepo.getUserBookings(uid);
      ticketsStream.listen((bookings) {
        emit(TicketsSuccess(bookings));
      }, onError: (error) {
        emit(TicketsError(error.toString()));
      });
    } catch (e) {
      emit(TicketsError('Failed to load tickets: ${e.toString()}'));
    }
  }

  Future<void> deleteBooking(String bookingId) async {
    emit(BookingDeletedLoading());
    try {
      final result = await bookingRepo.deleteBooking(bookingId);
      result.fold(
        (error) => emit(BookingError(error)),
        (_) {
          emit(BookingDeletedSuccess(bookingId));
          getUserTickets(); // تحديث القائمة بعد الحذف
        },
      );
    } catch (e) {
      emit(BookingDeletedError('Failed to delete booking: ${e.toString()}'));
    }
  }
}
