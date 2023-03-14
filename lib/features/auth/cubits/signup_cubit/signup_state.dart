part of 'signup_cubit.dart';

abstract class SignupState extends Equatable {
  const SignupState();

  @override
  List<Object> get props => [];
}

class SignupInitial extends SignupState {}

class SignupLoading extends SignupState {}

class AccountVerified extends SignupState {}

class AccountCreated extends SignupState {}

class SignupError extends SignupState {
  const SignupError(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}
