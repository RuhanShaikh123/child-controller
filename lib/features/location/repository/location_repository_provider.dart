import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/location_datasource.dart';
import 'location_repository.dart';

final locationRepositoryProvider =
Provider((ref){

  return LocationRepository(
    LocationDatasource(),
  );

});