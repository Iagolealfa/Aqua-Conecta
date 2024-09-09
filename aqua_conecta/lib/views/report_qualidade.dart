import 'package:flutter/material.dart';

class ReportQualidade extends StatelessWidget {
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
            Text(
              'Adicione uma foto e elecione o(s) problema(s)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            IconButton(
              icon: Icon(Icons.add_a_photo, size: 50, color: Colors.blue),
              onPressed: () {
                // Lógica para adicionar foto
              },
            ),
            SizedBox(height: 20),
            CheckboxListTile(
              title: Text('Turva'),
              value: false,
              onChanged: (bool? value) {},
            ),
            CheckboxListTile(
              title: Text('Mau cheiro'),
              value: false,
              onChanged: (bool? value) {},
            ),
            CheckboxListTile(
              title: Text('Outros'),
              value: false,
              onChanged: (bool? value) {},
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
