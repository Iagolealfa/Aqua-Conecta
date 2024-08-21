import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:io';
import 'package:aqua_conecta/components/large_button.dart';

class ReportDetailsPage extends StatefulWidget {
  final LatLng location;

  ReportDetailsPage({required this.location});

  @override
  _ReportDetailsPageState createState() => _ReportDetailsPageState();
}

class _ReportDetailsPageState extends State<ReportDetailsPage> {
  File? _image;
  final TextEditingController _descriptionController = TextEditingController();
  bool _isPickingImage = false; // Variável de controle

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

  void _submitReport() {
    // Aqui você pode salvar os dados no Firebase
    String description = _descriptionController.text;
    // Substituir com a lógica para salvar a imagem e outros detalhes no Firebase.
    // Exemplo:
    // FirebaseFirestore.instance.collection('vazamento').add({
    //   'latitude': widget.location.latitude,
    //   'longitude': widget.location.longitude,
    //   'description': description,
    //   'image_path': _image?.path, // ou o upload da imagem para Firebase Storage
    // });

    Navigator.pushNamed(context, '/home');
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
            Navigator.pop(context);
          },
        ),
      ),
      resizeToAvoidBottomInset:
          true, // Ajusta o layout quando o teclado aparece
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Adicione informações',
              style: TextStyle(
                  fontSize: 18, color: Color.fromARGB(255, 24, 10, 218)),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.horizontal_rule,
                    size: 50, color: Color.fromARGB(254, 58, 57, 57)),
                Icon(Icons.description, size: 50, color: Colors.blue),
                Icon(Icons.horizontal_rule, size: 50, color: Colors.grey),
              ],
            ),
            SizedBox(height: 120),
            GestureDetector(
              onTap: _pickImage,
              child: Column(
                children: [
                  Icon(Icons.camera_alt, size: 100, color: Colors.blue),
                  Text('Foto do vazamento'),
                ],
              ),
            ),
            SizedBox(height: 70),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                hintText: 'Descreva o vazamento:',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 80),
            LargeButton(
              texto: 'Próximo',
              onPressed: _submitReport,
            ),
          ],
        ),
      ),
    );
  }
}
