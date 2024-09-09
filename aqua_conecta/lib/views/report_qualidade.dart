import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Import necessário
import 'dart:io'; // Import para trabalhar com arquivos

class ReportQualidade extends StatefulWidget {
  @override
  _ReportQualidadeState createState() => _ReportQualidadeState();
}

class _ReportQualidadeState extends State<ReportQualidade> {
  // Variáveis para manter o estado dos checkboxes
  bool isTurvaSelected = false;
  bool isMauCheiroSelected = false;
  bool isOutrosSelected = false;
  File? _image; // Variável para armazenar a imagem capturada
  bool _isPickingImage = false; // Variável de controle

  // Método para capturar a imagem com a câmera
  Future<void> _pickImage() async {
    if (_isPickingImage) return; // Não faz nada se já está ativo

    setState(() {
      _isPickingImage = true;
    });

    try {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedImage =
          await picker.pickImage(source: ImageSource.camera);

      if (pickedImage != null) {
        setState(() {
          _image = File(pickedImage.path);
        });
      }
    } catch (e) {
      // Tratamento de exceções, se necessário
      print(e);
    } finally {
      setState(() {
        _isPickingImage = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Qualidade da Água'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.location_on, size: 50, color: Colors.blue),
                Icon(Icons.horizontal_rule, size: 50, color: Colors.grey),
              ],
            ),
            Text(
              'Adicione uma foto e selecione o(s) problema(s)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 25),
            Center(
              child: IconButton(
                icon: Icon(Icons.add_a_photo, size: 70, color: Colors.blue),
                onPressed: _pickImage, // Chama o método para capturar a imagem
              ),
            ),
            SizedBox(height: 20),
            if (_image != null) // Verifica se há uma imagem capturada
              Center(
                child: Image.file(
                  _image!,
                  width: 200,
                  height: 200,
                ),
              ),
            CheckboxListTile(
              title: Text('Turva'),
              value: isTurvaSelected,
              onChanged: (bool? value) {
                setState(() {
                  isTurvaSelected = value ?? false;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Mau cheiro'),
              value: isMauCheiroSelected,
              onChanged: (bool? value) {
                setState(() {
                  isMauCheiroSelected = value ?? false;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Outros'),
              value: isOutrosSelected,
              onChanged: (bool? value) {
                setState(() {
                  isOutrosSelected = value ?? false;
                });
              },
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Lógica para enviar os dados
                },
                child: Text('Enviar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
