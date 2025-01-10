import 'package:flutter/material.dart';

class FormTextField extends StatefulWidget {
  final String label;
  final void Function(String)? onChanged;
  final Iterable<String>? autofillHints;
  final TextInputType? keyboardType;
  final bool showObscureTextIcon;
  final String? hintText;

  const FormTextField({
    super.key,
    required this.label,
    this.onChanged,
    this.autofillHints,
    this.keyboardType,
    this.showObscureTextIcon = false,
    this.hintText
  });

  @override
  State<FormTextField> createState() => _FormTextFieldState();
}

class _FormTextFieldState extends State<FormTextField> {
  late bool _obscureText;
  final _focus = FocusNode();

  @override
  void initState() {
    _obscureText = widget.showObscureTextIcon;
    super.initState();
    _focus.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    super.dispose();
    _focus.removeListener(_onFocusChange);
    _focus.dispose();
  }

  void _onFocusChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        SizedBox(
          height: 4,
        ),
        TextField(
          
          focusNode: _focus,
          decoration: 
          InputDecoration(
            hintText: widget.hintText,
            suffixIcon: (widget.showObscureTextIcon && _focus.hasFocus)
                ? InkWell(
                    child: SizedBox.shrink(
                      child: Center(
                        child: AnimatedCrossFade(
                            alignment: Alignment.center,
                            firstChild: Icon(
                              size: 20,
                              Icons.visibility_off,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                            secondChild: Icon(
                              size: 20,
                              Icons.visibility,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                            crossFadeState: _obscureText
                                ? CrossFadeState.showFirst
                                : CrossFadeState.showSecond,
                            duration: Duration(milliseconds: 250)),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  )
                : null,
          ),
          obscureText:
              widget.showObscureTextIcon && (!_focus.hasFocus || _obscureText),
          keyboardType: widget.keyboardType,
          autofillHints: widget.autofillHints,
          onChanged: widget.onChanged,
        ),
      ],
    );
  }
}
