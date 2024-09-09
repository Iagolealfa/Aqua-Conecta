import 'package:flutter/material.dart'; // Alterado para Material
import 'views/login_view.dart';
import 'views/cadastro_view.dart';
import 'views/esqueci_senha_view.dart';
import 'views/home_view.dart';
import 'views/onboarding_view.dart';
import 'views/relatorio_view.dart';
import 'views/contato_view.dart';
import 'views/suporte_view.dart';
import 'views/sobre_view.dart';
import 'models/check_model.dart';
import 'views/report_vazamento.dart';
import 'views/report_qualidade.dart';

Map<String, WidgetBuilder> getAppRoutes() {
  return {
    '/login': (context) => const LoginView(),
    '/cadastro': (context) => const CadastroView(),
    '/esqueciSenhaEnviar': (context) => const EsqueciSenhaView(),
    '/home': (context) => const HomeView(),
    '/onboarding': (context) => const OnboardingView(),
    '/relatorio': (context) => const RelatorioView(),
    '/contato': (context) => const ContatoView(),
    '/suporte': (context) => const SuporteView(),
    '/sobre': (context) => const SobreView(),
    '/checar': (context) => const CheckModel(),
    '/vazamento_1': (context) => LocationSelectionPage(),
    '/qualidade': (context) => ReportQualidade(),
  };
}
