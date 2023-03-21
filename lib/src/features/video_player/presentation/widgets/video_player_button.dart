import 'package:flutter/material.dart';

class VideoPlayerButton extends StatelessWidget {
  const VideoPlayerButton({
    super.key,
    required this.iconData,
    required this.onPressed,
  });

  final void Function() onPressed;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          iconData,
          color: Theme.of(context).colorScheme.primaryContainer,
        ),
      ),
    );
  }
}
