import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_monitoring_seventh/src/features/auth/domain/entities/user.dart';
import 'package:video_monitoring_seventh/src/features/auth/presentation/bloc/auth_bloc.dart';

class AuthContinueButton extends StatelessWidget {
  const AuthContinueButton({
    required this.usernameFieldController,
    required this.passwordFieldController,
    super.key,
  });

  final TextEditingController usernameFieldController;
  final TextEditingController passwordFieldController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final user = state.user;

        return SizedBox(
          height: 64,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            ),
            onPressed: () {
              context.read<AuthBloc>().add(
                    LoginEvent(
                      User(
                        id: user.id,
                        username: usernameFieldController.text,
                        password: passwordFieldController.text,
                      ),
                    ),
                  );
            },
            child: AnimatedCrossFade(
              firstChild: Flex(
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
              secondChild: const Center(
                child: CircularProgressIndicator(),
              ),
              crossFadeState: state is AuthLoading
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 500),
            ),
          ),
        );
      },
    );
  }
}
