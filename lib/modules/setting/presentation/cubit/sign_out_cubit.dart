import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/domain/repos/auth_repo.dart';
import 'sign_out_state.dart';

class SignOutCubit extends Cubit<SignOutState> {
  SignOutCubit({required this.authRepo}) : super(SignOutInitial());
  final AuthRepo authRepo;

  Future<void> signOut() async {
    emit(SignOutLoadingState());
    final result = await authRepo.signOut();
    result.fold(
      (failure) => emit(SignOutErrorState(failure.message)),
      (_) => emit(SignOutSuccessState()),
    );
  }
}
