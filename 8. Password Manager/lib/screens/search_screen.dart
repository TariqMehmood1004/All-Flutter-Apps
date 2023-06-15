import 'package:app/pmp/theme.dart';
import 'package:app/pmp/widgets/padding.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  static const routeName = '/search';

  @override
  State<StatefulWidget> createState() => _SearchScreen();
}

class _SearchScreen extends State<SearchScreen> {
  bool _initialized = false;
  Widget _widget = const Text('');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget Function(String terms) builder =
        ModalRoute.of(context)!.settings.arguments as Widget Function(String);
    if (!_initialized) {
      _widget = builder('');
      _initialized = true;
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PmpTheme.appbarcolor,
        leading: IconButton(
          padding: PmpTheme.appBarButtonPadding,
          splashRadius: PmpTheme.appBarButtonSplashRadius,
          icon:
              const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Search',
            style: TextStyle(
              color: Color.fromARGB(255, 250, 250, 250),
            )),
        centerTitle: true,
      ),
      body: Column(
        children: [
          PmpPadding(TextFormField(
              style: const TextStyle(color: Color.fromARGB(255, 16, 13, 13)),
              decoration: const InputDecoration(
                label: Text('Search'),
                hintText: 'kingit',
              ),
              onChanged: (s) {
                setState(() {
                  _widget = builder(s);
                });
              })),
          Expanded(
            child: _widget,
          ),
        ],
      ),
    );
  }
}
