import 'package:flutter/material.dart';

class DeleteIconButton extends StatelessWidget {
  final void Function() onLongPress;
  const DeleteIconButton({
    super.key,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onLongPress,
      child: Container(
        width: 60.0,
        height: 60.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color:
              Colors.red.withOpacity(0.7),
        ),
        child: Icon(
          Icons.close,
          color: Colors.white.withOpacity(0.7),
          size: 50,
        ),
      ),
    );
  }
}
