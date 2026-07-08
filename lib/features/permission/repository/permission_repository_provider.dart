import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/datasource/permission_datasource.dart';
import 'permission_repository.dart';

final permissionRepositoryProvider =
Provider<PermissionRepository>((ref) {
  return PermissionRepository(
    PermissionDatasource(),
  );
});