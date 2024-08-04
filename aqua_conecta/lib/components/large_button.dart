import 'package:flutter/material.dart';

class LargeButton extends StatelessWidget {

  const LargeButton({super.key, this.texto, required this.onPressed, this.icon});

  final String? texto;
  final Function()? onPressed;
  final IconData? icon;

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
              if (icon != null) ...[
                Icon(
                  icon,
                  color: Colors.white,
                ),
                if (texto != null) const SizedBox(width: 8),
              ],
              if (texto != null)
                Text(
                  texto!,
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
