class LocationHelper {
  static String generateLocationPreviewImage(
      {double latitude, double longtitude}) {
    return 'https://static-maps.yandex.ru/1.x/?lang=en_US&ll=$longtitude,$latitude&size=450,200&z=15&l=map&pt=$longtitude,$latitude,flag';
  }
}
