import 'package:country_app/constants/colors.dart';
import 'package:country_app/services/auth/bloc/auth_bloc.dart';
import 'package:country_app/services/auth/bloc/auth_event.dart';
import 'package:country_app/services/auth/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController emailController;
  late final TextEditingController passController;
  late final TextEditingController repeatController;

  @override
  void initState() {
    emailController = TextEditingController();
    passController = TextEditingController();
    repeatController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    repeatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateLoggedOut) {
          // if (state.exception is UserNotFoundAuthException) {
          //   await showErrorDialog(context, 'User not found');
          // } else if (state.exception is WrongPasswordAuthException) {
          //   await showErrorDialog(context, 'Wrong credentials');
          // } else if (state.exception is GenericAuthException) {
          //   await showErrorDialog(context, 'Authentication error');
          // }
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            children: [
              // TITULO
              Container(
                margin: const EdgeInsets.only(top: 75),
                child: const Text(
                  'Sign-in',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 35,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              // TEXTFIELD EMAIL
              Container(
                margin: const EdgeInsets.only(top: 35),
                child: SizedBox(
                  width: 300,
                  height: 50,
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(
                        fontSize: 15,
                        color: Color(0xFF000000),
                      ),
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              // TEXTFIELD PASSWORD
              Container(
                margin: const EdgeInsets.only(top: 35),
                child: SizedBox(
                  width: 300,
                  height: 50,
                  child: TextField(
                    controller: passController,
                    enableSuggestions: false,
                    autocorrect: false,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(
                        fontSize: 15,
                        color: Color(0xFF000000),
                      ),
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              // TEXTFIELD REPEAT PASSWORD
              Container(
                margin: const EdgeInsets.only(top: 35),
                child: SizedBox(
                  width: 300,
                  height: 50,
                  child: TextField(
                    controller: repeatController,
                    enableSuggestions: false,
                    autocorrect: false,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Repeat password',
                      labelStyle: TextStyle(
                        fontSize: 15,
                        color: Color(0xFF000000),
                      ),
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              // BUTTON SIGN IN
              Container(
                margin: const EdgeInsets.only(top: 35),
                child: SizedBox(
                  width: 150,
                  child: TextButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(
                            AuthEventRegister(
                              emailController.text,
                              passController.text,
                              repeatController.text,
                            ),
                          );
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(secondaryAppColor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                      ),
                    ),
                    child: const Text(
                      'Sign in',
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                ),
              ),
              // BUTTON LOG IN
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: SizedBox(
                  width: 150,
                  child: TextButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(const AuthEventLogOut());
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(secondaryAppColor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                      ),
                    ),
                    child: const Text(
                      'Log in',
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                ),
              ),
              // IMAGEN TIERRA
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Image.asset(
                  'assets/images/earth.png',
                  cacheHeight: 130,
                  cacheWidth: 130,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
