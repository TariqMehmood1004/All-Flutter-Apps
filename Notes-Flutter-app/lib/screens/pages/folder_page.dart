

import 'package:flutter/material.dart';
import 'package:notes/colors/colors.dart';

class FolderPage extends StatefulWidget {
  const FolderPage({super.key});

  @override
  State<FolderPage> createState() => _FolderPageState();
}

class _FolderPageState extends State<FolderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: const SafeArea(
          child: Center(
            child: Text("Folder Page"),
          )
      ),
    );
  }
}
