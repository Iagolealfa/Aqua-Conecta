import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:io';
import 'package:aqua_conecta/components/large_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:aqua_conecta/view_models/login_view_model.dart';
import 'package:provider/provider.dart';
import 'report_vazamento_3.dart';

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

  void _submitReport() async {
    final loginViewModel = Provider.of<LoginViewModel>(context, listen: false);
    final String? userEmail = loginViewModel.userId;

    String description = _descriptionController.text;
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

        if (userName != null) {
          await FirebaseFirestore.instance.collection('vazamento').add({
            'descrição': description,
            'latitude': widget.location.latitude,
            'longitude': widget.location.longitude,
            'image_vazamento': _image?.path,
            'data': dataHoraFormatada,
            'usuario': userEmail,
            'nome': userName,
          });
        } else {
          print('O campo "nome" não foi encontrado no documento do usuário.');
        }
      } catch (e) {
        print(
            'Erro ao buscar o documento do usuário ou adicionar o vazamento: $e');
      }
    } else {
      print('Usuário não logado ou ID do usuário não encontrado.');
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReportSuccessPage(),
      ),
    );
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
            SizedBox(height: 25),
            GestureDetector(
              onTap: _pickImage,
              child: Column(
                children: [
                  Icon(Icons.camera_alt, size: 100, color: Colors.blue),
                  Text('Foto do vazamento'),
                ],
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
            SizedBox(height: 20),
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
              texto: 'Enviar',
              onPressed: _submitReport,
            ),
          ],
        ),
      ),
    );
  }
}
