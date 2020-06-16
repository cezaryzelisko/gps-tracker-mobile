class GPSFootprint {
  int id;
  double lat;
  double lng;
  DateTime publishedAt;
  int deviceID;

  GPSFootprint(this.id, this.lat, this.lng, this.publishedAt, this.deviceID);

  GPSFootprint.fromMap(dynamic data) {
    id = data['id'];
    lat = data['lat'];
    lng = data['lng'];
    publishedAt = DateTime.parse(data['published_at']);
    deviceID = data['device_id'];
  }
}
