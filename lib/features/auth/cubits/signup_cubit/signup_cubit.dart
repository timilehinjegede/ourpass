import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:our_pass/core/utils/exceptions.dart';
import 'package:our_pass/core/utils/validators.dart';
import 'package:our_pass/features/auth/data/repository/auth_repository.dart';
import 'package:our_pass/features/auth/data/sources/remote/auth_remote_source.dart';
import 'package:rxdart/rxdart.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit()
      : authRepository = AuthRepository(AuthRemoteSource()),
        super(SignupInitial());

  final AuthRepository authRepository;

  final validator = Validator();
  final formKey = GlobalKey<FormState>();

  final _firstNameController = BehaviorSubject<String>();
  final _lastNameController = BehaviorSubject<String>();
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _otpController = BehaviorSubject<String>();

  Stream<String> get firstNameStream => _firstNameController.stream;
  Stream<String> get lastNameStream => _lastNameController.stream;
  Stream<String> get emailStream => _emailController.stream;
  Stream<String> get passwordStream => _passwordController.stream;
  Stream<String> get otpStream => _otpController.stream;

  void updateFirstName(String firstName) {
    if (validator.isInputValid(firstName)) {
      _firstNameController.sink.add(firstName);
    } else {
      _firstNameController.sink.addError('Please enter at least 3 characters.');
    }
  }

  void updateLastName(String lastName) {
    if (validator.isInputValid(lastName)) {
      _lastNameController.sink.add(lastName);
    } else {
      _lastNameController.sink.addError('Please enter at least 3 characters.');
    }
  }

  void updateEmail(String email) {
    if (validator.isEmailValid(email)) {
      _emailController.sink.add(email);
    } else {
      _emailController.sink.addError('Email is not valid.');
    }
  }

  void updatePassword(String password) {
    if (validator.isInputValid(password)) {
      _passwordController.sink.add(password);
    } else {
      _passwordController.sink.addError('Please enter at least 3 characters.');
    }
  }

  void updateOtp(String otp) {
    _otpController.sink.add(otp);
  }

  Stream<bool> get validateSignup => Rx.combineLatest4(
        firstNameStream,
        lastNameStream,
        emailStream,
        passwordStream,
        (a, b, c, d) {
          return true;
        },
      );
  Stream<bool> get validateVerification => Rx.combineLatest(
        [otpStream],
        (a) => a.first.length == 6,
      );

  Future<void> signup() async {
    final email = _emailController.value.trim();
    final password = _passwordController.value.trim();

    emit(SignupLoading());

    try {
      await authRepository.signUpWithEmailAndPassword(
        email: email,
        password: password,
      );

      emit(AccountCreated());
    } on CustomException catch (e) {
      emit(SignupError(e.message));
    }
  }

  Future<void> verifyEmail() async {
    final email = _emailController.value.trim();

    emit(SignupLoading());

    try {
      await authRepository.verifyEmail(email);

      emit(AccountVerified());
    } on CustomException catch (e) {
      emit(SignupError(e.message));
    }
  }
}
