import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stock_application_gas/constants.dart';
import 'package:stock_application_gas/diver/StorageTank/StoragetankPage.dart';
import 'package:stock_application_gas/diver/diverPage.dart';
import 'package:stock_application_gas/widgetHub/waterMark.dart';
import 'package:stock_application_gas/widgets/Dialog.dart';

class TankUp extends StatefulWidget {
  const TankUp({super.key});

  @override
  State<TankUp> createState() => _TankUpState();
}

class _TankUpState extends State<TankUp> {
  int selectindex = 0;
  String? nametank;
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
            Navigator.pop(context);
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(''),
            Text(
              'เก็บถังอัดบรรจุ(ขึ้นรถ)',
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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      gastankDiver.length,
                      (index) {
                        nametank = gastankDiver[index]['nameTank'];

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
                              gastankDiver[index]['nameTank'] ?? '',
                              style: TextStyle(fontSize: 20, color: selectindex == index ? Colors.white : kbutton, fontWeight: FontWeight.bold),
                            )),
                          ),
                        );
                      },
                    ),
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
                                        // GestureDetector(
                                        //   onTap: () {
                                        //     setState(() {
                                        //       gas_km[index]['sum1'] = gas_km[index]['originalSum1'] ?? '';
                                        //       // controller[index].text = NumberFormat('#,##0', 'en_US').format(int.parse(gas_km['originalSum1'] ?? '0'));
                                        //     });
                                        //   },
                                        //   child: Container(
                                        //     width: size.width * 0.07,
                                        //     height: size.width * 0.07,
                                        //     decoration: BoxDecoration(
                                        //       color: Colors.redAccent,
                                        //       borderRadius: BorderRadius.circular(30),
                                        //     ),
                                        //     child: Icon(
                                        //       Icons.refresh,
                                        //       color: Colors.white,
                                        //       size: 15,
                                        //     ),
                                        //   ),
                                        // ),
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
                final ok = await showDialog(
                  context: context,
                  builder: (context) => AlertDialogYesNo(
                    title: 'แจ้งเตือน',
                    description: 'คุณต้องการบันทึกรายการต่อไปนี้ใช่หรือไม่',
                    pressYes: () {
                      Navigator.pop(context, true);
                    },
                    pressNo: () {
                      Navigator.pop(context, false);
                    },
                  ),
                );
                if (ok == true) {
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => StoragetankPage()), (route) => false);
                }
              },
              child: Text(
                'บันทึกการทำรายการ',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
