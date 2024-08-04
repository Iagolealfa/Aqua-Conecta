import 'package:flutter/material.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  _OnboardingViewState createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: const Color(0xFF729AD6),
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildIndicator(0),
                const SizedBox(width: 10),
                _buildIndicator(1),
                const SizedBox(width: 10),
                _buildIndicator(2),
              ],
            ),
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: [
                _buildPage(
                  title: 'Bem-vindo ao AquaConecta',
                  description:
                      'Nosso aplicativo tem como propósito proporcionar comodidade em relação ao fornecimento de água, visando facilitar sua vida.',
                  buttonText: 'PRÓXIMO',
                  onButtonPressed: () {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    );
                  },
                ),
                _buildPage(
                  title: 'Com a Colaboração de todos!',
                  description:
                      'Nosso objetivo é disponibilizar informações atualizadas sobre o abastecimento de água em toda a região, além de oferecer outras funcionalidades e dados adicionais.',
                  buttonText: 'PRÓXIMO',
                  onButtonPressed: () {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    );
                  },
                ),
                _buildPage(
                  title: 'O que você vai encontrar por aqui...',
                  description:
                      'Verificar o status do abastecimento, acessar relatórios sobre o fornecimento em sua região, denunciar vazamentos, avaliar a qualidade da água e outras opções relacionadas...',
                  buttonText: 'VAMOS NESSA!',
                  onButtonPressed: () {
                    Navigator.of(context).pushNamed('/login');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIndicator(int pageIndex) {
    return Container(
      width: 60,
      height: 5,
      color: _currentPage == pageIndex ? Colors.black : Colors.black26,
    );
  }

  Widget _buildPage({
    required String title,
    required String description,
    required String buttonText,
    required VoidCallback onButtonPressed,
  }) {
    return Container(
      color: const Color(0xFF729AD6),
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 50,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 60), // Ajuste aqui para 70 pixels
          Text(
            description,
            style: const TextStyle(
              fontSize: 24,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 40.0), // Espaço de 100 pixels abaixo do botão
            child: SizedBox(
              width: 164,
              height: 54,
              child: ElevatedButton(
                onPressed: onButtonPressed,
                style: ElevatedButton.styleFrom(
                  foregroundColor: const Color(0xFFFFFFFF),
                  backgroundColor: const Color(0xFF2544B4), // Cor de fundo do botão
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: Text(buttonText),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
