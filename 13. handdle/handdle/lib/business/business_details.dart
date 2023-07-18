import 'package:flutter/material.dart';
import '../../utils/colors.dart';
import 'follow_business.dart';
import 'package:get/get.dart';

class BusinessDetails extends StatefulWidget {
  const BusinessDetails({super.key});

  @override
  State<BusinessDetails> createState() => _BusinessDetailsState();
}

class _BusinessDetailsState extends State<BusinessDetails> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(15)
              ),
              child: IconButton(
                color: primaryColor,
                icon: const Icon(Icons.search),
                onPressed: () {
                  Get.to(() => const FollowBusiness());
                  // Add your search functionality here
                },
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                height: 200.0,
                color: const Color(0xff09101D),
                child: const Center(
                  child: Text("Cover Photo", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),),
                ),
              ),
              const SizedBox(height: 85,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Spotify', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                  // const SizedBox(width: 5,),
                  Image.asset("images/solar_verified-check-bold.png"),
                ],
              ),
              const SizedBox(height: 5,),
              const Text('Finance', style: TextStyle(fontSize: 16, color: Color(0xff545D69)),),
              const SizedBox(height: 10,),
              const IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('234k Followers', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                    VerticalDivider(thickness: 2,color: Colors.black,),
                    Text('65 Responders', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              Padding(
                padding: EdgeInsets.all(size.width * 0.05),
                child: Column(
                  children: [
                    const Row(
                      children: [
                        Text('About', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    const Row(
                      children: [
                        Text('Buy all your Bitcoin access codes here....', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                      ],
                    ),
                    const Row(
                      children: [
                        Text('February 25, 2022 | created by Samuel Wilson', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),),
                      ],
                    ),
                    const SizedBox(height: 50,),
                    Container(
                      width: size.width,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: primaryColor
                      ),
                      child: const Text("Follow business",textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontSize: 18),),
                    ),
                    const SizedBox(height: 50,),
                    const Divider(),
                    const Row(
                      children: [
                        Icon(Icons.thumb_down_alt_outlined, color: Colors.red,),
                        SizedBox(width: 10,),
                        Text("Report Business", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: Colors.red),)
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          // Profile image
          Positioned(
            top: 130.0, // (background container size) - (circle height / 2)
            child: CircleAvatar(radius: size.width * 0.18,child: const Icon(Icons.person, size: 70,),),
          ),
        ],
      ),
    );
  }
}

