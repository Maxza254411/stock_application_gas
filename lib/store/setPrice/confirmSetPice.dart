import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stock_application_gas/constants.dart';
import 'package:stock_application_gas/store/setPrice/%20editprice.dart';
import 'package:stock_application_gas/store/setPrice/setPicePage.dart';
import 'package:stock_application_gas/store/storePage.dart';
import 'package:stock_application_gas/widgets/Dialog.dart';

class Confirmsetpice extends StatefulWidget {
  Confirmsetpice({super.key, required this.productselect});

  @override
  State<Confirmsetpice> createState() => _ConfirmsetpiceState();
  String? productselect;
}

class _ConfirmsetpiceState extends State<Confirmsetpice> {
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
              'กำหนดราคาสินค้า',
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
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: kbutton, border: Border.all(color: kbutton)),
                      width: size.width * 0.3,
                      height: size.height * 0.06,
                      child: Center(
                          child: Text(
                        widget.productselect ?? '',
                        style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                      )),
                    ),
                  ],
                ),
              ),
              Column(
                children: List.generate(
                  priceConfirm.length,
                  (index) {
                    return Padding(
                        padding: EdgeInsets.all(8.0),
                        child: widget.productselect == 'ถังใหม่'
                            ? Container(
                                width: size.width * 0.95,
                                // height: size.height * 0.3,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.grey[300],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              '${priceConfirm[index]['km']}',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Center(
                                              child: Text(
                                                '${priceConfirm[index]['brand1']}',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: size.width * 0.1,
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Center(
                                              child: Text(
                                                '${priceConfirm[index]['brand2']}',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: size.height * 0.01,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              '${priceConfirm[index]['pricecategory1']}',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Center(
                                              child: Text(
                                                '${priceConfirm[index]['sumgas1.3']}',
                                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: size.width * 0.1,
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Center(
                                              child: Text(
                                                '${priceConfirm[index]['sumgas1.4']}',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: size.height * 0.01,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              '${priceConfirm[index]['pricecategory3']}',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Center(
                                              child: Text(
                                                '${priceConfirm[index]['sumgas2.1']}',
                                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: size.width * 0.1,
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Center(
                                              child: Text(
                                                '${priceConfirm[index]['sumgas2.2']}',
                                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: size.height * 0.01,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              '${priceConfirm[index]['pricecategory4']}',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Center(
                                              child: Text(
                                                '${priceConfirm[index]['sumgas2.1']}',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: size.width * 0.1,
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Center(
                                              child: Text(
                                                '${priceConfirm[index]['sumgas2.2']}',
                                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Container(
                                width: size.width * 0.95,
                                // height: size.height * 0.3,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.grey[300],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              '${priceConfirm[index]['km']}',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Center(
                                              child: Text(
                                                '${priceConfirm[index]['brand1']}',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: size.height * 0.01,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              '${priceConfirm[index]['pricecategory1']}',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Center(
                                              child: Text(
                                                '${priceConfirm[index]['sumgas1.3']}',
                                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: size.height * 0.01,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              '${priceConfirm[index]['pricecategory3']}',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Center(
                                              child: Text(
                                                '${priceConfirm[index]['sumgas2.1']}',
                                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: size.height * 0.01,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              '${priceConfirm[index]['pricecategory4']}',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Center(
                                              child: Text(
                                                '${priceConfirm[index]['sumgas2.1']}',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ));
                  },
                ),
              ),
            ],
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
                        description: 'คุณต้องการยกเลิก\nการกำหนดราคาขาย\nหรือไม่',
                        pressYes: () {
                          Navigator.pop(context, true);
                        },
                        pressNo: () {
                          Navigator.pop(context, false);
                        },
                      ),
                    );
                    if (ok == true) {
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Setpicepage()), (route) => false);
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
                        description: 'คุณต้องการแก้ไข\nการกำหนดราคาขาย\nหรือไม่',
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
                            builder: (context) => Editprice(
                              productselect: widget.productselect,
                            ),
                          ),
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
                        description: 'คุณต้องการ Up date \nการกำหนดราคาขาย\nหรือไม่',
                        pressYes: () {
                          Navigator.pop(context, true);
                        },
                        pressNo: () {
                          Navigator.pop(context, false);
                        },
                      ),
                    );
                    if (ok == true) {
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Setpicepage()), (route) => false);
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
