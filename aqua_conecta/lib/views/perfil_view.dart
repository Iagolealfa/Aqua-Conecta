import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import '../components/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:aqua_conecta/services/auth_service.dart';

class PerfilView extends StatefulWidget {
  const PerfilView({Key? key}) : super(key: key);

  static const routeName = '/perfil';

  @override
  State<PerfilView> createState() => _PerfilViewState();
}

class _PerfilViewState extends State<PerfilView>
    with SingleTickerProviderStateMixin {
  bool isAvailable = true;
  bool _isContactVisible = false;
  bool _isLoading = false;
  String imageURL = '';
  final ImagePicker _picker = ImagePicker();
  final _telefoneController = TextEditingController();
  final _bioController = TextEditingController();
  final _firebaseAuth = FirebaseAuth.instance;
  String nome = '';
  String email = '';
  String _telefone = '';

  @override
  void initState() {
    super.initState();
    getUser();
    _loadProfileImage();
  }

  Future<void> _loadProfileImage() async {
    if (email.isEmpty) return;

    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('usuários')
        .doc(email)
        .get();

    if (userDoc.exists) {
      String? url = userDoc.get('imageURL');

      if (url != null) {
        setState(() {
          imageURL = url;
        });
      }
    }
  }

  void _toggleAvailability() {
    setState(() {
      isAvailable = !isAvailable;
    });
  }

  void _toggleContactVisibility() {
    setState(() {
      _isContactVisible = !_isContactVisible;
    });
  }

  Future<void> _pickImage(ImageSource source) async {
    setState(() {
      _isLoading = false;
    });

    XFile? pickedFile = await _picker.pickImage(source: source);

    if (pickedFile == null) return;

    setState(() {
      _isLoading = true;
    });

    if (email.isEmpty) {
      await getUser();
    }

    Reference perfilRoot = FirebaseStorage.instance.ref().child('foto_perfil');
    Reference perfilImage = perfilRoot.child("img_$email");

    await perfilImage.putFile(File(pickedFile.path));
    String imageURL = await perfilImage.getDownloadURL();

    await FirebaseFirestore.instance.collection('usuários').doc(email).update({
      'imageURL': imageURL,
    });

    setState(() {
      this.imageURL = imageURL;
      _isLoading = false;
    });
  }

  void _showProfilePictureOptions() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Foto de perfil',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      _pickImage(ImageSource.camera);
                      Navigator.pop(context);
                    },
                    child: const Column(
                      children: [
                        Icon(Icons.camera_alt, size: 40),
                        SizedBox(height: 8),
                        Text('Câmera'),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _pickImage(ImageSource.gallery);
                      Navigator.pop(context);
                    },
                    child: const Column(
                      children: [
                        Icon(Icons.image, size: 40),
                        SizedBox(height: 8),
                        Text('Galeria'),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _showEditPopup(String type) {
    if (type == 'phone') {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: const Center(child: Text('Editar telefone')),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                const Text(
                  'Telefone',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 16),
                ),
                TextField(
                  controller: _telefoneController,
                  decoration: const InputDecoration(
                    hintText: 'Digite seu telefone',
                    hintStyle: TextStyle(fontSize: 14),
                  ),
                  keyboardType: TextInputType.phone,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Cancelar',
                  style: TextStyle(color: Color(0xFF2544B4)),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  String telefone = _telefoneController.text.trim();
                  if (telefone.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('O telefone não pode estar vazio'),
                      ),
                    );
                    return;
                  }
                  try {
                    if (email.isNotEmpty) {
                      await FirebaseFirestore.instance
                          .collection('usuários')
                          .doc(email)
                          .update({'telefone': telefone});
                      setState(() {
                        _telefone = telefone;
                      });
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Telefone salvo com sucesso'),
                        ),
                      );
                    }
                  } catch (e) {
                    print("Erro ao salvar o telefone: $e");
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Erro ao salvar o telefone'),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2544B4), // Cor de fundo
                ),
                child: const Text(
                  'Salvar',
                  style: TextStyle(color: Colors.white), // Cor do texto
                ),
              ),
            ],
          );
        },
      );
    } else if (type == 'bio') {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: const Center(child: Text('Editar bio')),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                const Text(
                  'Bio',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 16),
                ),
                TextField(
                  controller: _bioController,
                  decoration: const InputDecoration(
                    hintText: 'Digite sua bio',
                    hintStyle: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Cancelar',
                  style: TextStyle(color: Color(0xFF2544B4)),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  String bio = _bioController.text.trim();
                  try {
                    if (email.isNotEmpty) {
                      await FirebaseFirestore.instance
                          .collection('usuários')
                          .doc(email)
                          .update({'bio': bio});
                      setState(() {
                        // Atualiza o valor da bio na interface
                      });
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Bio salva com sucesso'),
                        ),
                      );
                    }
                  } catch (e) {
                    print("Erro ao salvar a bio: $e");
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Erro ao salvar a bio'),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2544B4), // Cor de fundo
                ),
                child: const Text(
                  'Salvar',
                  style: TextStyle(color: Colors.white), // Cor do texto
                ),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Perfil',
          style: TextStyle(color: Color(0xFF729AD6)),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      drawer: const AppDrawer(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Stack(
              alignment: Alignment.center,
              children: [
                GestureDetector(
                  onTap: _showProfilePictureOptions,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: const Color(0xFF729AD6),
                    backgroundImage:
                        imageURL.isNotEmpty ? NetworkImage(imageURL) : null,
                    child: imageURL.isEmpty
                        ? const Icon(
                            Icons.person,
                            size: 60,
                            color: Colors.white,
                          )
                        : null,
                  ),
                ),
                if (_isLoading) // Exibe o indicador de carregamento se estiver carregando
                  const CircularProgressIndicator(),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              authService.getUserName() ?? '',
              style: const TextStyle(
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    '330 pontos',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Checkbox(
                        value: isAvailable,
                        onChanged: (bool? value) {
                          _toggleAvailability();
                        },
                        activeColor: Colors.lightGreen,
                      ),
                      GestureDetector(
                        onTap: _toggleAvailability,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: Text(
                            isAvailable ? 'Disponível' : 'Indisponível',
                            style: TextStyle(
                              fontSize: 20,
                              color: isAvailable ? Colors.green : Colors.red,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 5),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _toggleContactVisibility,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(color: Colors.black12),
                  ),
                ),
                child: const Text(
                  'Entre em contato',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: Container(
                height: _isContactVisible ? 40.0 : 0.0,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFFF8F8F8),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                child: Visibility(
                  visible: _isContactVisible,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              const Text(
                                'Telefone: ',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                _telefone,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                            width: 10), // Espaço fixo entre o texto e o ícone
                        GestureDetector(
                          onTap: () => _showEditPopup('phone'),
                          child: const Icon(
                            Icons.edit,
                            color: Colors.black54,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Bio:',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF729AD6),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () => _showEditPopup('bio'),
                        child: const Icon(
                          Icons.edit,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _bioController.text.isEmpty
                        ? 'Sem bio'
                        : _bioController.text,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF729AD6),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Future<void> getUser() async {
    User? usuario = _firebaseAuth.currentUser;
    if (usuario != null) {
      setState(() {
        nome = usuario.displayName ?? '';
        email = usuario.email ?? '';
      });

      try {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('usuários')
            .doc(email)
            .get();
        if (userDoc.exists) {
          setState(() {
            _telefone = userDoc.get('telefone') ?? '';
            _bioController.text = userDoc.get('bio') ?? ''; // Carrega a bio
          });
        }
      } catch (error) {
        print("Erro ao carregar dados do usuário: $error");
      }
    }
  }
}