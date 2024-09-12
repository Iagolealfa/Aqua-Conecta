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
  /*Future<void> _createlist() async {
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
        reportFields = {'rua': 'rua', 'data': 'data', 'status': 'resposta'};
        break;
      case 'Vazamento':
        collectionPath = 'vazamento';
        reportFields = {'rua': 'rua', 'data': 'data'};
        break;
      case 'Qualidade da água':
        collectionPath = 'qualidade';
        reportFields = {'rua': 'rua', 'data': 'data', 'aspecto': 'aspecto'};
        break;
      default:
        // Handle the case where dropdownValue1 doesn't match any expected values
        return;
    }

    try {
      final collectionRef =
          FirebaseFirestore.instance.collection(collectionPath);
      final querySnapshot =
          await collectionRef.where('userEmail', isEqualTo: userEmail).get();

      final List<Map<String, dynamic>> fetchedReports =
          querySnapshot.docs.map((doc) {
        final data = doc.data();
        final report = {};
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
  }*/

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

                  // Aqui a condição para modificar a estrutura
                  if (dropdownValue1 == 'Disponibilidade de água') {
                    return ListTile(
                      title: Text(report['rua']),
                      subtitle: Text(
                          'Data: ${report['data']}  Status: ${report['status']}'),
                    );
                  } else if (dropdownValue1 == 'Vazamento') {
                    return ListTile(
                      title: Text(report['rua']),
                      subtitle: Text('Data: ${report['data']}'),
                      leading: Icon(Icons.warning, color: Colors.red),
                    );
                  } else if (dropdownValue1 == 'Qualidade da água') {
                    return ListTile(
                      title: Text(report['rua']),
                      subtitle: Text(
                          'Data: ${report['data']} Aspecto da água: ${report['aspecto']}'),
                      leading: Icon(Icons.water, color: Colors.blue),
                    );
                  }
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
