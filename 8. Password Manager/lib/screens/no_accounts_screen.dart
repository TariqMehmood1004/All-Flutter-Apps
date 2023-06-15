import 'package:flutter/material.dart';

import '../pmp/widgets/padding.dart';

class NoAccountsScreen extends StatelessWidget {
  static const String routeName = '/noAccounts';

  const NoAccountsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                const Spacer(),
                const PmpPadding(Text('No accounts')),
                PmpPadding(FloatingActionButton(
                  child: const Icon(Icons.close_rounded),
                  onPressed: () => Navigator.pop(context),
                )),
                const Spacer(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
