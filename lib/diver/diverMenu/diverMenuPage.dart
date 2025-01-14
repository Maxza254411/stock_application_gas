import 'package:flutter/material.dart';
import 'package:stock_application_gas/constants.dart';
import 'package:stock_application_gas/diver/StorageTank/StoragetankPage.dart';
import 'package:stock_application_gas/diver/diverPage.dart';
import 'package:stock_application_gas/widgetHub/waterMark.dart';

class Divermenupage extends StatefulWidget {
  const Divermenupage({super.key});

  @override
  State<Divermenupage> createState() => _DivermenupageState();
}

class _DivermenupageState extends State<Divermenupage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: size.height * 0.1,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: kbutton,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => DiverPage()), (route) => false);
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(''),
            Text(
              'หน้าเมนู',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            Image.asset(
              'assets/icons/backgroundAsset_LoGo_24x 2.png',
              scale: 10,
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Watermark(
          backgroundImage: const AssetImage(
            'assets/icons/backgroundAsset_LoGo_24x 2.png',
          ),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => StoragetankPage()));
                  },
                  child: Container(
                    width: size.width * 0.8,
                    height: size.height * 0.06,
                    decoration: BoxDecoration(
                      color: kbutton,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        'รายการเก็บถังอัดบรรจุ',
                        style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                GestureDetector(
                  onTap: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => StoragetankPage()));
                  },
                  child: Container(
                    width: size.width * 0.8,
                    height: size.height * 0.06,
                    decoration: BoxDecoration(
                      color: kbutton,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        'รายการเก็บถังซ้อม / เข้าโกดัง',
                        style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                GestureDetector(
                  onTap: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => DailySalesPage()));
                  },
                  child: Container(
                    width: size.width * 0.8,
                    height: size.height * 0.06,
                    decoration: BoxDecoration(
                      color: kbutton,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        'รายการเติมน้ำมันเชื้อเพลิง',
                        style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => Tankreportpage(),
                    //   ),
                    // );
                  },
                  child: Container(
                    width: size.width * 0.8,
                    height: size.height * 0.06,
                    decoration: BoxDecoration(
                      color: kbutton,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        'Final Report',
                        style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
