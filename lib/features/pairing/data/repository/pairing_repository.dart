
import '../datasource/pairing_datasource.dart';

class PairingRepository {
  final PairingDatasource datasource;

  PairingRepository(this.datasource);

  Future<void> connect(String code) {
    return datasource.connect(code);
  }
}