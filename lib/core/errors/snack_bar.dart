import 'package:flutter/material.dart';

class SnackBarMessage {

  void showErrorSnackBar(BuildContext context, String message) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(message, style: const TextStyle(color: Colors.white))));
}
