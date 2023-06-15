import 'package:app/pmp/theme.dart';
import 'package:app/pmp/widgets/buttoned_text_form_field.dart';
import 'package:app/pmp/widgets/padding.dart';
import 'package:flutter/material.dart';

class ConfirmStringScaffold extends StatefulWidget {
  final Widget title;
  final Widget message;
  final String? labelText;
  final bool obscureText;
  final Widget confirmIcon;
  final void Function(BuildContext context)? onBackPressed;
  final void Function(BuildContext context, String value)? onConfirmPressed;

  const ConfirmStringScaffold({
    Key? key,
    this.title = const Text('Confirm string',
        style: TextStyle(color: Color.fromARGB(255, 16, 13, 13))),
    this.message = const Text('Enter string to confirm',
        style: TextStyle(color: Color.fromARGB(255, 16, 13, 13))),
    this.labelText,
    this.obscureText = false,
    this.confirmIcon = const Icon(Icons.arrow_forward_ios_rounded),
    this.onBackPressed,
    this.onConfirmPressed,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ConfirmStringScaffold();
}

class _ConfirmStringScaffold extends State<ConfirmStringScaffold> {
  String _input = '';
  void Function()? _onBackPressed;
  void Function()? _onConfirmPressed;
  bool _initialized = false;

  @override
  Widget build(BuildContext context) {
    if (!_initialized) {
      _onBackPressed = widget.onBackPressed == null
          ? null
          : () => widget.onBackPressed!(context);
      _onConfirmPressed = widget.onConfirmPressed == null
          ? null
          : () => widget.onConfirmPressed!(context, _input);
      _initialized = true;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: PmpTheme.appbarcolor,
        leading: IconButton(
          padding: PmpTheme.appBarButtonPadding,
          splashRadius: PmpTheme.appBarButtonSplashRadius,
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
          onPressed: _onBackPressed,
        ),
        title: widget.title,
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
              ),
              widget.message,
              const SizedBox(
                height: 50,
              ),
              PmpPadding(
                ButtonedTextFormField(
                  labelText: widget.labelText,
                  obscureText: widget.obscureText,
                  onChanged: (s) => setState(() => _input = s),
                  onPressed: _onConfirmPressed,
                  buttonIcon: widget.confirmIcon,
                ),
              ),
              const Spacer(),
            ]),
          ),
        ],
      ),
    );
  }
}
