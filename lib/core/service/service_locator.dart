import 'package:dio/dio.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movir_app/core/api/api_consumer.dart';
import 'package:movir_app/modules/booking/domain/repos/booking_repo.dart';
import 'package:movir_app/modules/wishlist/data/repos/favorite_repo_implementation.dart';
import 'package:movir_app/modules/wishlist/domain/repos/favorite_repo.dart';

import '../../modules/auth/data/repos/auth_repo_implement.dart';
import '../../modules/auth/domain/repos/auth_repo.dart';
import 'package:get_it/get_it.dart';

import '../../modules/booking/data/server/repos/booking_repo_imple.dart';
import '../../modules/home/data/repos/home_repo_implment.dart';
import '../../modules/home/domain/repos/home_repo.dart';
import '../../modules/search/data/repos/search_repo_Imple.dart';
import '../../modules/search/domain/search_repo.dart';
import '../api/dio_consumer.dart';
import '../database/cache_helper.dart';
import 'database_service.dart';
import 'service_firebase_auth.dart';
import 'service_firebase_firestore.dart';

final getIt = GetIt.instance;

void setUpServiceLocator() {
  // Initialize Firebase Firestore
  final firestore = FirebaseFirestore.instance;

  // Register services
  getIt.registerSingleton<CacheHelper>(CacheHelper());
  getIt.registerSingleton<FirebaseAuthService>(FirebaseAuthService());
  getIt.registerSingleton<DatabaseService>(FirabaseFirestoreService());

  // Register repositories
  getIt.registerSingleton<AuthRepo>(
    AuthRepoImplement(
      firebaseAuthService: getIt<FirebaseAuthService>(),
      databaseService: getIt<DatabaseService>(),
    ),
  );

  // Dio and API Consumers
  getIt.registerSingleton<Dio>(Dio());
  getIt.registerSingleton<ApiConsumer>(DioConsumer(dio: getIt<Dio>()));

  // Register Home and Search Repositories
  getIt
      .registerSingleton<HomeRepo>(HomeRepoImplment(api: getIt<ApiConsumer>()));
  getIt.registerSingleton<SearchRepo>(
      SearchRepoImple(api: getIt<ApiConsumer>()));

  // Register Booking Repository with Firestore dependency
  getIt.registerSingleton<BookingRepo>(
    BookingRepoImpl(firestore: firestore), // تم التعديل هنا
  );

  getIt.registerSingleton<FavoriteRepo>(
    FavoriteRepoImplementation(
      firabaseFirestoreService: FirabaseFirestoreService(),
    ),
  );
}
