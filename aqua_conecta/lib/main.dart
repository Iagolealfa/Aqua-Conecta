import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:aqua_conecta/firebase_options.dart';
import 'package:aqua_conecta/view_models/cadastro_view_model.dart';
import 'package:aqua_conecta/view_models/login_view_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'services/locations.dart' as locations;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: "aqua_conecta",
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Map<String, Marker> _markers = {};

  Future<void> _onMapCreated(GoogleMapController controller) async {
    final googleOffices = await locations.getGoogleOffices();
    setState(() {
      _markers.clear();
      for (final office in googleOffices.offices) {
        final marker = Marker(
          markerId: MarkerId(office.name),
          position: LatLng(office.lat, office.lng),
          infoWindow: InfoWindow(
            title: office.name,
            snippet: office.address,
          ),
        );
        _markers[office.name] = marker;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CadastroViewModel()),
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        // Adicione outros providers se necessário
      ],
      child: SafeArea(
        child: MaterialApp(
          initialRoute: '/onboarding',
          routes: getAppRoutes(),
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: Scaffold(
            appBar: AppBar(
              title: const Text('Google Office Locations'),
              backgroundColor: Colors.green[700],
            ),
            body: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: const CameraPosition(
                target: LatLng(0, 0),
                zoom: 2,
              ),
              markers: _markers.values.toSet(),
            ),
          ),
        ),
      ),
    );
  }
}
