import 'package:country_app/utilities/dialogs/generic.dart';
import 'package:flutter/material.dart';

Future<bool> showLogOutDialog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    tittle: 'Log out',
    content: 'Are you sure you want to Log out?',
    optionsBuilder: () => {
      'Log out': true,
      'Cancel': false,
    },
  ).then((value) => value ?? false);
}
