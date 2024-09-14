import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class GetLocation extends ChangeNotifier {
  double lat = 0.0;
  double long = 0.0;
  String erro = '';

  LocationController() {
    getPosition();
  }

  // getPosition() async {
  //   try {
  //     Position posicao = await _posicaoAtual();
  //     lat = posicao.latitude;
  //     long = posicao.longitude;
  //   } catch (e) {
  //     erro = e.toString();
  //   }
  //   notifyListeners();
  // }

  Future<void> getPosition() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      lat = position.latitude;
      long = position.longitude;
      print('Latitude: $lat, Longitude: $long');

    } catch (e) {
      print("Erro ao obter localização: $e");
    }
  }


  Future<Position> _posicaoAtual() async {
    LocationPermission permissao;

    bool ativado = await Geolocator.isLocationServiceEnabled();
    if (!ativado) {
      return Future.error('Por favor, habilite a localização no smartphone');
    }

    permissao = await Geolocator.checkPermission();
    if (permissao == LocationPermission.denied) {
      permissao = await Geolocator.requestPermission();
      if (permissao == LocationPermission.denied) {
        return Future.error('Você precisa autorizar o acesso à localização');
      }
    }

    if (permissao == LocationPermission.deniedForever) {
      return Future.error('Você precisa autorizar o acesso à localização');
    }

    return await Geolocator.getCurrentPosition();
  }
}
