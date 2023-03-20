import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_monitoring_seventh/src/app/routes/routes.dart';
import 'package:video_monitoring_seventh/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:video_monitoring_seventh/src/features/auth/presentation/widgets/auth_continue_button.dart';
import 'package:video_monitoring_seventh/src/features/auth/presentation/widgets/auth_header.dart';
import 'package:video_monitoring_seventh/src/features/auth/presentation/widgets/password_form_field.dart';
import 'package:video_monitoring_seventh/src/features/auth/presentation/widgets/username_form_field.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final usernameTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.of(context).pushNamed(AppRoutes.kVideoPlayerRoute);
          }

          if (state is AuthError) {
            final errorSnackBar = SnackBar(
              backgroundColor: Theme.of(context).colorScheme.errorContainer,
              behavior: SnackBarBehavior.floating,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              content: Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.block,
                    color: Theme.of(context).colorScheme.onErrorContainer,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    state.errorMessage,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onErrorContainer,
                    ),
                  )
                ],
              ),
            );

            ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
          }
        },
        builder: (context, state) {
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  16,
                  72,
                  16,
                  16,
                ),
                child: Flex(
                  direction: Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AuthHeader(),
                    const SizedBox(height: 32),
                    UsernameFormField(
                      controller: usernameTextController,
                    ),
                    const SizedBox(height: 8),
                    PasswordFormField(
                      controller: passwordTextController,
                    ),
                    const SizedBox(height: 64),
                    AuthContinueButton(
                      usernameFieldController: usernameTextController,
                      passwordFieldController: passwordTextController,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
