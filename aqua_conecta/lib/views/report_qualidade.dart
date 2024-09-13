import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:aqua_conecta/view_models/login_view_model.dart';
import 'package:provider/provider.dart';
import 'report_qualidade_2.dart';
import '../view_models/location_controller.dart';
import '../services/location_geocoder.dart';

class ReportQualidade extends StatefulWidget {
  @override
  _ReportQualidadeState createState() => _ReportQualidadeState();
}

class _ReportQualidadeState extends State<ReportQualidade> {
  final GeocodingService _geocodingService = GeocodingService();
  final GetLocation dispAgua = GetLocation(); // Inicializando dispAgua
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
      // Opcional: Tratar exceções
      print(e);
    } finally {
      setState(() {
        _isPickingImage = false;
      });
    }
  }

  Future<void> _handleClick(BuildContext context) async {
    await dispAgua.getPosition(); // Obtém a posição

    final loginViewModel = Provider.of<LoginViewModel>(context, listen: false);
    final String? userEmail = loginViewModel.userId;

    DateTime dataHoraAtual = DateTime.now();
    String dataHoraFormatada =
        DateFormat('dd/MM/yyyy HH:mm:ss').format(dataHoraAtual);

    if (userEmail != null) {
      try {
        final DocumentSnapshot<Map<String, dynamic>> userDoc =
            await FirebaseFirestore.instance
                .collection('usuários')
                .doc(userEmail)
                .get();

        final String? userName = userDoc.data()?['nome'];
        String endereco = await _geocodingService.getAddressFromCoordinates(
            dispAgua.lat, dispAgua.long);
        if (userName != null) {
          await FirebaseFirestore.instance.collection('qualidade').add({
            'latitude': dispAgua.lat, // Usando dispAgua para latitude
            'longitude': dispAgua.long, // Usando dispAgua para longitude
            'image_qualidade': _image?.path,
            'MauCheiro': isMauCheiroSelected,
            'Turva': isTurvaSelected,
            'Outros': isOutrosSelected,
            'data': dataHoraFormatada,
            'usuario': userEmail,
            'nome': userName,
            'endereco': endereco
          });
        } else {
          print('O campo "nome" não foi encontrado no documento do usuário.');
        }
      } catch (e) {
        print(
            'Erro ao buscar o documento do usuário ou adicionar o report de qualidade: $e');
      }
    } else {
      print('Usuário não logado ou ID do usuário não encontrado.');
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ConcluidoScreen(),
      ),
    );
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
              child: GestureDetector(
                onTap: _pickImage,
                child: Column(
                  children: [
                    Icon(Icons.camera_alt, size: 100, color: Colors.blue),
                    Text('Foto'),
                  ],
                ),
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
                  _handleClick(context); // Envia os dados ao clicar no botão
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
