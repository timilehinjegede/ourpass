import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:our_pass/core/utils/exceptions.dart';
import 'package:our_pass/core/utils/validators.dart';
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

  Stream<String> get emailStream => _emailController.stream;
  Stream<String> get passwordStream => _passwordController.stream;

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

  Stream<bool> get validateForm => Rx.combineLatest2(
        emailStream,
        passwordStream,
        (a, b) {
          return true;
        },
      );

  Future<void> signin() async {
    final email = _emailController.value.trim();
    final password = _passwordController.value.trim();

    emit(SigninLoading());

    try {
      await authRepository.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      emit(SigninSuccess());
    } on CustomException catch (e) {
      emit(SigninError(e.message));
    }
  }

  void dispose() {
    updateEmail('');
    updatePassword('');
  }
}
