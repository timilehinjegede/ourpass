import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:our_pass/core/utils/exceptions.dart';
import 'package:our_pass/core/utils/validators.dart';
import 'package:our_pass/features/auth/data/models/user_model.dart';
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

  /// validates and updates the first name textfield
  void updateFirstName(String firstName) {
    if (validator.isInputValid(firstName)) {
      _firstNameController.sink.add(firstName);
    } else {
      _firstNameController.sink.addError('Please enter at least 3 characters.');
    }
  }

  /// validates and updates the last name field
  void updateLastName(String lastName) {
    if (validator.isInputValid(lastName)) {
      _lastNameController.sink.add(lastName);
    } else {
      _lastNameController.sink.addError('Please enter at least 3 characters.');
    }
  }

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

  /// determines if the `Get Started` button  is enabled or not during sign up
  Stream<bool> get validateSignup => Rx.combineLatest4(
        firstNameStream,
        lastNameStream,
        emailStream,
        passwordStream,
        (a, b, c, d) {
          /// the values of the form must not be empty and they must have passed individual validations
          return a.isNotEmpty && b.isNotEmpty && c.isNotEmpty && d.isNotEmpty;
        },
      );

  /// determines if the `Verify` button is enabled or not during verification
  Stream<bool> get validateVerification => Rx.combineLatest(
        [otpStream],

        /// the length of the otp must be equals to 6 digits
        (a) => a.first.length == 6,
      );

  /// signs up a user
  Future<void> signup() async {
    final email = _emailController.value.trim();
    final password = _passwordController.value.trim();

    emit(SignupLoading());

    try {
      final userId = await authRepository.signUpWithEmailAndPassword(
        email: email,
        password: password,
      );

      /// save the newly created records in the database
      await saveUser(userId: userId);

      emit(AccountCreated());
    } on CustomException catch (e) {
      emit(SignupError(e.message));
    }
  }

  Future<void> verifyUser() async {
    emit(SignupLoading());

    try {
      /// save the newly created account in the database
      await saveUser(
        isVerified: true,
      );

      emit(AccountVerified());
    } on CustomException catch (e) {
      emit(SignupError(e.message));
    }
  }

  /// takes in a `userId` and `isVerified` value when saving a user's records in the DB
  Future<void> saveUser({
    String? userId,
    bool isVerified = false,
  }) async {

    /// the users record is a new user is the `userId` is not null
    final isCreating = userId != null;

    final email = _emailController.value.trim();
    final firstName = _firstNameController.value.trim();
    final lastName = _lastNameController.value.trim();

    emit(SignupLoading());

    try {
      final user = UserModel(
        id: userId,
        email: email,
        firstName: firstName,
        lastName: lastName,
        isVerified: isVerified,
        /// set the `createdAt` field if it is a new user
        createdAt: isCreating ? DateTime.now() : null,
        /// set the `updatedAt` field if it is an existing user
        /// and an update to the users records is being performed
        updatedAt: isCreating ? null : DateTime.now(),
      );

      /// saves the user records to the DB
      await authRepository.saveUser(user);
    } on CustomException catch (e) {
      emit(SignupError(e.message));
    }
  }

  /// reset the values of the cubit
  void reset() {
    _firstNameController.sink.add('');
    _lastNameController.sink.add('');
    _emailController.sink.add('');
    _passwordController.sink.add('');
  }
}
