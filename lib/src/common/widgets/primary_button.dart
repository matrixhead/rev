import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final void Function()? onPressed;
  final String label;
  const PrimaryButton({
    super.key,
    required this.onPressed,
    required this.label
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: AspectRatio(
        aspectRatio: 5,
        child: Center(child: Text(label)),
      ),
    );
  }
}