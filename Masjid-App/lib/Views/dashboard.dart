// ignore_for_file: avoid_unnecessary_containers

import 'package:app/Views/bookmark.dart';
import 'package:app/Views/city_location.dart';
import 'package:app/Views/list.dart';
import 'package:app/Views/notification.dart';
import 'package:app/Views/user_information.dart';
import 'package:app/constants/colors/colors.dart';
import 'package:app/constants/custom_widgets/constant_widget.dart';
import 'package:app/providers/urger_causes_provider.dart';
import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

class DashboardController extends StatefulWidget {
  const DashboardController({Key? key}) : super(key: key);

  @override
  State<DashboardController> createState() => _DashboardControllerState();
}

class _DashboardControllerState extends State<DashboardController> {
  final searchController = TextEditingController();
  bool isClicked1 = false;
  bool isClicked2 = false;
  bool isClicked3 = false;
  bool isClicked4 = false;

  @override
  void initState() {
    super.initState();
    setStatusBarColor(Constants.transparent);
  }

  void _vibrate() async {
    bool? hasVibrator = await Vibration.hasVibrator();
    if (hasVibrator == true) {
      Vibration.vibrate(duration: 100);
    }
  }

  void toggleFavorite(bool isClick) {
    setState(() {
      isClick = !isClick;
      isClick = !isClick;
      isClick = !isClick;
      isClick = !isClick;
      _vibrate();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Constants.accentColor,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: size.width,
              height: size.height,
              child: Stack(
                children: [
                  profileInfo(size),
                  totalDonation(size),
                  masjidDonationLogo(),
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        Container(
                          width: size.width,
                          margin: EdgeInsets.only(top: size.height * 0.3),
                          decoration: const BoxDecoration(
                            color: Constants.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30.0),
                              topRight: Radius.circular(30.0),
                            ),
                          ),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 30.0,
                              ),
                              Positioned(
                                top: 290,
                                right: 5,
                                left: 5,
                                child: Container(
                                  width: size.width,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 40),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      gradient: Constants.background2,
                                      boxShadow: [
                                        BoxShadow(
                                          color:
                                              Constants.black.withOpacity(0.2),
                                        )
                                      ]),
                                  child: TextFormField(
                                    onChanged: (value) {},
                                    controller: searchController,
                                    decoration: const InputDecoration(
                                      fillColor: Constants.blueAccentColor,
                                      prefixIcon: Icon(Icons.search),
                                      prefixIconColor: Constants.black,
                                      hintText: 'Search for causes',
                                      hintStyle: TextStyle(
                                        fontSize: 14.0,
                                        color: Constants.black,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ),
                              titleAndViewAllWidget(
                                size: size,
                                top: 10,
                                right: 0,
                                left: 0,
                                bottom: 0,
                                icon: Icons.arrow_forward_ios,
                                operationTitle: 'View All',
                                title: 'Urgent Causes',
                              ),
                              urgentCausesWidget(size),
                              titleAndViewAllWidget(
                                size: size,
                                top: 10,
                                right: 0,
                                left: 0,
                                bottom: 0,
                                icon: Icons.arrow_forward_ios,
                                operationTitle: 'View All',
                                title: 'Featured Causes',
                              ),
                              imageFavorite(
                                size,
                                imageURL: 'assets/images/masjid-1.jpg',
                                titleText: 'Masjid Al-Haram'.toUpperCase(),
                                isFavorite: isClicked1,
                                isClick: () {
                                  setState(
                                    () {
                                      isClicked1 = !isClicked1;
                                      _vibrate();
                                    },
                                  );
                                },
                              ),
                              imageFavorite(
                                size,
                                imageURL: 'assets/images/masjid-2.jpg',
                                isFavorite: isClicked2,
                                titleText: 'Blue Mosque'.toUpperCase(),
                                isClick: () {
                                  setState(
                                    () {
                                      isClicked2 = !isClicked2;
                                      _vibrate();
                                    },
                                  );
                                },
                              ),
                              imageFavorite(
                                size,
                                imageURL: 'assets/images/masjid-3.jpg',
                                isFavorite: isClicked3,
                                titleText: 'Masjid Al Nabawi'.toUpperCase(),
                                isClick: () {
                                  setState(
                                    () {
                                      isClicked3 = !isClicked3;
                                      _vibrate();
                                    },
                                  );
                                },
                              ),
                              imageFavorite(
                                size,
                                imageURL: 'assets/images/masjid-4.jpg',
                                isFavorite: isClicked4,
                                titleText: 'St Petersburg Mosque'.toUpperCase(),
                                isClick: () {
                                  setState(
                                    () {
                                      isClicked4 = !isClicked4;
                                      _vibrate();
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: bottomNavigationBar(context),
    );
  }

  InkWell imageFavorite(
    Size size, {
    String imageURL = '',
    VoidCallback? isClick,
    bool isFavorite = false,
    String titleText = '',
    String description =
        'The Faisal Mosque is the largest mosque in Pakistan...',
  }) {
    return InkWell(
      onDoubleTap: isClick,
      child: Container(
        width: size.width,
        height: 120,
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: Constants.background3,
        ),
        child: Row(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Image(
                      fit: BoxFit.cover,
                      image: AssetImage(imageURL.toString()),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(
                      top: 0,
                      left: 40,
                      right: 0,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      // gradient: Constants.background2,
                    ),
                    child: Icon(
                      size: 40,
                      isFavorite ? Icons.favorite_rounded : null,
                      color: isFavorite ? Constants.white : null,
                      shadows: const [
                        Shadow(
                          color: Constants.black,
                          blurRadius: 15,
                          offset: Offset(3, 3),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 12.0,
                  horizontal: 12.0,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: myTextWidget(
                          title: titleText,
                          color: Constants.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          fontFamily: Constants.roboto,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: myTextWidget(
                        title: description,
                        color: Constants.clickEventTextColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w100,
                        fontFamily: Constants.roboto,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Expanded(
              child: Icon(
                Icons.arrow_forward_ios,
                color: Constants.blueAccentColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container bottomNavigationBar(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12.0),
      margin: const EdgeInsets.only(left: 40, right: 8),
      decoration: BoxDecoration(
          color: Constants.accentColor2,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Constants.black.withOpacity(0.2),
            )
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              _vibrate();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DashboardController(),
                ),
              );
              setState(() {});
            },
            icon: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                // color: Constants.clickEventTextColor,
              ),
              child: const Icon(
                Icons.home,
                color: Constants.black,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              _vibrate();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ListController(),
                ),
              );

              setState(() {});
            },
            icon: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                // color: Constants.clickEventTextColor,
              ),
              child: const Icon(
                Icons.list,
                color: Constants.black,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              _vibrate();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BookMarkController(),
                ),
              );

              setState(() {});
            },
            icon: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                // color: Constants.clickEventTextColor,
              ),
              child: const Icon(
                Icons.bookmark,
                color: Constants.black,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              _vibrate();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LocationCityController(),
                ),
              );

              setState(() {});
            },
            icon: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                // color: Constants.clickEventTextColor,
              ),
              child: const Icon(
                Icons.location_city_rounded,
                color: Constants.black,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              _vibrate();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationController(),
                ),
              );

              setState(() {});
            },
            icon: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                // color: Constants.clickEventTextColor,
              ),
              child: const Icon(
                Icons.notifications,
                color: Constants.black,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              _vibrate();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const UserInfoController(),
                ),
              );

              setState(() {});
            },
            icon: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                // color: Constants.clickEventTextColor,
              ),
              child: const Icon(
                Icons.info,
                color: Constants.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container titleAndViewAllWidget({
    Size size = const Size(0, 0),
    String title = '',
    String operationTitle = '',
    IconData? icon,
    double top = 0,
    double right = 0,
    double left = 0,
    double bottom = 0,
  }) {
    return Container(
      margin:
          EdgeInsets.only(top: top, bottom: bottom, right: right, left: left),
      child: Container(
        width: size.width,
        padding:
            const EdgeInsets.only(top: 12.0, bottom: 10.0, left: 20, right: 20),
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title.toString(),
              style: const TextStyle(
                fontSize: 16.0,
                color: Constants.black,
                fontFamily: Constants.roboto,
                fontWeight: FontWeight.w700,
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Row(
                children: [
                  myTextWidget(
                    title: operationTitle.toString(),
                    color: Constants.black,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w400,
                    fontFamily: Constants.roboto,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Icon(icon),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container urgentCausesWidget(Size size) {
    return Container(
      width: size.width,
      height: 200,
      padding: const EdgeInsets.all(3),
      margin: const EdgeInsets.only(top: 10, left: 10, right: 0),
      decoration: BoxDecoration(
        color: Constants.transparent,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ListView.builder(
              itemCount: UrgentCausesSlider().urgentCauses.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  width: 200,
                  height: 180,
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  decoration: BoxDecoration(
                    gradient: UrgentCausesSlider().gradientColor[index],
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: Constants.transparent,
                          radius: 30.0,
                          backgroundImage: AssetImage(UrgentCausesSlider()
                              .urgentCausesImages[index]
                              .toString()),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        myTextWidget(
                          title: UrgentCausesSlider()
                              .urgentCauses[index]
                              .toString(),
                          fontSize: 13.0,
                          color: Constants.black,
                          fontWeight: FontWeight.w600,
                          fontFamily: Constants.roboto,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        myTextWidget(
                          title: UrgentCausesSlider().urgentDescription[index],
                          fontSize: 9.0,
                          color: Constants.black,
                          fontWeight: FontWeight.w300,
                          fontFamily: Constants.roboto,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Positioned masjidDonationLogo() {
    return const Positioned(
      top: 165,
      left: 30,
      child: CircleAvatar(
        backgroundImage: AssetImage('assets/images/masjid.png'),
        backgroundColor: Constants.accentBlueColor,
        foregroundColor: Constants.white,
        radius: 25,
      ),
    );
  }

  Container totalDonation(Size size) {
    return Container(
      width: size.width,
      height: 40,
      margin: EdgeInsets.only(
        top: size.height * 0.20,
        left: 40,
        right: 40,
      ),
      decoration: BoxDecoration(
        color: Constants.contentCardColor,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 55.0,
          ),
          Expanded(
            flex: 2,
            child: myTextWidget(
              title: '\$1600 total donation',
              color: Constants.black,
              fontSize: 14.0,
              fontWeight: FontWeight.w600,
              fontFamily: Constants.roboto,
            ),
          ),
          const SizedBox(
            width: 15.0,
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {},
              child: Row(
                children: [
                  myTextWidget(
                    title: 'Top up',
                    color: Constants.black,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w300,
                    fontFamily: Constants.roboto,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container profileInfo(Size size) {
    return Container(
      width: size.width,
      height: 80,
      margin: EdgeInsets.only(
        top: size.height * 0.07,
        left: 20,
        right: 20,
      ),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundImage: AssetImage('assets/images/tm.jpg'),
            backgroundColor: Constants.white,
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                myTextWidget(
                  title: 'Tariq Mehmood',
                  color: Constants.navColor,
                  fontSize: 22.0,
                  fontWeight: FontWeight.w500,
                  fontFamily: Constants.roboto,
                ),
                myTextWidget(
                  title: ' There is a lot of good left to do...',
                  color: Constants.navColor,
                  fontSize: 10.0,
                  fontWeight: FontWeight.w100,
                  fontFamily: Constants.openSans,
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Container(
            padding: const EdgeInsets.all(1),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Constants.white,
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_none),
            ),
          ),
        ],
      ),
    );
  }
}
