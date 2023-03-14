import 'package:our_pass/features/auth/data/sources/remote/auth_remote_source.dart';

abstract class IAuthRepository {
  Future signUpWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future verifyEmail(String email);
}

class AuthRepository implements IAuthRepository {
  AuthRepository(this.authRemoteSource);

  final IAuthRemoteSource authRemoteSource;

  @override
  Future signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return authRemoteSource.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return authRemoteSource.signUpWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future verifyEmail(String email) async {
    return authRemoteSource.verifyEmail(email);
  }
}
