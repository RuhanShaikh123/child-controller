import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../datasource/auth_datasource.dart';
import '../datasource/auth_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(AuthDatasource());
});