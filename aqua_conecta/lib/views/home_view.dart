import 'dart:async'; // Importação para Timer
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../components/drawer.dart';
import '../components/popup_disponibilidade.dart';
import '../view_models/location_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:typed_data';
import 'package:image/image.dart' as img;

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  static const routeName = '/home';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late GoogleMapController mapController;
  final LatLng _center = const LatLng(-8.017788, -34.944763);
  final Map<String, Marker> _markers = {};
  final DispAgua dispAgua = DispAgua(); // Instancia a classe DispAgua
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startMarkerUpdateTimer();
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancelar o timer quando o widget for destruído
    super.dispose();
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    await _updateMarkers(); // Atualiza os marcadores quando o mapa é criado
  }

  Future<void> _updateMarkers() async {
    // Carregar ícones personalizados
    final BitmapDescriptor pinFaltaAgua =
        await _getMarkerIcon('assets/images/pin_falta_agua.png', size: 100);
    final BitmapDescriptor pinAgua =
        await _getMarkerIcon('assets/images/pin_agua.png', size: 100);

    // Obtemos os dados da coleção 'disponibilidade'
    final querySnapshot =
        await FirebaseFirestore.instance.collection('disponibilidade').get();

    setState(() {
      _markers.clear();

      for (final doc in querySnapshot.docs) {
        final data = doc.data();

        final String? nome = data['nome'];
        final double? latitude = data['latitude'];
        final double? longitude = data['longitude'];
        final String? dataHora = data['data'];
        final bool? disponibilidade = data['resposta'];

        if (nome != null && latitude != null && longitude != null) {
          // Escolher o ícone com base na disponibilidade
          final BitmapDescriptor icon =
              disponibilidade == true ? pinAgua : pinFaltaAgua;

          final marker = Marker(
            markerId: MarkerId(nome),
            position: LatLng(latitude, longitude),
            infoWindow: InfoWindow(
              title: nome,
              snippet: dataHora,
            ),
            icon: icon,
          );
          _markers[nome] = marker;
        }
      }
    });
  }

  Future<BitmapDescriptor> _getMarkerIcon(String assetPath,
      {int size = 100}) async {
    final ByteData byteData = await rootBundle.load(assetPath);
    final Uint8List uint8list = byteData.buffer.asUint8List();

    // Redimensionar a imagem
    final img.Image image = img.decodeImage(uint8list)!;
    final img.Image resizedImage =
        img.copyResize(image, width: size, height: size);
    final Uint8List resizedUint8List =
        Uint8List.fromList(img.encodePng(resizedImage));

    return BitmapDescriptor.fromBytes(resizedUint8List);
  }

  void _startMarkerUpdateTimer() {
    _timer = Timer.periodic(Duration(seconds: 30), (Timer t) async {
      await _updateMarkers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            zoomControlsEnabled: false,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 13.0,
            ),
            markers: _markers.values.toSet(), // Adiciona os marcadores
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () async {
                    await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return PopupAgua(dispAgua: dispAgua);
                      },
                    );
                  },
                  child: Container(
                    width: 56,
                    height: 56,
                    decoration: const BoxDecoration(
                      color: Color(0xFF2544B4),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.water_drop_outlined,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    // Ação ao clicar no botão
                  },
                  child: Container(
                    width: 56,
                    height: 56,
                    decoration: const BoxDecoration(
                      color: Color(0xFF2544B4),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 20,
            left: 10,
            child: Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.menu, color: Colors.black),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
