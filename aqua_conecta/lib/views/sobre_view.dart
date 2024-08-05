import 'package:flutter/material.dart';
import '../components/drawer.dart';

class SobreView extends StatefulWidget {
  const SobreView({Key? key}) : super(key: key);

  static const routeName = '/sobre';

  @override
  State<SobreView> createState() => _SobreViewState();
}

class _SobreViewState extends State<SobreView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(), // Adiciona o Drawer
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 60, left: 40, right: 40),
            color: Colors.white,
            child: ListView(
              children: const <Widget>[
                SizedBox(height: 20),
              ],
            ),
          ),
          Positioned(
            top: 20,
            left: 10,
            child: Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.menu, color: Colors.black),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
