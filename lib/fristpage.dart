import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:stock_application_gas/Product/ProductPage.dart';
import 'package:stock_application_gas/constants.dart';
import 'package:stock_application_gas/order/OrderPage.dart';
import 'package:stock_application_gas/orderPage.dart';
// import 'package:google_nav_bar/google_nav_bar.dart';
// import 'package:tcbapp/advice/advicePage.dart';
// import 'package:tcbapp/constants.dart';
// import 'package:tcbapp/history/historyPage.dart';
// import 'package:tcbapp/home/homePage.dart';
// import 'package:tcbapp/information/informationPage.dart';
// import 'package:tcbapp/setting/settingPage.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  int selectedIndex = 0;
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentPage = ProductPage();

  void onItemSelect(int index) {
    setState(() {
      selectedIndex = index;
      if (selectedIndex == 0) {
        currentPage = ProductPage();
      } else if (selectedIndex == 1) {
        currentPage = OrderPage();
      } else if (selectedIndex == 2) {
        //   currentPage = InformationPage();
        // } else if (selectedIndex == 3) {
        //   currentPage = AdvicePage();
        // } else if (selectedIndex == 4) {
        //   currentPage = SettingPage();
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SafeArea(
        child: PageStorage(bucket: bucket, child: currentPage),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.blue,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
              child: GNav(
                rippleColor: Colors.grey[300]!,
                hoverColor: Colors.grey[100]!,
                gap: 5,
                activeColor: Colors.black,
                iconSize: 24,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                duration: Duration(milliseconds: 400),
                tabBackgroundColor: Colors.grey[100]!,
                color: Colors.black,
                tabs: [
                  GButton(
                    icon: Icons.home,
                    iconColor: Colors.white,
                    text: 'หน้าแรก',
                  ),
                  GButton(
                    icon: Icons.archive_outlined,
                    iconColor: Colors.white,
                    text: 'order',
                  ),
                  GButton(
                    icon: Icons.settings,
                    iconColor: Colors.white,
                    text: 'ตั้งค่า',
                  ),
                  // GButton(
                  //   icon: Icons.badge,
                  //   iconColor: Colors.white,
                  //   text: 'คำแนะนำ',
                  // ),
                  // GButton(
                  //   icon: Icons.settings,
                  //   iconColor: Colors.white,
                  //   text: 'ตั้งค่า',
                  // ),
                ],
                selectedIndex: selectedIndex,
                onTabChange: (index) {
                  onItemSelect(index);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
