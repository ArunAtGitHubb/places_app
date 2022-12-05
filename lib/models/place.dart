import 'dart:io';

class Place {
  final id, title;
  final Location location;
  final File image;

  Place({
    required this.id,
    required this.title,
    required this.image,
    required this.location,
  });
}

class Location {
  double latitude, logitude;
  String address;

  Location({
    required this.latitude,
    required this.logitude,
    required this.address,
  });
}
