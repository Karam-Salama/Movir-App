import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repos/auth_repo.dart';
import 'social_state.dart';

class SignInSocialCubit extends Cubit<SignInSocialState> {
  SignInSocialCubit(this.authRepo) : super(SignInSocialInitial());
  final AuthRepo authRepo;

  Future<void> signInWithGoogle() async {
    emit(SignInGoogleLoadingState());
    final result = await authRepo.signInWithGoogle();
    result.fold(
      (failure) => emit(SignInSocialErrorState(errorMessage: failure.message)),
      (userEntity) => emit(SignInSocialSuccessState(userEntity: userEntity)),
    );
  }

  Future<void> signInWithFacebook() async {
    emit(SignInfacebookLoadingState());
    final result = await authRepo.signInWithFacebook();
    result.fold(
      (failure) => emit(SignInSocialErrorState(errorMessage: failure.message)),
      (userEntity) => emit(SignInSocialSuccessState(userEntity: userEntity)),
    );
  }

  Future<void> signInWithApple() async {
    emit(SignInAppleLoadingState());
    final result = await authRepo.signInWithApple();
    result.fold(
      (failure) => emit(SignInSocialErrorState(errorMessage: failure.message)),
      (userEntity) => emit(SignInSocialSuccessState(userEntity: userEntity)),
    );
  }
}
