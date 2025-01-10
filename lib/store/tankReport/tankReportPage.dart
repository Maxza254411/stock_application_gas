import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stock_application_gas/constants.dart';
import 'package:stock_application_gas/store/storePage.dart';

class Tankreportpage extends StatefulWidget {
  const Tankreportpage({
    super.key,
  });

  @override
  State<Tankreportpage> createState() => _TankreportpageState();
}

class _TankreportpageState extends State<Tankreportpage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
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
        automaticallyImplyLeading: true,
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
                    store: headtitle!,
                  ),
                ),
                (route) => false);
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(''),
            Text(
              'รายงานการยืมถัง',
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
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(children: [
            Center(
              child: Column(
                children: List.generate(
                  reportTank.length,
                  (index) {
                    return Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Container(
                        width: size.width * 0.8,
                        height: size.height * 0.3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey[300],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'วันที่',
                                    style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    reportTank[index]['date'] ?? '',
                                    style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'ขนาด',
                                    style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    reportTank[index]['km'] ?? '',
                                    style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'ยี่ห้อ',
                                    style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                                  ),
                                  Text(reportTank[index]['brand'] ?? '',
                                      style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold))
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('จำนวน', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
                                  Text(reportTank[index]['unit'] ?? '',
                                      style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold))
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('หมายเหตุ', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
                                  Text(reportTank[index]['remark'] ?? '',
                                      style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold))
                                ],
                              ),
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.red,
                                ),
                                width: size.width * 0.4,
                                height: size.height * 0.06,
                                child: Center(
                                  child: Text(
                                    'เรียกเก็บคืนเเล้ว',
                                    style: TextStyle(fontSize: 20, color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
