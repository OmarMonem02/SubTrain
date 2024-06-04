import 'package:geo_sort/geo_sort.dart';

class TestLocation implements HasLocation {
  final int id;
  final String stationName;
  @override
  final double latitude;
  @override
  final double longitude;

  TestLocation({
    required this.id,
    required this.stationName,
    required this.latitude,
    required this.longitude,
  });
}

TestLocation getNearestStation({
  required List<TestLocation> locations,
  required double deviceLatitude,
  required double deviceLongitude,
}) {
  // Sort the list by distance
  final sortedLocations = GeoSort.sortByLatLong<TestLocation>(
    items: locations,
    latitude: deviceLatitude,
    longitude: deviceLongitude,
    ascending: true,
  );

  // Return the nearest location
  return sortedLocations.first;
}
