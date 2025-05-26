import '../../domain/entities/user_entity.dart';

class SignInState {}

final class AuthInitial extends SignInState {}

final class SignInLoadingState extends SignInState {}

final class SignInSuccessState extends SignInState {
  final UserEntity userEntity;
  SignInSuccessState({required this.userEntity});
}

final class SignInErrorState extends SignInState {
  final String errorMessage;
  SignInErrorState({required this.errorMessage});
}

final class ObscurePasswordTextUpdateState extends SignInState {}
