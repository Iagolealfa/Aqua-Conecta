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
      drawer: const AppDrawer(),
      appBar: AppBar(
        toolbarHeight: 80,
        elevation: 0,
        backgroundColor: const Color(0xFF2a5298),
        centerTitle: true,
        title: SizedBox(
          width: 90,
          height: 90,
        ),
      ),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 60, left: 40, right: 40),
            color: const Color(0xFF2a5298),
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
                  child: const Icon(Icons.water_drop_outlined),
                ),
                const SizedBox(height: 10),
                FloatingActionButton(
                  onPressed: () {
                    //popup
                  },
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
