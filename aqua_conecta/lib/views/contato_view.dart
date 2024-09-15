import 'package:flutter/material.dart';
import '../components/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:aqua_conecta/components/large_button.dart';

class ContatoView extends StatefulWidget {
  const ContatoView({Key? key}) : super(key: key);

  static const routeName = '/contato';

  @override
  State<ContatoView> createState() => _ContatoViewState();
}

class _ContatoViewState extends State<ContatoView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  final _firebaseAuth = FirebaseAuth.instance;
  String nome = '';
  String email = '';

  @override
  void initState() {
    super.initState();
    getUser();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      String primeiroNome = _firstNameController.text;
      String ultimoNome = _lastNameController.text;
      String mensagem = _messageController.text;

      String assunto;
      if (primeiroNome.isNotEmpty && ultimoNome.isNotEmpty) {
        assunto = 'Suporte do AquaConecta - $primeiroNome $ultimoNome';
      } else if (primeiroNome.isNotEmpty) {
        assunto = 'Suporte do AquaConecta - $primeiroNome';
      } else if (ultimoNome.isNotEmpty) {
        assunto = 'Suporte do AquaConecta - $ultimoNome';
      } else {
        assunto = 'Suporte do AquaConecta - Sem Nome';
      }

      final Email emailToSend = Email(
        body: mensagem,
        subject: assunto,
        recipients: ['matheusmota14@hotmail.com'],
        cc: [email],
        isHTML: false,
      );

      try {
        await FlutterEmailSender.send(emailToSend);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: const Text('Sua mensagem foi enviada com sucesso!'),
            actions: [
              Center(
                child: SizedBox(
                  width: 97,
                  height: 26,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/home');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2544B4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Ok!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      } catch (error) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: Text('Erro ao enviar a mensagem'),
            actions: [
              Center(
                child: SizedBox(
                  width: 97,
                  height: 26,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2544B4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Ok!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: const Text('Preencha os campos obrigatórios'),
          actions: [
            Center(
              child: SizedBox(
                width: 97,
                height: 26,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2544B4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Ok!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text(
          'Contato',
          style: TextStyle(color: Color(0xFF729AD6)),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 50),
                _buildTextField('Primeiro Nome', _firstNameController, false),
                const SizedBox(height: 8),
                _buildTextField('Último Nome', _lastNameController, false),
                const SizedBox(height: 8),
                _buildTextField('E-Mail', _emailController, true, readOnly: true, isEmail: true),
                const SizedBox(height: 8),
                _buildTextField('Mensagem', _messageController, true, maxLines: 4),
                const SizedBox(height: 30),
                LargeButton(
                  texto: 'Enviar Mensagem',
                  onPressed: _submitForm              ,
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, bool isRequired, {int maxLines = 1, bool readOnly = false, bool isEmail = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF000000),
              ),
            ),
            if (isRequired)
              const Text(
                ' *',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.red,
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          readOnly: readOnly,
          decoration: InputDecoration(
            filled: true,
            fillColor: isEmail ? const Color(0xFFB0B0B0) : const Color(0xFFD6D6D6),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          ),
          validator: (value) {
            if (isRequired && (value == null || value.isEmpty)) {
              return 'Este campo é obrigatório';
            }
            return null;
          },
          enableInteractiveSelection: !readOnly,
        ),
      ],
    );
  }

  getUser() async {
    User? usuario = _firebaseAuth.currentUser;
    if (usuario != null) {
      setState(() {
        nome = usuario.displayName ?? '';
        email = usuario.email ?? '';
        _emailController.text = email;
      });
    }
  }
}
