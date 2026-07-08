import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../data/repository/pairing_repository_provider.dart';

final pairingProvider =
StateNotifierProvider<PairingNotifier, bool>((ref) {
  return PairingNotifier(ref);
});

class PairingNotifier extends StateNotifier<bool> {
  PairingNotifier(this.ref) : super(false);

  final Ref ref;

  String? error;

  Future<bool> connect(String code) async {
    state = true;
    error = null;

    try {
      await ref
          .read(pairingRepositoryProvider)
          .connect(code);

      state = false;
      return true;
    } catch (e) {
      error = e.toString();
      state = false;
      return false;
    }
  }
}