import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget child;
  final double? dimension;
  const RoundedButton(
      {super.key,
      this.dimension,
      required this.onPressed,
      required this.child});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
            shape: WidgetStatePropertyAll(CircleBorder()),
            elevation: WidgetStatePropertyAll(.7),
            fixedSize: dimension != null
                ? WidgetStatePropertyAll(
                    Size.square(dimension!),
                  )
                : null,
            padding: WidgetStatePropertyAll(EdgeInsets.zero),
            iconSize: dimension != null
                ? WidgetStatePropertyAll(dimension! * .6)
                : null,
          ),
      onPressed: onPressed,
      child: child,
    );
  }
}
