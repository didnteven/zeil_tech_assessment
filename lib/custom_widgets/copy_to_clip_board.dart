import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

///Displays text in bold and copies to clipboard
///
///Takes BuildContext and a String to display and copy
Widget copyToClipBoard(BuildContext context, String text) {
  return GestureDetector(
    child: Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.bold),
    ),
    onTap: () {
      Clipboard.setData(
        ClipboardData(
          text: text,
        ),
      );
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Copied: $text')));
    },
  );
}
