import '../../domain/entities/user_entity.dart';

class SignUpState {}

final class AuthInitial extends SignUpState {}

final class SignUpLoadingState extends SignUpState {}

final class SignUpSuccessState extends SignUpState {
  final UserEntity userEntity;
  SignUpSuccessState({required this.userEntity});
}

final class SignUpErrorState extends SignUpState {
  final String errorMessage;
  SignUpErrorState({required this.errorMessage});
}

final class UpdateTermsAndConditionsState extends SignUpState {}

final class ObscurePasswordTextUpdateState extends SignUpState {}
