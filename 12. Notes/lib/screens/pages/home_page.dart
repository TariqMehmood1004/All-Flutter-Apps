import 'package:flutter/material.dart';
import 'package:notes/colors/colors.dart';
import 'package:notes/widgets/myNotesContainer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String _dateTime = DateTime.now().toString();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                margin: const EdgeInsets.only(top: 30),
                color: AppColors.white,
                child: Column(
                  children: [
                    MyNotesContainer(dateTime: _dateTime),
                    MyNotesContainer(dateTime: _dateTime),
                    MyNotesContainer(dateTime: _dateTime),
                    MyNotesContainer(dateTime: _dateTime),
                    MyNotesContainer(dateTime: _dateTime),
                    MyNotesContainer(dateTime: _dateTime),
                    MyNotesContainer(dateTime: _dateTime),
                    MyNotesContainer(dateTime: _dateTime),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, 
          MaterialPageRoute(builder: (context) => const ShowBottomModalSheet())
          );
        },
        backgroundColor: AppColors.yellowRGBA,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ShowBottomModalSheet extends StatefulWidget {
  const ShowBottomModalSheet({super.key});

  @override
  State<ShowBottomModalSheet> createState() => _ShowBottomModalSheetState();
}

class _ShowBottomModalSheetState extends State<ShowBottomModalSheet> {

  final dateTime = DateTime.now().toString();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leading: GestureDetector(
          onTap: (){
            Navigator.of(context).pop();
          },
          child: const Icon(Icons.arrow_back_ios_new_outlined),
        ),
        title: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7.0),
                decoration: BoxDecoration(
                  color: AppColors.transparent,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(Icons.undo),
                    SizedBox(width: 15,),
                    Icon(Icons.redo),
                    SizedBox(width: 15,),
                    Icon(Icons.save_outlined),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Form(
                child: Column(
                  children: [
                    const TextField(
                      decoration: InputDecoration(
                          hintText: "Title",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                          border: InputBorder.none
                      ),
                      keyboardType: TextInputType.text,
                    ),

                    const SizedBox(height: 15,),

                    Container(
                      alignment: Alignment.topLeft,
                      child: Row(
                        children: [
                          Text(
                            dateTime,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w100,
                              fontSize: 12,
                            ),
                          ),
                          const Text(
                            " |  33 Characters",
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w100,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 15,),

                    const TextField(
                      decoration: InputDecoration(
                          hintText: "Description",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w100,
                            fontSize: 14,
                          ),
                          border: InputBorder.none
                      ),
                      keyboardType: TextInputType.multiline,
                      maxLines: 4,
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
