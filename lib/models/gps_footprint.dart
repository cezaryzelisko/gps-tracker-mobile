class GPSFootprint {
  double lat;
  double lng;
  DateTime publishedAt;

  GPSFootprint(this.lat, this.lng, this.publishedAt);

  GPSFootprint.fromMap(dynamic data) {
    lat = data['lat'];
    lng = data['lng'];
    publishedAt = DateTime.parse(data['published_at']);
  }
}
