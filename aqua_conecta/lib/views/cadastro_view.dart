import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aqua_conecta/view_models/cadastro_view_model.dart';
import 'package:aqua_conecta/components/large_button.dart';

class CadastroView extends StatelessWidget {
  const CadastroView({Key? key}) : super(key: key);

  static const routeName = '/cadastro';

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CadastroViewModel>(context);

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(
          top: 20,
          left: 40,
          right: 40,
        ),
        color: const Color.fromRGBO(255, 255, 255, 1),
        child: Form(
          key: GlobalKey<FormState>(),
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
              const SizedBox(height: 60),
              _buildTextField(
                controller: viewModel.nomeController,
                labelText: "Usuário",
                validator: (value) => value == null || value.isEmpty
                    ? 'Informe seu usuário!'
                    : null,
              ),
              const SizedBox(height: 10),
              _buildTextField(
                controller: viewModel.emailController,
                labelText: "Email",
                validator: (value) => value == null || value.isEmpty
                    ? 'Informe seu email!'
                    : null,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 10),
              _buildTextField(
                controller: viewModel.passwordController,
                labelText: "Senha",
                obscureText: viewModel.showPassword,
                validator: (value) => value == null || value.isEmpty
                    ? 'Informe sua senha!'
                    : null,
                suffixIcon: GestureDetector(
                  onTap: () => viewModel.togglePasswordVisibility(),
                  child: Icon(
                    viewModel.showPassword
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: const Color.fromRGBO(113, 153, 213, 1),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              _buildTextField(
                controller: viewModel.confirmPasswordController,
                labelText: "Confirmar senha",
                obscureText: viewModel.showConfirmPassword,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Confirme sua senha!';
                  } else if (value != viewModel.passwordController.text) {
                    return 'Senhas não coincidem!';
                  }
                  return null;
                },
                suffixIcon: GestureDetector(
                  onTap: () => viewModel.toggleConfirmPasswordVisibility(),
                  child: Icon(
                    viewModel.showConfirmPassword
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: const Color.fromRGBO(113, 153, 213, 1),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              _buildTextField(
                controller: viewModel.adressController,
                labelText: "Endereço",
                validator: (value) =>
                    null, // Se não precisar de validação, passe null
              ),
              const SizedBox(height: 40),
              LargeButton(
                texto: 'Cadastrar',
                onPressed: () => viewModel.cadastrar(context),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 40,
                child: TextButton(
                  onPressed: () => Navigator.of(context).pushNamed('/login'),
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    bool obscureText = false,
    required String? Function(String?) validator,
    TextInputType keyboardType = TextInputType.text,
    Widget? suffixIcon,
  }) {
    return Container(
      width: 327,
      height: 60,
      decoration: const BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          labelText: labelText,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
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
          fontSize: 18,
          color: Colors.black,
        ),
        validator: validator,
      ),
    );
  }
}
