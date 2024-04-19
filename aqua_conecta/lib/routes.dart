import 'package:flutter/cupertino.dart';
import 'views/login_view.dart';
import 'views/cadastro_view.dart';
import 'views/esqueci_senha_view.dart';


Map<String, WidgetBuilder> getAppRoutes() {
  return {
    '/login': (context) => const LoginView(),
    '/cadastro': (context) => const CadastroView(),
    '/esqueciSenhaEnviar': (context) => const EsqueciSenhaView(),
  };
}