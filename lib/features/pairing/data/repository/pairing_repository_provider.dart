import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../datasource/pairing_datasource.dart';
import 'pairing_repository.dart';

final pairingRepositoryProvider =
Provider<PairingRepository>((ref) {
  return PairingRepository(
    PairingDatasource(),
  );
});