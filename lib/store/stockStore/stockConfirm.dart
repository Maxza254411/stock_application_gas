import 'package:flutter/material.dart';
import 'package:stock_application_gas/constants.dart';
import 'package:stock_application_gas/store/stockStore/addOnItem.dart';
import 'package:stock_application_gas/store/stockStore/stockStorePage.dart';
import 'package:stock_application_gas/widgetHub/waterMark.dart';
import 'package:stock_application_gas/widgets/Dialog.dart';

class StockConfirm extends StatefulWidget {
  StockConfirm({super.key, required this.title});

  @override
  State<StockConfirm> createState() => _StockConfirmState();
  String title;
}

class _StockConfirmState extends State<StockConfirm> {
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
        leading: Text(''),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(''),
            Text(
              'รายการเพิ่มลด',
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
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      Container(
                        height: size.height * 0.045,
                        width: size.width * 0.3,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white, border: Border.all(color: kbutton)),
                        child: Center(
                          child: Text(
                            widget.title,
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: size.height * 0.5,
                  child: ListView.builder(
                    // controller: _scrollController,
                    itemCount: oneItem.length,
                    itemBuilder: (context, index) {
                      final items = oneItem[index];
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
                                  '${oneItem[index]['km']}',
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
                                        '${oneItem[index]['brand1']}',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        '${oneItem[index]['sum1']}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: oneItem[index]['sum1'] == '9'
                                                ? Colors.green
                                                : oneItem[index]['sum1'] == '5'
                                                    ? Colors.red
                                                    : Colors.black),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        '${oneItem[index]['unit']}',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        '${oneItem[index]['brand2']}',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        '${oneItem[index]['sum2']}',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        '${oneItem[index]['unit']}',
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
                )
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: size.width * 0.3,
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
                    backgroundColor: Colors.red,
                    // side: BorderSide(color: textColor),
                    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: () async {
                    final ok = await showDialog(
                      context: context,
                      builder: (context) => AlertDialogYesNo(
                        title: 'แจ้งเตือน',
                        description: 'คุณต้องการยกเลิก\nการเพิ่ม/ลด\nหรือไม่',
                        pressYes: () {
                          Navigator.pop(context, true);
                        },
                        pressNo: () {
                          Navigator.pop(context, false);
                        },
                      ),
                    );
                    if (ok == true) {
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Stockstorepage()), (route) => false);
                    }
                  },
                  child: Text(
                    'ยกเลิก',
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                ),
              ),
              Container(
                width: size.width * 0.3,
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
                    backgroundColor: Colors.yellow,
                    // side: BorderSide(color: textColor),
                    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: () async {
                    final ok = await showDialog(
                      context: context,
                      builder: (context) => AlertDialogYesNo(
                        title: 'แจ้งเตือน',
                        description: 'คุณต้องการแก้ไข\nการเพิ่ม/ลด\nหรือไม่',
                        pressYes: () {
                          Navigator.pop(context, true);
                        },
                        pressNo: () {
                          Navigator.pop(context, false);
                        },
                      ),
                    );
                    if (ok == true) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Addonitem(
                                    title: widget.title,
                                  )),
                          (route) => false);
                    }
                  },
                  child: Text(
                    'แก้ไข',
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                ),
              ),
              Container(
                width: size.width * 0.3,
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
                    final ok = await showDialog(
                      context: context,
                      builder: (context) => AlertDialogYesNo(
                        title: 'แจ้งเตือน',
                        description: 'คุณต้องการ Up date \nการเพิ่ม/ลด\nหรือไม่',
                        pressYes: () {
                          Navigator.pop(context, true);
                        },
                        pressNo: () {
                          Navigator.pop(context, false);
                        },
                      ),
                    );
                    if (ok == true) {
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Stockstorepage()), (route) => false);
                    }
                    // Navigator.pushAndRemoveUntil(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => StockConfirm(
                    //               title: widget.title,
                    //             )),
                    //     (route) => false);
                  },
                  child: Text(
                    'UpDate',
                    style: TextStyle(color: Colors.white, fontSize: 17),
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
