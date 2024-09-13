import 'package:geocoding/geocoding.dart';

class GeocodingService {
  // Função para obter endereço a partir de coordenadas
  Future<String> getAddressFromCoordinates(
      double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        return "${place.street}, ${place.locality}, ${place.country}";
      }
      return "Endereço não encontrado";
    } catch (e) {
      return "Erro ao obter endereço: $e";
    }
  }

  // Função para obter coordenadas a partir de um endereço
  Future<List<double>> getCoordinatesFromAddress(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        Location location = locations.first;
        return [location.latitude, location.longitude];
      }
      return [];
    } catch (e) {
      print("Erro ao obter coordenadas: $e");
      return [];
    }
  }
}
