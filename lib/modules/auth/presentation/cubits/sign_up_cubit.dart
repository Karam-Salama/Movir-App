import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repos/auth_repo.dart';
import 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this.authRepo) : super(AuthInitial());
  String? name;
  String? emailAddress;
  String? password;
  GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  AutovalidateMode SignUpAutoValidateMode = AutovalidateMode.disabled;
  bool isPasswordVisible = false;
  bool? isTermsAndConditionsAccepted = false;

  final AuthRepo authRepo;

  void updateTermsAndConditionsCheckbox({required bool newValue}) {
    isTermsAndConditionsAccepted = newValue;
    emit(UpdateTermsAndConditionsState());
  }

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(ObscurePasswordTextUpdateState());
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password, String name) async {
    emit(SignUpLoadingState());
    final result =
        await authRepo.createUserWithEmailAndPassword(email, password, name);
    result.fold(
      (failure) => emit(SignUpErrorState(errorMessage: failure.message)),
      (userEntity) => emit(SignUpSuccessState(userEntity: userEntity)),
    );
  }
}
