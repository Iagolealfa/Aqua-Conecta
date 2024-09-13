import 'package:flutter/material.dart';
import 'package:aqua_conecta/view_models/login_view_model.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RelatorioView extends StatefulWidget {
  @override
  _RelatorioViewState createState() => _RelatorioViewState();
}

class _RelatorioViewState extends State<RelatorioView> {
  String dropdownValue1 = 'Selecione o tipo de relatório';

  List<Map<String, dynamic>> reports = [];

  Future<void> _createlist() async {
    final loginViewModel = Provider.of<LoginViewModel>(context, listen: false);
    final String? userEmail = loginViewModel.userId;

    setState(() {
      reports = [];
    });

    String collectionPath;
    Map<String, dynamic> reportFields;

    switch (dropdownValue1) {
      case 'Disponibilidade de água':
        collectionPath = 'disponibilidade';
        reportFields = {
          'endereco': 'endereco',
          'data': 'data',
          'resposta': 'resposta'
        };
        break;
      case 'Vazamento':
        collectionPath = 'vazamento';
        reportFields = {'endereco': 'endereco', 'data': 'data'};
        break;
      case 'Qualidade da água':
        collectionPath = 'qualidade';
        reportFields = {
          'endereco': 'endereco',
          'data': 'data',
          'Turva': false,
          'MauCheiro': false,
          'Outros': false
        };
        break;
      default:
        return;
    }

    final collectionRef = FirebaseFirestore.instance.collection(collectionPath);
    final querySnapshot =
        await collectionRef.where('usuario', isEqualTo: userEmail).get();

    try {
      final List<Map<String, dynamic>> fetchedReports =
          querySnapshot.docs.map((doc) {
        final data = Map<String, dynamic>.from(
            doc.data() as Map); // Casting para Map<String, dynamic>
        final report = <String, dynamic>{};
        for (var key in reportFields.keys) {
          if (data.containsKey(key)) {
            report[key] = data[key];
          }
        }
        return report;
      }).toList();

      setState(() {
        reports = fetchedReports;
      });
    } catch (e) {
      // Handle any errors that might occur
      print('Error fetching reports: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Relatórios'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DropdownButton<String>(
                value: dropdownValue1,
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue1 = newValue!;
                    _createlist(); // Atualiza a lista quando o valor do dropdown mudar
                  });
                },
                items: <String>[
                  'Selecione o tipo de relatório',
                  'Disponibilidade de água',
                  'Vazamento',
                  'Qualidade da água'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: reports.length,
                itemBuilder: (context, index) {
                  var report = reports[index];

                  if (dropdownValue1 == 'Disponibilidade de água') {
                    return ListTile(
                      title: Text(report['endereco']),
                      subtitle: Text(
                          'Data: ${report['data']}  Status: ${report['resposta'] ? 'Disponível' : 'Indisponível'}'),
                      leading: Image.asset(
                        report['resposta']
                            ? 'assets/images/pin_agua.png'
                            : 'assets/images/pin_falta_agua.png',
                        width: 40,
                        height: 40,
                      ),
                    );
                  } else if (dropdownValue1 == 'Vazamento') {
                    return ListTile(
                      title: Text(report['endereco']),
                      subtitle: Text('Data: ${report['data']}'),
                      leading: Image.asset('assets/images/pin_vazamento.png',
                          width: 40, height: 40),
                    );
                  } else if (dropdownValue1 == 'Qualidade da água') {
                    String aspecto = 'Aspecto da água: ';
                    if (report['Outros'] == true) {
                      aspecto += 'Outros';
                    } else {
                      List<String> aspectos = [];
                      if (report['Turva'] == true) aspectos.add('Turva');
                      if (report['MauCheiro'] == true)
                        aspectos.add('Mau cheiro');

                      aspecto += aspectos.join(' e ');
                    }

                    return ListTile(
                      title: Text(report['endereco']),
                      subtitle: Text(
                        'Data: ${report['data']} $aspecto',
                      ),
                      leading: Image.asset(
                        'assets/images/pin_agua.png',
                        width: 40,
                        height: 40,
                      ),
                    );
                  }
                  return Container(); // Para garantir que sempre retorne um widget
                },
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Implementar função para baixar PDF
                  },
                  child: Text('Baixar PDF'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
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
