import 'package:flutter/material.dart';

class FormTextField extends StatelessWidget {
  final String label;
  final void Function(String)? onChanged;

  const FormTextField({super.key, required this.label, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        TextField(
          onChanged: onChanged,
        ),
      ],
    );
  }
}