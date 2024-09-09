import 'package:flutter/material.dart';

class ReportPopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.of(context).pop();
      },
      child: DraggableScrollableSheet(
        initialChildSize: 0.2,
        maxChildSize: 0.2,
        minChildSize: 0.2,
        builder: (context, scrollController) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            child: SingleChildScrollView(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: SizedBox(
                            width: 75, // Largura do ícone
                            height: 75, // Altura do ícone
                            child:
                                Image.asset('assets/images/pin_vazamento.png'),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/vazamento_1');
                          },
                        ),
                        Text(
                          'Reportar Vazamento',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: SizedBox(
                            width: 75, // Largura do ícone
                            height: 75, // Altura do ícone
                            child:
                                Image.asset('assets/images/pin_qualidade.png'),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/qualidade');
                          },
                        ),
                        Text(
                          'Reportar Qualidade',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
