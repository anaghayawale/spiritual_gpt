import 'package:flutter/material.dart';

void showSnackBarWidget(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 3),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      backgroundColor: const Color.fromARGB(255, 195, 194, 194),
      content: Text(text, style: Theme.of(context).textTheme.titleSmall),
    ),
  );
}
