part of 'signin_cubit.dart';

abstract class SigninState extends Equatable {
  const SigninState();

  @override
  List<Object> get props => [];
}

class SigninInitial extends SigninState {}

class SigninLoading extends SigninState {}

class SigninSuccess extends SigninState {}

class VerifyAccount extends SigninState {}

class SigninError extends SigninState {
  const SigninError(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}
