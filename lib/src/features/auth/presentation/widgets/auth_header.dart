import 'package:flutter/material.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width / 2,
          child: Image.asset(
            'assets/seventh_logo_white.png',
            fit: BoxFit.fitWidth,
          ),
        ),
        const SizedBox(height: 16),
        RichText(
          text: TextSpan(
            children: [
              const TextSpan(text: 'Faça o '),
              TextSpan(
                text: 'login\n',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              const TextSpan(text: 'para continuar')
            ],
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
      ],
    );
  }
}
