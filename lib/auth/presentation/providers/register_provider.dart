import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repository/auth_repository_provider.dart';

final registerProvider =
NotifierProvider<RegisterNotifier, bool>(RegisterNotifier.new);

class RegisterNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  String? error;

  Future<bool> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    state = true;
    error = null;

    try {
      final repository = ref.read(authRepositoryProvider);

      await repository.register(
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