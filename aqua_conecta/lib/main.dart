import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:aqua_conecta/firebase_options.dart';
import 'package:aqua_conecta/view_models/cadastro_view_model.dart'; // Adicione esta linha
import 'package:aqua_conecta/view_models/login_view_model.dart'; // Adicione esta linha

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: "aqua_conecta",
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CadastroViewModel()),
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        // Adicione outros providers se necessário
      ],
      child: MaterialApp(
        initialRoute: '/onboarding',
        routes: getAppRoutes(),
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
      ),
    );
  }
}
