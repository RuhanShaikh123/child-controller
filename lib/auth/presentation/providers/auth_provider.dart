import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../data/repository/auth_repository_provider.dart';

final authControllerProvider =
StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(ref);
});

class AuthController extends StateNotifier<bool> {
  AuthController(this.ref) : super(false);

  final Ref ref;

  String? error;

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    state = true;
    error = null;

    try {
      final repo = ref.read(authRepositoryProvider);

      await repo.login(email: email, password: password);

      state = false;
      return true;
    } catch (e) {
      error = e.toString();
      state = false;
      return false;
    }
  }

  Future<bool> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    state = true;
    error = null;

    try {
      final repo = ref.read(authRepositoryProvider);

      await repo.register(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
      );

      state = false;
      return true;
    } catch (e) {
      error = e.toString();
      state = false;
      return false;
    }
  }
}