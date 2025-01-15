import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stock_application_gas/constants.dart';
import 'package:stock_application_gas/store/storePage.dart';
import 'package:stock_application_gas/widgets/Dialog.dart';

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
              'assets/icons/backgroundAsset_LoGo_24x 2.png',
              scale: 10,
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    reportTank.length,
                    (index) {
                      return Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Container(
                          width: size.width * 0.8,
                          height: size.height * 0.25,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey[300],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: size.height * 0.01,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: Text(
                                          'ขนาด${reportTank[index]['km'] ?? ''}',
                                          style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: Text(
                                          reportTank[index]['date'] ?? '',
                                          style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: Text(reportTank[index]['brand'] ?? '',
                                            style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: Text('จำนวน ${reportTank[index]['unit']}',
                                            style: TextStyle(color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                        flex: 2,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 10),
                                          child: Text('หมายเหตุ',
                                              style: TextStyle(
                                                color: Color(0xff5C5C5C),
                                                fontSize: 20,
                                              )),
                                        )),
                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: Text(reportTank[index]['remark'] ?? '',
                                            style: TextStyle(
                                              color: Color(0xff5C5C5C),
                                              fontSize: 20,
                                            )),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: size.height * 0.06,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    final ok = await showDialog(
                                      context: context,
                                      builder: (context) => AlertDialogYesNo(
                                        title: 'แจ้งเตือน',
                                        description: 'ถังจะส่งในยอดถังปล่าวต้องการเก็บคืนถังหรือไม่',
                                        pressYes: () {
                                          Navigator.pop(context, true);
                                        },
                                        pressNo: () {
                                          Navigator.pop(context, false);
                                        },
                                      ),
                                    );
                                    if (ok == true) {
                                      Navigator.pop(context);
                                      // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
                                    }
                                  },
                                  child: Container(
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
            ],
          ),
        ),
      ),
    );
  }
}
