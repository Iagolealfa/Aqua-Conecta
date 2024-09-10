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
      backgroundColor: const Color(0xFF3555C5),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const SizedBox(height: 55),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed('/perfil');
              },
              child: const Center(
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Color(0xFF729AD6),
                  child: Icon(
                    Icons.person,
                    size: 50,
                    color: Color(0xFF3555C5),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed('/perfil');
              },
              child: const Center(
                child: Text(
                  "Ver/editar perfil",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 55),
            ListTile(
              dense: true,
              title: const Text(
                "Home",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              leading: const Icon(
                Icons.home,
                color: Colors.white,
              ),
              onTap: () {
                Navigator.of(context).pushNamed('/home');
              },
            ),
            const SizedBox(height: 20),
            ListTile(
              dense: true,
              title: const Text(
                "Relatório",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              leading: const Icon(
                Icons.analytics,
                color: Colors.white,
              ),
              onTap: () {
                Navigator.of(context).pushNamed('/relatorio');
              },
            ),
            const SizedBox(height: 20),
            ListTile(
              dense: true,
              title: const Text(
                "Contato",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              leading: const Icon(
                Icons.query_stats,
                color: Colors.white,
              ),
              onTap: () {
                Navigator.of(context).pushNamed('/contato');
              },
            ),
            const SizedBox(height: 20),
            ListTile(
              dense: true,
              title: const Text(
                "Suporte",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              leading: const Icon(
                Icons.description,
                color: Colors.white,
              ),
              onTap: () {
                Navigator.of(context).pushNamed('/suporte');
              },
            ),
            const SizedBox(height: 20),
            ListTile(
              dense: true,
              title: const Text(
                "Sobre",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              leading: const Icon(
                Icons.help,
                color: Colors.white,
              ),
              onTap: () {
                Navigator.of(context).pushNamed('/sobre');
              },
            ),
            const SizedBox(height: 20),
            ListTile(
              dense: true,
              title: const Text(
                "Sair da conta",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              leading: const Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ),
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