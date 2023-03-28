import 'package:yandex_geocoder/yandex_geocoder.dart';

class LocationHelper {
  static String generateLocationPreviewImage(
      {double latitude, double longitude}) {
    return 'https://static-maps.yandex.ru/1.x/?lang=en_US&ll=$longitude,$latitude&size=450,200&z=15&l=map&pt=$longitude,$latitude,flag';
  }

  static Future<String> getPlaceAddress(double lat, double long) async {
    final YandexGeocoder geocoder =
        YandexGeocoder(apiKey: 'd72dfc1b-9704-4b89-a68d-715d755acd07');
    final GeocodeResponse response = await geocoder.getGeocode(
      GeocodeRequest(
        lang: Lang.enRu,
        geocode: PointGeocode(latitude: lat, longitude: long),
      ),
    );
    return response.firstAddress.formatted;
  }
}
