import 'package:flutter/material.dart';

showSuccessSnackBar(BuildContext context, String text) =>
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        content: Text(text),
      ),
    );
