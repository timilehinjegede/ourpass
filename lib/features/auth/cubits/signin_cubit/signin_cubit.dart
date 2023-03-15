import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:our_pass/core/utils/exceptions.dart';
import 'package:our_pass/core/utils/validators.dart';
import 'package:our_pass/features/auth/data/models/user_model.dart';
import 'package:our_pass/features/auth/data/repository/auth_repository.dart';
import 'package:our_pass/features/auth/data/sources/remote/auth_remote_source.dart';
import 'package:rxdart/rxdart.dart';

part 'signin_state.dart';

class SigninCubit extends Cubit<SigninState> {
  SigninCubit()
      : authRepository = AuthRepository(AuthRemoteSource()),
        super(SigninInitial());

  final AuthRepository authRepository;

  final validator = Validator();

  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _otpController = BehaviorSubject<String>();

  Stream<String> get emailStream => _emailController.stream;
  Stream<String> get passwordStream => _passwordController.stream;
  Stream<String> get otpStream => _otpController.stream;

  /// validates and updates the email field
  void updateEmail(String email) {
    if (validator.isEmailValid(email)) {
      _emailController.sink.add(email);
    } else {
      _emailController.sink.addError('Email is not valid.');
    }
  }

  /// validates and updates the password field
  void updatePassword(String password) {
    if (validator.isInputValid(password)) {
      _passwordController.sink.add(password);
    } else {
      _passwordController.sink.addError('Please enter at least 3 characters.');
    }
  }

  /// validates and updates the otp field used during verification
  void updateOtp(String otp) {
    _otpController.sink.add(otp);
  }

  /// determines if the `Sign In` button  is enabled or not during sign in
  Stream<bool> get validateSignin => Rx.combineLatest2(
        emailStream,
        passwordStream,
        (a, b) {
          /// the values of the form must not be empty and they must have passed individual validations
          return a.isNotEmpty && b.isNotEmpty;
        },
      );

  /// determines if the `Verify` button is enabled or not during verification
  Stream<bool> get validateVerification => Rx.combineLatest(
        [otpStream],

        /// the length of the otp must be equals to 6 digits
        (a) => a.first.length == 6,
      );

  /// signs in a user
  Future<void> signin() async {
    final email = _emailController.value.trim();
    final password = _passwordController.value.trim();

    emit(SigninLoading());

    try {
      final userId = await authRepository.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      /// check if the user trying to sign in is a verified user
      final isVerified = await isUserVerified(userId);

      if (isVerified) {
        /// emit a success state if they are verified
        emit(SigninSuccess());
      } else {
        /// emit a verify account state if they are not verified
        emit(VerifyAccount());
      }
    } on CustomException catch (e) {
      emit(SigninError(e.message));
    }
  }

  /// verifies a user that has not beein previously verified
  Future<void> verifyUser() async {
    emit(SigninLoading());

    try {
      final user = UserModel(
        email: _emailController.value.trim(),
        isVerified: true,
      );

      /// save the updated user records in the database
      await authRepository.saveUser(user);

      emit(SigninSuccess());
    } on CustomException catch (e) {
      emit(SigninError(e.message));
    }
  }

  /// check if a user is verified before asking them to perform verification
  Future<bool> isUserVerified(String? userId) async {
    return await authRepository.isVerified(userId);
  }

  /// reset the values of the cubit
  void reset() {
    _emailController.sink.add('');
    _passwordController.sink.add('');
  }
}
