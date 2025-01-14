import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stock_application_gas/constants.dart';
import 'package:stock_application_gas/store/stockStore/stockConfirm.dart';

class Addonitem extends StatefulWidget {
  Addonitem({super.key, required this.title});

  @override
  State<Addonitem> createState() => _AddonitemState();
  String title;
}

class _AddonitemState extends State<Addonitem> {
  @override
  int totalPrice = 0;
  int? unitPrice2;
  int? sum1;
  int? sum2;

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
            Navigator.pop(context);
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(''),
            Text(
              'รายการเพิ่มลด',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            Image.asset(
              'assets/icons/backgroundAsset_LoGo_24x 2.png',
              scale: 10,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.04,
            ),
            Padding(
              padding: EdgeInsets.only(left: 15),
              child: Row(
                children: [
                  Container(
                    height: size.height * 0.045,
                    width: size.width * 0.3,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: kbutton, border: Border.all(color: kbutton)),
                    child: Center(
                      child: Text(
                        widget.title,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: List.generate(
                // controller: _scrollController,
                gas_km.length,
                (index) {
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
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          // ตรวจสอบและลดค่า
                                          if (int.parse(gas_km[index]['sum1'] ?? '0') > 0) {
                                            gas_km[index]['sum1'] = (int.parse(gas_km[index]['sum1'] ?? '0') - 1).toString();
                                          }
                                        });
                                      },
                                      child: Container(
                                        width: size.width * 0.07,
                                        height: size.width * 0.07,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFCFD8DC),
                                          borderRadius: BorderRadius.circular(30),
                                        ),
                                        child: Icon(
                                          Icons.remove,
                                          size: 15,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 20),
                                    Container(
                                      color: Colors.white,
                                      height: size.height * 0.045,
                                      width: size.width * 0.15,
                                      child: TextField(
                                        controller: TextEditingController(
                                          text: NumberFormat('#,##0', 'en_US').format(int.parse(gas_km[index]['sum1'] ?? '0')),
                                        ),
                                        keyboardType: TextInputType.number,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 20),
                                        onSubmitted: (value) {
                                          setState(
                                            () {
                                              // อัปเดตค่าจาก TextField
                                              int? newValue = int.tryParse(value.replaceAll(',', ''));
                                              if (newValue != null) {
                                                gas_km[index]['sum1'] = newValue.toString();
                                              }
                                            },
                                          );
                                        },
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          contentPadding: EdgeInsets.symmetric(vertical: 5),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 20),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          // เพิ่มค่า
                                          gas_km[index]['sum1'] = (int.parse(gas_km[index]['sum1'] ?? '0') + 1).toString();
                                        });
                                      },
                                      child: Container(
                                        width: size.width * 0.07,
                                        height: size.width * 0.07,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFCFD8DC),
                                          borderRadius: BorderRadius.circular(30),
                                        ),
                                        child: Icon(
                                          Icons.add,
                                          size: 15,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    '${gas_km[index]['brand2']}',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          // ตรวจสอบและลดค่า
                                          if (int.parse(gas_km[index]['sum2'] ?? '0') > 0) {
                                            gas_km[index]['sum2'] = (int.parse(gas_km[index]['sum2'] ?? '0') - 1).toString();
                                          }
                                        });
                                      },
                                      child: Container(
                                        width: size.width * 0.07,
                                        height: size.width * 0.07,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFCFD8DC),
                                          borderRadius: BorderRadius.circular(30),
                                        ),
                                        child: Icon(
                                          Icons.remove,
                                          size: 15,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 20),
                                    Container(
                                      color: Colors.white,
                                      height: size.height * 0.045,
                                      width: size.width * 0.15,
                                      child: TextField(
                                        controller: TextEditingController(
                                          text: NumberFormat('#,##0', 'en_US').format(int.parse(gas_km[index]['sum2'] ?? '0')),
                                        ),
                                        keyboardType: TextInputType.number,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 20),
                                        onSubmitted: (value) {
                                          setState(
                                            () {
                                              // อัปเดตค่าจาก TextField
                                              int? newValue = int.tryParse(value.replaceAll(',', ''));
                                              if (newValue != null) {
                                                gas_km[index]['sum2'] = newValue.toString();
                                              }
                                            },
                                          );
                                        },
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          contentPadding: EdgeInsets.symmetric(vertical: 5),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 20),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          // เพิ่มค่า
                                          gas_km[index]['sum2'] = (int.parse(gas_km[index]['sum2'] ?? '0') + 1).toString();
                                        });
                                      },
                                      child: Container(
                                        width: size.width * 0.07,
                                        height: size.width * 0.07,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFCFD8DC),
                                          borderRadius: BorderRadius.circular(30),
                                        ),
                                        child: Icon(
                                          Icons.add,
                                          size: 15,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
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
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StockConfirm(
                              title: widget.title,
                            )),
                    (route) => false);
              },
              child: Text(
                'ตกลง',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
