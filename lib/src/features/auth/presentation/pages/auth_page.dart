import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_monitoring_seventh/src/app/routes/routes.dart';
import 'package:video_monitoring_seventh/src/core/dependency_injection/dependency_injection.dart'
    as di;
import 'package:video_monitoring_seventh/src/features/auth/domain/entities/user.dart';
import 'package:video_monitoring_seventh/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:video_monitoring_seventh/src/features/auth/presentation/widgets/password_form_field.dart';
import 'package:video_monitoring_seventh/src/features/auth/presentation/widgets/username_form_field.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.of(context).pushNamed(AppRoutes.kVideoPlayerRoute);
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Flex(
              direction: Axis.vertical,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(flex: 12),
                Flexible(
                  flex: 12,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Image.asset(
                      'assets/seventh_logo_white.png',
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                const Spacer(flex: 2),
                Flexible(
                  flex: 30,
                  child: RichText(
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
                ),
                const Spacer(flex: 4),
                const Flexible(flex: 20, child: UsernameFormField()),
                const Flexible(flex: 20, child: PasswordFormField()),
                Flexible(
                  flex: 30,
                  child: SizedBox(
                    height: 64,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.primaryContainer,
                      ),
                      onPressed: () {
                        context.read<AuthBloc>().add(
                              LoginEvent(
                                User(
                                  id: '',
                                  username: 'candidato-seventh',
                                  password: '8n5zSrYq',
                                ),
                              ),
                            );
                      },
                      child: Flex(
                        direction: Axis.horizontal,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Continuar',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(width: 8),
                          const Icon(
                            Icons.arrow_right_alt,
                            size: 32,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
