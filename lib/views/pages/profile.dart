import 'package:country_app/constants/colors.dart';
import 'package:country_app/services/auth/auth_service.dart';
import 'package:country_app/services/auth/bloc/auth_bloc.dart';
import 'package:country_app/services/auth/bloc/auth_event.dart';
import 'package:country_app/services/auth/bloc/auth_state.dart';
import 'package:country_app/utilities/dialogs/logout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final user = AuthService.firebase().currentUser;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      child: Center(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 75),
              child: Text(user!.email),
            ),
            Container(
              margin: const EdgeInsets.only(top: 35),
              child: SizedBox(
                width: 150,
                child: TextButton.icon(
                  icon: const Icon(Icons.logout),
                  onPressed: () async {
                    if (await showLogOutDialog(context)) {
                      context.read<AuthBloc>().add(const AuthEventLogOut());
                    }
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
                  label: const Text(
                    'Log out',
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
