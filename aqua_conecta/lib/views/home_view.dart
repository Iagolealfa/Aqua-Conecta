import 'package:flutter/material.dart';
import '../components/drawer.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  static const routeName = '/home';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
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
            bottom: 20,
            right: 20,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    // popup
                  },
                  backgroundColor: const Color(0xFF2544B4),
                  child: const Icon(
                    Icons.water_drop_outlined,
                    color: Colors.white, // Cor do ícone
                  ),
                ),
                const SizedBox(height: 10),
                FloatingActionButton(
                  onPressed: () {
                    // popup
                  },
                  backgroundColor: const Color(0xFF2544B4),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white, // Cor do ícone
                  ),
                ),
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
