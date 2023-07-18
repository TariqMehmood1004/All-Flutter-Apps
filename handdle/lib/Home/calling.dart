import 'package:flutter/material.dart';
import 'package:handdle/utils/colors.dart';
import 'package:get/get.dart';

class CallingScreen extends StatefulWidget {
  const CallingScreen({super.key});

  @override
  State<CallingScreen> createState() => _CallingScreenState();
}

class _CallingScreenState extends State<CallingScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Center(),
          Column(
            children: [
              Image.asset("images/Mask Group.png"),
              const Text("Kristin Watson",style: TextStyle(fontSize: 26,fontWeight: FontWeight.w600),),
              const Text("Ringing...",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w300),),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: (){
                  Get.back();
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.pink.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(50)
                  ),
                    child: Image.asset("images/times-circle.png")
                ),
              ),
              const SizedBox(width: 20,),
              Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: primaryColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(50)
                  ),
                  child: Image.asset("images/phone.png")
              ),
              // Image.asset("images/phone.png")
            ],
          )
        ],
      ),
    );
  }
}
