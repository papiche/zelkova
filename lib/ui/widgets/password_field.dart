import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key,
    required this.controller,
    required this.label,
    required this.onChanged,
    this.validator,
    this.errorText,
  });

  final TextEditingController controller;
  final String label;
  final void Function(String value) onChanged;
  final RegExp? validator;
  final String? errorText;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;
  bool _hasError = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: _obscureText,
      onChanged: (String value) {
        widget.onChanged(value);
        if (widget.validator != null) {
          setState(() => _hasError = !widget.validator!.hasMatch(value));
        }
      },
      decoration: InputDecoration(
        labelText: widget.label,
        errorText: _hasError ? widget.errorText ?? 'Invalid password' : null,
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () => setState(() => _obscureText = !_obscureText),
        ),
      ),
    );
  }
}
