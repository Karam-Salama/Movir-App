import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repos/auth_repo.dart';
import 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit(this.authRepo) : super(ResetPasswordInitial());
  String? email;
  GlobalKey<FormState> resetPasswordFormKey = GlobalKey<FormState>();
  AutovalidateMode resetPasswordAutoValidateMode = AutovalidateMode.disabled;
  final AuthRepo authRepo;

  Future<void> resetPassword(String email) async {
    try {
      emit(ResetPasswordLoadingState());
      await authRepo.forgetPassword(email);
      emit(ResetPasswordSuccessState());
    } catch (e) {
      emit(ResetPasswordErrorState(errorMessage: e.toString()));
    }
  }
}
