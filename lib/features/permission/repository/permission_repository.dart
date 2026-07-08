
import '../data/datasource/accessibility_channel.dart';
import '../data/datasource/permission_datasource.dart';

class PermissionRepository {
  final PermissionDatasource datasource;

  PermissionRepository(this.datasource);

  Future<void> openAccessibility() {
    return datasource.openAccessibility();
  }

  Future<bool> isAccessibilityEnabled() {
    return datasource.isAccessibilityEnabled();
  }

  Future<void> openUsageAccess() {
    return datasource.openUsageAccess();
  }

  Future<bool> isUsageAccessEnabled() {
    return datasource.isUsageAccessEnabled();
  }
  Future<bool> requestCamera() {
    return datasource.requestCamera();
  }

  Future<bool> requestMicrophone() {
    return datasource.requestMicrophone();
  }

  Future<bool> requestLocation() {
    return datasource.requestLocation();
  }
}