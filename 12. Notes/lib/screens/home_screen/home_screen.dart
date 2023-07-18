
import 'package:flutter/material.dart';
import 'package:notes/colors/colors.dart';
import 'package:notes/screens/pages/folder_page.dart';
import 'package:notes/screens/pages/home_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List pages = const [
    HomePage(),
    FolderPage(),
  ];

  int _currentIndexPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  "Notes",
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 40,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7.0),
                decoration: BoxDecoration(
                  color: AppColors.transparent,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(Icons.select_all),
                    SizedBox(width: 15,),
                    Icon(Icons.search_outlined),
                    SizedBox(width: 15,),
                    Icon(Icons.settings),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: pages[_currentIndexPage],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.white,
        selectedItemColor: AppColors.offGreen,
        currentIndex: _currentIndexPage,
        onTap: (i) {
          setState(() {
            _currentIndexPage = i;
          });
        },
        items:const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled,), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.folder,), label: "Folder"),
        ],
      ),
    );
  }
}
