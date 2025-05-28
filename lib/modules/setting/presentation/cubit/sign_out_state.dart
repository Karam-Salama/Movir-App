class SignOutState {}

final class SignOutInitial extends SignOutState {}

final class SignOutLoadingState extends SignOutState {}

final class SignOutSuccessState extends SignOutState {}

final class SignOutErrorState extends SignOutState {
  final String message;
  SignOutErrorState(this.message);
}
