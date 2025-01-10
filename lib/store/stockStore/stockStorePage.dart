import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stock_application_gas/adminPage.dart';
import 'package:stock_application_gas/constants.dart';
import 'package:stock_application_gas/store/stockStore/addOnItem.dart';
import 'package:stock_application_gas/store/stockStore/historyAddOn.dart';
import 'package:stock_application_gas/store/storePage.dart';
import 'package:stock_application_gas/widgetHub/waterMark.dart';

class Stockstorepage extends StatefulWidget {
  Stockstorepage({super.key, this.title});

  @override
  State<Stockstorepage> createState() => _StockstorepageState();
  String? title;
}

class _StockstorepageState extends State<Stockstorepage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  int selectindex = 0;
  String? nametank;
  String headtitle = '';

  getprefs() async {
    final SharedPreferences prefs = await _prefs;
    final title = prefs.getString('title');
    setState(() {
      headtitle = title ?? '';
    });
  }

  @override
  void initState() {
    super.initState();
    getprefs();
  }

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
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => Storepage(
                          store: headtitle,
                        )),
                (route) => false);
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(''),
            Text(
              'สต็อกสินค้า',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            Image.asset(
              'assets/images/Gas Logo.png',
              scale: 10,
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Watermark(
          backgroundImage: const AssetImage(
            'assets/images/Gas Logo.png',
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(
                    gastank.length,
                    (index) {
                      nametank = gastank[index]['nameTank'];

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectindex = index;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: selectindex == index ? kbutton : Colors.white,
                              border: Border.all(color: kbutton)),
                          width: size.width * 0.3,
                          height: size.height * 0.06,
                          child: Center(
                              child: Text(
                            gastank[index]['nameTank'] ?? '',
                            style: TextStyle(fontSize: 20, color: selectindex == index ? Colors.white : kbutton, fontWeight: FontWeight.bold),
                          )),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: size.height * 0.5,
                  child: ListView.builder(
                    // controller: _scrollController,
                    itemCount: gas_km.length,
                    itemBuilder: (context, index) {
                      final items = gas_km[index];
                      return Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          ListTile(
                            leading: Container(
                              decoration: BoxDecoration(
                                color: kbutton,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              width: size.width * 0.3,
                              height: size.height * 0.05,
                              child: Center(
                                child: Text(
                                  '${gas_km[index]['km']}',
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                                ),
                              ),
                            ),
                            title: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        '${gas_km[index]['brand1']}',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        '${gas_km[index]['sum1']}',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        '${gas_km[index]['unit']}',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        '${gas_km[index]['brand2']}',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        '${gas_km[index]['sum2']}',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        '${gas_km[index]['unit']}',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            // trailing: Icon(Icons.arrow_forward_ios),
                            onTap: () async {},
                          ),
                          Divider(),
                        ],
                      );
                    },
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Historyaddon()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: size.width * 0.5,
                    height: size.height * 0.06,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          'ประวัติการเพิ่ม/ลด',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(8),
        child: SizedBox(
          height: size.height * 0.07,
          width: size.width * 0.4,
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: kbutton,
                // side: BorderSide(color: textColor),
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onPressed: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Addonitem(
                              title: selectindex == 0
                                  ? 'ถังหมุนเวียน'
                                  : selectindex == 1
                                      ? 'ถังใหม่ขาย'
                                      : 'ถังฝากเติม',
                            )));
              },
              child: Text(
                'เพิ่ม/ลด',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
