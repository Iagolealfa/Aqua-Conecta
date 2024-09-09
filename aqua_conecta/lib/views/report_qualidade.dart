import 'package:flutter/material.dart';

class ReportQualidade extends StatefulWidget {
  @override
  _ReportQualidade createState() => _ReportQualidade();
}

class _ReportQualidade extends State<ReportQualidade> {
  // Variáveis para manter o estado dos checkboxes
  bool isTurvaSelected = false;
  bool isMauCheiroSelected = false;
  bool isOutrosSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Qualidade da Água'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.location_on, size: 50, color: Colors.blue),
                Icon(Icons.horizontal_rule, size: 50, color: Colors.grey),
              ],
            ),
            Text(
              'Adicione uma foto e selecione o(s) problema(s)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            
            Center(
              child: IconButton(
              icon: Icon(Icons.add_a_photo, size: 70, color: Colors.blue),
              onPressed: () {
                // Lógica para adicionar foto
              },
            ),
            ),
            
            SizedBox(height: 25),
            CheckboxListTile(
              title: Text('Turva'),
              value: isTurvaSelected,
              onChanged: (bool? value) {
                setState(() {
                  isTurvaSelected = value ?? false;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Mau cheiro'),
              value: isMauCheiroSelected,
              onChanged: (bool? value) {
                setState(() {
                  isMauCheiroSelected = value ?? false;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Outros'),
              value: isOutrosSelected,
              onChanged: (bool? value) {
                setState(() {
                  isOutrosSelected = value ?? false;
                });
              },
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Lógica para enviar os dados
                },
                child: Text('Enviar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
