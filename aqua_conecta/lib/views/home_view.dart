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
import 'popup_qualidade_vazamento.dart';
import 'package:geolocator/geolocator.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  static const routeName = '/home';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ReportPopup(),
    );
  }

  late GoogleMapController mapController;
  LatLng _center = const LatLng(-8.017788, -34.944763);
  final Map<String, Marker> _markers = {};
  final GetLocation dispAgua = GetLocation(); // Instancia a classe DispAgua
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

  Future<LatLng> _useCurrentLocation() async {
    try {
      await dispAgua.getPosition();
      setState(() {
        _center = LatLng(dispAgua.lat, dispAgua.long);
      });
      return _center!;
    } catch (e) {
      print(e);
      return _center ?? LatLng(-8.017788, -34.944763); // Valor padrão
    }
  }

  Future<void> _updateMarkers() async {
    // Carregar ícones personalizados
    final BitmapDescriptor pinFaltaAgua =
        await _getMarkerIcon('assets/images/pin_falta_agua.png', size: 100);
    final BitmapDescriptor pinAgua =
        await _getMarkerIcon('assets/images/pin_agua.png', size: 100);
    final BitmapDescriptor pinVazamento =
        await _getMarkerIcon('assets/images/pin_vazamento.png', size: 100);

    // Obtemos os dados da coleção 'disponibilidade'
    final queryDisponibilidade =
        await FirebaseFirestore.instance.collection('disponibilidade').get();
    final queryVazamento =
        await FirebaseFirestore.instance.collection('vazamento').get();

    setState(() {
      _markers.clear();

      for (final doc in queryDisponibilidade.docs) {
        final data = doc.data() as Map<String,
            dynamic>; // Assegura que 'data' é um Map<String, dynamic>

        final String? nome = data['nome'];
        final double? latitude = data['latitude'];
        final double? longitude = data['longitude'];
        final String? dataHora = data['data'];
        final bool? disponibilidade = data['resposta'];

        if (nome != null &&
            latitude != null &&
            longitude != null &&
            dataHora != null) {
          // Escolher o ícone com base na disponibilidade
          final BitmapDescriptor icon =
              disponibilidade == true ? pinAgua : pinFaltaAgua;

          // Cria um ID único para cada marcador com base no nome e dataHora
          final String markerId = '${nome}_${dataHora}';

          final marker = Marker(
            markerId: MarkerId(markerId),
            position: LatLng(latitude, longitude),
            infoWindow: InfoWindow(
              title: nome,
              snippet: dataHora,
            ),
            icon: icon,
          );
          _markers[markerId] = marker;
        }
        for (final doc in queryVazamento.docs) {
          final data = doc.data() as Map<String,
              dynamic>; // Assegura que 'data' é um Map<String, dynamic>

          final String? nome = data['nome'];
          final double? latitude = data['latitude'];
          final double? longitude = data['longitude'];
          final String? dataHora = data['data'];
          final String? descricao = data['descrição'];

          if (nome != null &&
              latitude != null &&
              longitude != null &&
              dataHora != null &&
              descricao != null) {
            // Cria um ID único para cada marcador com base no nome e dataHora
            final String markerId = '${nome}_${dataHora}';

            final marker = Marker(
              markerId: MarkerId(markerId),
              position: LatLng(latitude, longitude),
              infoWindow: InfoWindow(
                title: nome,
                snippet: (descricao + dataHora),
              ),
              icon: pinVazamento,
            );
            _markers[markerId] = marker;
          }
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
    // Recebe os argumentos passados
    final LatLng? newCenter =
        ModalRoute.of(context)!.settings.arguments as LatLng?;

    // Atualiza o valor de _center se os argumentos não forem nulos
    if (newCenter != null) {
      setState(() {
        _center = newCenter;
      });
    }

    return Scaffold(
      drawer: const AppDrawer(),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            zoomControlsEnabled: false,
            initialCameraPosition: CameraPosition(
              target: _center ??
                  LatLng(-8.017788,
                      -34.944763), // Valor padrão se _center for nulo
              zoom: 15.0,
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
                  onTap: () => _showBottomSheet(context),
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
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () async {
                    // Chama a função para obter a localização atual
                    LatLng currentLocation = await _useCurrentLocation();

                    // Após obter a localização, navega de volta para a tela Home
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/home',
                      (Route<dynamic> route) => false,
                      arguments:
                          currentLocation, // Passa a localização como argumento
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
                      Icons.location_on,
                      color: Colors.white,
                    ),
                  ),
                )
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
