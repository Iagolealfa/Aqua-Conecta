import 'package:flutter/material.dart';

class LargeButton extends StatelessWidget {

  const LargeButton({super.key, required this.texto, required this.onPressed});

  final String texto;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(36, 68, 179, 1),
        borderRadius: BorderRadius.all(
          Radius.circular(30),
        ),
      ),
      child: SizedBox(
        child: TextButton(
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                texto,
                style: const TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  fontSize: 16,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}