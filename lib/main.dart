import 'package:country_app/constants/colors.dart';
import 'package:country_app/constants/theme_color.dart';
import 'package:country_app/helpers/loading/loading_screen.dart';
import 'package:country_app/services/auth/bloc/auth_bloc.dart';
import 'package:country_app/services/auth/bloc/auth_event.dart';
import 'package:country_app/services/auth/firebase_auth_provider.dart';
import 'package:country_app/views/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'services/auth/bloc/auth_state.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Country App',
      theme: ThemeData(
        primarySwatch: TemaColor.miTema,
        scaffoldBackgroundColor: backgroundAppColor,
      ),
      home: BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(FirebaseAuthProvider()),
        child: const HomePage(),
      ),
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitialize());
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.isLoading) {
          LoadingScreen().show(
            context: context,
            text: state.loadingText,
          );
        } else if (!state.isLoading) {
          LoadingScreen().hide();
        }
      },
      builder: (context, state) {
        if (state is AuthStateLoggedOut) {
          return const LoginView();
        } else {
          return const Scaffold(
            body: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
