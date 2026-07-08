import '../data/location_datasource.dart';

class LocationRepository {

  final LocationDatasource datasource;

  LocationRepository(this.datasource);

  Future<void> uploadLocation({
    required double latitude,
    required double longitude,
  }) {

    return datasource.uploadLocation(
      latitude: latitude,
      longitude: longitude,
    );

  }

}