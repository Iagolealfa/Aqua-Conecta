import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:aqua_conecta/views/home_view.dart';
import 'package:aqua_conecta/views/onboarding_view.dart';

class CheckModel extends StatefulWidget {
  const CheckModel({Key? key}) : super(key: key);

  static const routeName = '/checar';

  @override
  State<CheckModel> createState() => _CheckModelState();
}

class _CheckModelState extends State<CheckModel> {
  StreamSubscription<User?>? streamSubscription;

  @override
  void initState() {
    super.initState();
    streamSubscription =
        FirebaseAuth.instance.authStateChanges().listen((User? user) {
          if (user == null) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const OnboardingView()),
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeView(),
              ),
            );
          }
        });
  }

  @override
  void dispose() {
    streamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
