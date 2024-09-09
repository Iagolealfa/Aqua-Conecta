import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'report_vazamento_2.dart';
import 'package:aqua_conecta/components/large_button.dart';

class LocationSelectionPage extends StatefulWidget {
  @override
  _LocationSelectionPageState createState() => _LocationSelectionPageState();
}

class _LocationSelectionPageState extends State<LocationSelectionPage> {
  LatLng? selectedLocation;

  void _selectOnMap() async {
    final LatLng initialLocation = LatLng(-8.017788, -34.944763);

    LatLng? result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MapScreen(initialLocation: initialLocation),
      ),
    );

    if (result != null) {
      setState(() {
        selectedLocation = result;
      });
      _showSuccessDialog(); // Exibe o pop-up de sucesso
    }
  }

  void _useCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition();
      setState(() {
        selectedLocation = LatLng(position.latitude, position.longitude);
      });
      _showSuccessDialog(); // Exibe o pop-up de sucesso
    } catch (e) {
      // Handle the error
      print(e);
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sucesso'),
          content: Text('Localização obtida com sucesso!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o pop-up
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _nextStep() {
    if (selectedLocation != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ReportDetailsPage(
            location: selectedLocation!,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vazamento'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, '/home');
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Informe o local',
              style: TextStyle(
                  fontSize: 18, color: Color.fromARGB(255, 6, 134, 238)),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.location_on, size: 50, color: Colors.blue),
                Icon(Icons.horizontal_rule, size: 50, color: Colors.grey),
                Icon(Icons.horizontal_rule, size: 50, color: Colors.grey),
              ],
            ),
            SizedBox(height: 150),
            GestureDetector(
              onTap: _selectOnMap,
              child: Column(
                children: [
                  Icon(Icons.map, size: 100, color: Colors.blue),
                  Text('Selecione o mapa e adicione o endereço do vazamento.'),
                ],
              ),
            ),
            SizedBox(height: 100),
            GestureDetector(
              onTap: _useCurrentLocation,
              child: Column(
                children: [
                  Text(
                    'Utilizar localização atual',
                    style: TextStyle(fontSize: 18, color: Colors.blue),
                  ),
                  Icon(Icons.my_location, size: 50, color: Colors.blue),
                ],
              ),
            ),
            SizedBox(height: 80),
            LargeButton(
              texto: 'Próximo',
              onPressed: selectedLocation != null ? _nextStep : null,
            ),
          ],
        ),
      ),
    );
  }
}

class MapScreen extends StatelessWidget {
  final LatLng initialLocation;

  MapScreen({required this.initialLocation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selecione a localização'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: initialLocation,
          zoom: 15,
        ),
        onTap: (LatLng location) {
          Navigator.pop(context, location);
        },
      ),
    );
  }
}
