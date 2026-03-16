import '../models/user.dart';

class AuthService {
  Future<User> signIn({
    required String email,
    required String password,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 350));

    return User(
      id: 'user-1',
      name: 'Coach Patrick',
      email: email,
      teamId: 'team-1',
    );
  }

  Future<User> register({
    required String name,
    required String email,
    required String password,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 350));

    return User(
      id: 'user-2',
      name: name,
      email: email,
      teamId: 'team-1',
    );
  }
}

