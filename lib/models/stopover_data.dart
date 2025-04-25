import 'location_data.dart';

class Stopovers {
  Location? location;
  String? stopoverStatus;

  Stopovers({
    this.location,
    this.stopoverStatus,
  });

  Stopovers.empty()
      : location = null,
        stopoverStatus = null;

  factory Stopovers.fromJson(Map<String, dynamic> json) => Stopovers(
    location: json['location'] != null
        ? Location.fromJson(json['location'])
        : null,
    stopoverStatus: json['stopoverStatus'],
  );

  Map<String, dynamic> toJson() => {
    'location': location?.toJson(),
    'stopoverStatus': stopoverStatus,
  };
}
