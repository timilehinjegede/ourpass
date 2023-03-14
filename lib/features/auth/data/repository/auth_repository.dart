import 'package:our_pass/features/auth/data/models/user_model.dart';
import 'package:our_pass/features/auth/data/sources/remote/auth_remote_source.dart';

abstract class IAuthRepository {
  Future<String?> signUpWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<String?> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future saveUser(UserModel user);
}

class AuthRepository implements IAuthRepository {
  AuthRepository(this.authRemoteSource);

  final IAuthRemoteSource authRemoteSource;

  @override
  Future<String?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return authRemoteSource.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<String?> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return authRemoteSource.signUpWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future saveUser(UserModel user) async {
    return authRemoteSource.saveUser(user);
  }
}
