import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ButtonedTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? initialValue;
  final String? labelText;
  final bool obscureText;
  final Widget? buttonIcon;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final void Function()? onPressed;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;

  const ButtonedTextFormField({
    Key? key,
    this.controller,
    this.initialValue,
    this.labelText,
    this.obscureText = false,
    this.buttonIcon,
    this.onTap,
    this.onChanged,
    this.onPressed,
    this.focusNode,
    this.inputFormatters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      key: key,
      children: [
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: TextFormField(
            style: const TextStyle(color: Color.fromARGB(255, 16, 13, 13)),
            controller: controller,
            initialValue: initialValue,
            obscureText: obscureText,
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(
                    left: 15, top: 8, right: 15, bottom: 0),
                labelText: labelText,
                labelStyle:
                    const TextStyle(color: Color.fromARGB(255, 15, 15, 15))),
            onTap: onTap,
            onChanged: onChanged,
            focusNode: focusNode,
            inputFormatters: inputFormatters,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        FloatingActionButton(
          heroTag: null,
          onPressed: onPressed,
          child: buttonIcon,
        ),
      ],
    );
  }
}
