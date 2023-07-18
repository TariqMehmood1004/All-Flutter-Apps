import 'package:app/constants/colors/colors.dart';
import 'package:app/constants/custom_widgets/constant_widget.dart';
import 'package:flutter/material.dart';

class ListController extends StatefulWidget {
  const ListController({super.key});

  @override
  State<ListController> createState() => _ListControllerState();
}

final List<AddCustomWidget> _addCustomWidget = [];

class _ListControllerState extends State<ListController> {
  void _addWidget() {
    setState(() {
      _addCustomWidget.add(const AddCustomWidget());
    });
  }

  // void _deleteWidget() {
  //   setState(() {
  //     if (_addCustomWidget.isEmpty) {
  //       debugPrint("empty");
  //     } else {
  //       _addCustomWidget.removeLast();
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.accentColor,
        elevation: 0,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            myTextWidget(
              title: 'List of All Causes',
              color: Constants.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
              fontFamily: Constants.roboto,
            ),
            IconButton(
              onPressed: _addWidget,
              icon: const Icon(
                Icons.add,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Constants.white,
      body: ListView.builder(
        itemCount: _addCustomWidget.length,
        itemBuilder: (context, index) {
          return _addCustomWidget[index];
        },
      ),
    );
  }
}

class AddCustomWidget extends StatefulWidget {
  const AddCustomWidget({Key? key}) : super(key: key);

  @override
  State<AddCustomWidget> createState() => _AddCustomWidgetState();
}

class _AddCustomWidgetState extends State<AddCustomWidget> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.list_alt_rounded),
      title: myTextWidget(
        title: 'One line with three widgets',
        color: Constants.black,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        fontFamily: Constants.roboto,
      ),
      trailing: GestureDetector(
        onTap: () {
          setState(() {
            // _addCustomWidget.removeAt(0);
          });
        },
        child: const Icon(
          Icons.favorite,
        ),
      ),
    );
  }
}
