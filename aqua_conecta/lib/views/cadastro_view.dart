import 'package:flutter/material.dart';
import 'package:aqua_conecta/components/large_button.dart';
import 'package:aqua_conecta/services/autenticacao_service.dart';

class CadastroView extends StatefulWidget {
  const CadastroView({super.key});

  @override
  _CadastroViewState createState() => _CadastroViewState();
}

class _CadastroViewState extends State<CadastroView> {
  final _formKey = GlobalKey<FormState>();
  bool _showPassword = true;

  TextEditingController _usuarioController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _senhaController = TextEditingController();
  TextEditingController _confirmaSenhaController = TextEditingController();
  TextEditingController _enderecoController = TextEditingController();

  AutenticacaoServico _autenticacaoServico = AutenticacaoServico();

  cadastro() {
    String usuario = _usuarioController.text;
    String email = _emailController.text;
    String senha = _senhaController.text;
    String confirmasenha = _confirmaSenhaController.text;
    String endereco = _enderecoController.text;

    print(
        "${_usuarioController.text}, ${_emailController.text}, ${_senhaController.text},${_enderecoController.text},");
    _autenticacaoServico.cadastrarUsuario(
        nome: usuario,
        email: email,
        senha: senha,
        confirmaSenha: confirmasenha,
        endereco: endereco);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(
          top: 20,
          left: 40,
          right: 40,
        ),
        color: const Color.fromRGBO(255, 255, 255, 1),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              const Text(
                'Cadastro',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromRGBO(113, 153, 213, 1),
                  fontFamily: 'Roboto',
                  fontSize: 22,
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              Container(
                width: 327,
                height: 60,
                decoration: const BoxDecoration(
                  color: Colors.white12,
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                child: TextFormField(
                  controller: _usuarioController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: "Usuário",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    labelStyle: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                    ),
                  ),
                  style: const TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 18,
                    color: Colors.black,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Informe seu usuário!';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: 327,
                height: 60,
                decoration: const BoxDecoration(
                  color: Colors.white12,
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                child: TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    labelStyle: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                    ),
                  ),
                  style: const TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 18,
                    color: Colors.black,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Informe seu email!';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: 327,
                height: 60,
                decoration: const BoxDecoration(
                  color: Colors.white12,
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                child: TextFormField(
                  controller: _senhaController,
                  keyboardType: TextInputType.text,
                  obscureText: _showPassword,
                  decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                      child: Icon(
                        _showPassword == true
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: const Color.fromRGBO(113, 153, 213, 1),
                      ),
                      onTap: () {
                        setState(() {
                          _showPassword = !_showPassword;
                        });
                      },
                    ),
                    labelText: "Senha",
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    labelStyle: const TextStyle(
                      color: Colors.black,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                    ),
                  ),
                  style: const TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 14,
                    color: Colors.black,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Informe sua senha!';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: 327,
                height: 60,
                decoration: const BoxDecoration(
                  color: Colors.white12,
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                child: TextFormField(
                  controller: _confirmaSenhaController,
                  keyboardType: TextInputType.text,
                  obscureText: _showPassword,
                  decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                      child: Icon(
                        _showPassword == true
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: const Color.fromRGBO(113, 153, 213, 1),
                      ),
                      onTap: () {
                        setState(() {
                          _showPassword = !_showPassword;
                        });
                      },
                    ),
                    labelText: "Confirmar senha",
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    labelStyle: const TextStyle(
                      color: Colors.black,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                    ),
                  ),
                  style: const TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 14,
                    color: Colors.black,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Confirme sua senha!';
                    } else if (value != _senhaController.text) {
                      return 'Senhas não coincidem!';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: 327,
                height: 60,
                decoration: const BoxDecoration(
                  color: Colors.white12,
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                child: TextFormField(
                  controller: _enderecoController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: "Endereço",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    labelStyle: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                    ),
                  ),
                  style: const TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              LargeButton(
                texto: 'Cadastrar',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    cadastro();
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 40,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/login');
                  },
                  child: const Text(
                    "Já tem uma conta? Login",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Roboto',
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
