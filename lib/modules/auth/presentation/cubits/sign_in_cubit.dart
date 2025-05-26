import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repos/auth_repo.dart';
import 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit(this.authRepo) : super(AuthInitial());
  String? email;
  String? password;
  GlobalKey<FormState> signInFormKey = GlobalKey<FormState>();
  AutovalidateMode SignInAutoValidateMode = AutovalidateMode.disabled;
  bool isPasswordVisible = false;

  final AuthRepo authRepo;
  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(ObscurePasswordTextUpdateState());
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    emit(SignInLoadingState());
    final result = await authRepo.signInWithEmailAndPassword(email, password);
    result.fold(
      (failure) => emit(SignInErrorState(errorMessage: failure.message)),
      (userEntity) => emit(SignInSuccessState(userEntity: userEntity)),
    );
  }
}
