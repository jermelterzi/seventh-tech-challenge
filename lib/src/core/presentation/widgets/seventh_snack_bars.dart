import 'package:flutter/material.dart';

class SeventhSnackBars {
  static void showErrorSnackBar(
    BuildContext context, {
    required String message,
  }) {
    final errorSnackBar = SnackBar(
      backgroundColor: Theme.of(context).colorScheme.errorContainer,
      behavior: SnackBarBehavior.floating,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      content: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.block,
            color: Theme.of(context).colorScheme.onErrorContainer,
          ),
          const SizedBox(width: 8),
          Text(
            message,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onErrorContainer,
            ),
          )
        ],
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
  }
}
