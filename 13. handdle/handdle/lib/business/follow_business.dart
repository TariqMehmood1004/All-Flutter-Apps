import 'package:flutter/material.dart';
import '../../utils/colors.dart';

class FollowBusiness extends StatefulWidget {
  const FollowBusiness({super.key});

  @override
  State<FollowBusiness> createState() => _FollowBusinessState();
}

class _FollowBusinessState extends State<FollowBusiness> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Follow Business", style: TextStyle(fontSize: 24,fontWeight: FontWeight.w600),),
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
                  // Add your search functionality here
                },
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(size.width * 0.05),
        child: Column(
          children: [
            const Divider(),
            const ListTile(
              leading: CircleAvatar(radius: 25,),
              title: Text("My Business", style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
              subtitle: Text("Tap to create business", style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400, color: Color(0xff6D7580)),),
            ),
            const Divider(),
            const SizedBox(height: 10,),
            const Row(
              children: [
                Text("Find business", style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600),),
              ],
            ),
            const SizedBox(height: 10,),
            TextFormField(
              // controller: userName,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please Enter *';
                }
                return null;
              },
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: primaryColor, width: 2.0),
                  borderRadius: BorderRadius.circular(50.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: primaryColor, width: 2.0),
                  borderRadius: BorderRadius.circular(50.0),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: primaryColor, width: 2.0),
                  borderRadius: BorderRadius.circular(50.0),
                ),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: primaryColor, width: 3),
                    borderRadius: BorderRadius.circular(50)
                ),
                // border: InputBorder.none,
                hintText: "62 853-4484-2849",
                prefixIcon: const Icon(Icons.call,color: Colors.grey,),
              ),
            ),
            const SizedBox(height: 30,),
            Container(
              width: size.width,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: primaryColor
              ),
              child: const Text("Proceed",textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontSize: 18),),
            ),
            const SizedBox(height: 30,),
            const Row(
              children: [
                Text("Business from your contact list", style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600),),
              ],
            ),
            const SizedBox(height: 10,),
            ListTile(
              leading: CircleAvatar(radius: 25,),
              title: Row(
                children: [
                  const Text("Spotify", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                  const SizedBox(width: 3,),
                  Image.asset("images/solar_verified-check-bold.png"),
                ],
              ),
              subtitle: const Row(
                children: [
                  Text("Entertainment", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),),
                  SizedBox(width: 30,),
                  Text("21k Followers", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),),
                ],
              ),
            ),
            ListTile(
              leading: CircleAvatar(radius: 25,),
              title: Row(
                children: [
                  const Text("Photo Hub", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                  const SizedBox(width: 3,),
                  Image.asset("images/solar_verified-check-bold.png"),
                ],
              ),
              subtitle: const Row(
                children: [
                  Text("Education", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),),
                  SizedBox(width: 30,),
                  Text("1M Followers", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}


