import 'package:flutter/material.dart';

///Shows Alert dialog for errors
///takes BuildContext, title and message
Future<void> showErrorAlertDialog(
    BuildContext context, String title, String message) async {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Okay')),
          ],
        );
      });
}
