import 'package:aqua_conecta/models/check_model.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final _firebaseAuth = FirebaseAuth.instance;
  String nome = '';
  String email = '';

  @override
  initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 260,
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            ListTile(
              dense: true,
              title: const Text("Home"),
              leading: const Icon(Icons.home),
              onTap: () {
                Navigator.of(context).pushNamed('/home');
              },
            ),
            const SizedBox(height: 20),
            ListTile(
              dense: true,
              title: const Text("Relatório"),
              leading: const Icon(Icons.analytics),
              onTap: () {
                Navigator.of(context).pushNamed('/relatorio');
              },
            ),
            const SizedBox(height: 20),
            ListTile(
              dense: true,
              title: const Text("Contato"),
              leading: const Icon(Icons.query_stats),
              onTap: () {
                Navigator.of(context).pushNamed('/contato');
              },
            ),
            const SizedBox(height: 20),
            ListTile(
              dense: true,
              title: const Text("Suporte"),
              leading: const Icon(Icons.description),
              onTap: () {
                Navigator.of(context).pushNamed('/suporte');
              },
            ),
            const SizedBox(height: 20),
            ListTile(
              dense: true,
              title: const Text("Sobre"),
              leading: const Icon(Icons.help),
              onTap: () {
                Navigator.of(context).pushNamed('/sobre');
              },
            ),
            const SizedBox(height: 20),
            ListTile(
              dense: true,
              title: const Text("Sair da conta"),
              leading: const Icon(Icons.exit_to_app),
              onTap: () {
                sair();
              },
            ),
          ],
        ),
      ),
    );
  }

  getUser() async {
    User? usuario = _firebaseAuth.currentUser;
    if (usuario != null) {
      setState(() {
        nome = usuario.displayName!;
        email = usuario.email!;
      });
    }
  }

  sair() async {
    await _firebaseAuth.signOut().then(
          (user) => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const CheckModel(),
        ),
      ),
    );
    Navigator.of(context).pushReplacementNamed('/login');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
            'Deslogado',
            textAlign: TextAlign.center),
        backgroundColor: Colors.grey,
      ),
    );
  }
}