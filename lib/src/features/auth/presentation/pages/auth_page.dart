import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_monitoring_seventh/src/app/routes/routes.dart';
import 'package:video_monitoring_seventh/src/core/dependency_injection/dependency_injection.dart';
import 'package:video_monitoring_seventh/src/core/presentation/widgets/seventh_snack_bars.dart';
import 'package:video_monitoring_seventh/src/features/auth/domain/entities/user.dart';
import 'package:video_monitoring_seventh/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:video_monitoring_seventh/src/features/auth/presentation/widgets/auth_header.dart';
import 'package:video_monitoring_seventh/src/features/auth/presentation/widgets/password_form_field.dart';
import 'package:video_monitoring_seventh/src/features/auth/presentation/widgets/username_form_field.dart';

part '../widgets/auth_continue_button.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  late final AuthBloc bloc;
  final usernameTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  @override
  void didChangeDependencies() {
    bloc = dependencyAssembly<AuthBloc>();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        bloc: bloc,
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.of(context).pushNamed(AppRoutes.kVideoPlayerRoute);
          }

          if (state is AuthError) {
            SeventhSnackBars.showErrorSnackBar(
              context,
              message: state.errorMessage,
            );
          }
        },
        builder: (context, state) {
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 72, 16, 16),
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
                      bloc: bloc,
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
