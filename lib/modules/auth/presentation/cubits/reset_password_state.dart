
class ResetPasswordState {}

final class ResetPasswordInitial extends ResetPasswordState {}

final class ResetPasswordLoadingState extends ResetPasswordState {}

final class ResetPasswordSuccessState extends ResetPasswordState {}

final class ResetPasswordErrorState extends ResetPasswordState {
  final String errorMessage;
  ResetPasswordErrorState({required this.errorMessage});
}
