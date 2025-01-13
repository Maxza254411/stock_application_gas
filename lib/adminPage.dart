import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stock_application_gas/constants.dart';
import 'package:stock_application_gas/login/loginPage.dart';
import 'package:stock_application_gas/store/storePage.dart';
import 'package:stock_application_gas/widgetHub/waterMark.dart';
import 'package:stock_application_gas/widgets/Dialog.dart';

class Adminpage extends StatefulWidget {
  const Adminpage({super.key});

  @override
  State<Adminpage> createState() => _AdminpageState();
}

class _AdminpageState extends State<Adminpage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: size.height * 0.1,
        automaticallyImplyLeading: false,
        backgroundColor: kbutton,
        title: Center(
          child: Text(
            'หน้าการจัดการของเเอดมิน',
            style: TextStyle(color: kTextButtonColor, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'โกดังสินค้า',
                  style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: [
                SizedBox(
                  height: size.height * 0.02,
                ),
                Divider(),
                cardItems.isNotEmpty
                    ? SizedBox(
                        width: double.infinity,
                        height: size.height * 0.5,
                        child: ListView.builder(
                          // controller: _scrollController,
                          itemCount: cardItems.length,
                          itemBuilder: (context, index) {
                            final items = cardItems[index];
                            return Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                ListTile(
                                  leading: Icon(
                                    Icons.store,
                                    color: Colors.black,
                                    size: 24,
                                  ),
                                  title: Text(
                                    '${items['nameStore']}',
                                    style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                                  ),
                                  trailing: Icon(Icons.arrow_forward_ios),
                                  onTap: () async {
                                    final SharedPreferences prefs = await _prefs;
                                    prefs.setString('title', items['nameStore'] ?? '');

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Storepage(
                                                store: items['nameStore'] ?? '',
                                              )),
                                    );
                                  },
                                ),
                                Divider(),
                                // Container(
                                //   width: double.infinity,
                                //   height: size.height * 0.06,
                                //   decoration: BoxDecoration(
                                //     color: kbutton,
                                //     borderRadius: BorderRadius.circular(10),
                                //   ),
                                //   child: Center(
                                //     child: Text(
                                //       '${items['nameStore']}',
                                //       style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                                //     ),
                                //   ),
                                // ),
                                // GestureDetector(
                                //   onTap: () {
                                //     Navigator.push(
                                //       context,
                                //       MaterialPageRoute(
                                //           builder: (context) => Storepage(
                                //                 store: items['nameStore'] ?? '',
                                //               )),
                                //     );
                                //   },
                                //   child: Padding(
                                //     padding: const EdgeInsets.all(8.0),
                                //     child: Container(
                                //       width: size.width * 0.3,
                                //       height: size.height * 0.06,
                                //       decoration: BoxDecoration(
                                //         color: Colors.grey,
                                //         borderRadius: BorderRadius.circular(10),
                                //       ),
                                //       child: Center(
                                //         child: Text(
                                //           'ตั้งค่าร้านค้า',
                                //           style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                                //         ),
                                //       ),
                                //     ),
                                //   ),
                                // ),
                              ],
                            );
                          },
                        ),
                      )
                    : Center(child: Text('ขนะนี้ไม่มีร้านค้าที่ตั้บงเอาไว้'))
              ],
            ),
          ],
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
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => LoginPage(),
                //   ),
                // );
                // show
                final ok = await showDialog(
                  context: context,
                  builder: (context) => AlertDialogYesNo(
                    title: 'แจ้งเตือน',
                    description: 'คุณต้องการออกจากระบบหรือไม่',
                    pressYes: () {
                      Navigator.pop(context, true);
                    },
                    pressNo: () {
                      Navigator.pop(context, false);
                    },
                  ),
                );
                if (ok == true) {
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
                }
              },
              child: Text(
                'ออกจากระบบ',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
