import 'package:dio/dio.dart';
import 'package:movir_app/core/api/api_consumer.dart';
import 'package:movir_app/modules/booking/domain/repos/booking_repo.dart';

import '../../modules/auth/data/repos/auth_repo_implement.dart';
import '../../modules/auth/domain/repos/auth_repo.dart';
import 'package:get_it/get_it.dart';

import '../../modules/booking/data/server/repos/booking_repo_imple.dart';
import '../../modules/home/data/repos/home_repo_implment.dart';
import '../../modules/home/domain/repos/home_repo.dart';
import '../api/dio_consumer.dart';
import '../database/cache_helper.dart';
import 'database_service.dart';
import 'service_firebase_auth.dart';
import 'service_firebase_firestore.dart';

final getIt = GetIt.instance;

void setUpServiceLocator() {
  getIt.registerSingleton<CacheHelper>(CacheHelper());
  getIt.registerSingleton<FirebaseAuthService>(FirebaseAuthService());
  getIt.registerSingleton<DatabaseService>(FirabaseFirestoreService());

  getIt.registerSingleton<AuthRepo>(
    AuthRepoImplement(
        firebaseAuthService: getIt<FirebaseAuthService>(),
        databaseService: getIt<DatabaseService>()),
  );

  // Home and Booking Repositories
  getIt.registerSingleton<Dio>(Dio());
  getIt.registerSingleton<ApiConsumer>(DioConsumer(dio: getIt<Dio>()));
  getIt
      .registerSingleton<HomeRepo>(HomeRepoImplment(api: getIt<ApiConsumer>()));
  getIt.registerSingleton<BookingRepo>(
      BookingRepoImple(api: getIt<ApiConsumer>()));
}
