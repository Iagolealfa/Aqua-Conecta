import 'package:flutter/material.dart';

class RelatorioView extends StatefulWidget {
  @override
  _RelatorioViewState createState() => _RelatorioViewState();
}

class _RelatorioViewState extends State<RelatorioView> {
  String dropdownValue =
      'Selecione o tipo de relatório'; // Valor inicial do dropdown

  List<Map<String, dynamic>> reports = [
    {
      'rua': 'R. Miguel Couto',
      'area': '05',
      'data': '30/01',
      'status': 'Disponível'
    },
    {
      'rua': 'R. Miguel Couto',
      'area': '05',
      'data': '31/01',
      'status': 'Disponível'
    },
    {
      'rua': 'R. Miguel Couto',
      'area': '05',
      'data': '01/02',
      'status': 'Indisponível'
    },
    {
      'rua': 'R. Miguel Couto',
      'area': '05',
      'data': '02/02',
      'status': 'Disponível'
    },
    {
      'rua': 'R. Miguel Couto',
      'area': '05',
      'data': '03/02',
      'status': 'Disponível'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Relatórios'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        // Corrige o problema de overflow vertical
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DropdownButton<String>(
                value: dropdownValue,
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
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
                shrinkWrap: true, // Corrige problemas de tamanho no ListView
                physics:
                    NeverScrollableScrollPhysics(), // Desativa o scroll interno do ListView
                itemCount: reports.length,
                itemBuilder: (context, index) {
                  var report = reports[index];
                  return ListTile(
                    title: Text(report['rua']),
                    subtitle: Text(
                        'Área: ${report['area']}  Data: ${report['data']}  Status: ${report['status']}'),
                  );
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
