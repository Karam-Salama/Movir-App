import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movir_app/modules/home/presentation/cubit/home_cubit.dart';
import 'package:movir_app/modules/wishlist/presentation/cubit/favorite_cubit.dart';
import 'package:provider/provider.dart';

import 'core/database/cache_helper.dart';
import 'core/functions/check_state_changes_fun.dart';
import 'core/service/service_bloc_observer.dart';
import 'core/service/service_locator.dart';
import 'firebase_options.dart';
import 'modules/booking/domain/repos/booking_repo.dart';
import 'modules/booking/presentation/cubits/booking_cubit.dart';
import 'modules/home/domain/repos/home_repo.dart';
import 'modules/wishlist/domain/repos/favorite_repo.dart';
import 'movir_app.dart';

void main() async {
  Bloc.observer = CustomBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  setUpServiceLocator();
  await getIt<CacheHelper>().init();
  checkStateChanges();

  runApp(
    MultiProvider(
      providers: [
        BlocProvider<HomeCubit>(
          create: (context) => HomeCubit(homeRepo: getIt<HomeRepo>()),
        ),
        BlocProvider<BookingCubit>(
          create: (context) => BookingCubit(bookingRepo: getIt<BookingRepo>()),
        ),
        BlocProvider<FavoriteCubit>(
          create: (context) =>
              FavoriteCubit(favoriteRepo: getIt<FavoriteRepo>())
                ..loadFavoriteMovies(),
        ),
      ],
      child: const MovirApp(),
    ),
  );
}
