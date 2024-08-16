import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../view_models/location_controller.dart'; // Importe sua classe DispAgua

class PopupAgua extends StatelessWidget {
  final DispAgua dispAgua;

  const PopupAgua({Key? key, required this.dispAgua}) : super(key: key);

  Future<void> _handleClick(BuildContext context, bool resposta) async {
    if (resposta) {
      await dispAgua.getPosition();
    }
    Navigator.of(context).pop({
      'resposta': resposta,
      'latitude': dispAgua.lat,
      'longitude': dispAgua.long,
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      contentPadding: EdgeInsets.all(16.0),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.help_outline,
            color: Colors.blue,
            size: 50,
          ),
          SizedBox(height: 16.0),
          Text(
            "Tem água na sua casa?",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.0),
          Text(
            "Informe se há água disponível",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, // Cor de fundo
                  side: BorderSide(color: Colors.blue), // Borda azul
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: () => _handleClick(context, true),
                child: Text(
                  "Sim",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Cor de fundo azul
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: () => _handleClick(context, false),
                child: Text(
                  "Não",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
