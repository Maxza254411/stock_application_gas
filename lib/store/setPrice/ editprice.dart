import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stock_application_gas/constants.dart';
import 'package:stock_application_gas/store/setPrice/SetPicePage.dart';
import 'package:stock_application_gas/store/setPrice/confirmSetPice.dart';
import 'package:stock_application_gas/store/storePage.dart';
import 'package:stock_application_gas/widgets/Dialog.dart';

class Editprice extends StatefulWidget {
  Editprice({super.key, required this.productselect});

  @override
  State<Editprice> createState() => _EditpriceState();
  String? productselect;
}

class _EditpriceState extends State<Editprice> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  String? headtitle;
  @override
  void initState() {
    super.initState();
  }

  int selectindex = 0;
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
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Setpicepage()), (route) => false);
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(''),
            Text(
              'แก้ไขกำหนดราคาสินค้า',
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
                  priceCategory.length,
                  (index) {
                    return Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Container(
                          width: size.width * 0.95,
                          height: size.height * 0.3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey[300],
                          ),
                          child: widget.productselect == 'ถังใหม่'
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              '${priceCategory[index]['km']}',
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
                                                '${priceCategory[index]['brand1']}',
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
                                                '${priceCategory[index]['brand2']}',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              '${priceCategory[index]['pricecategory1']}',
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              color: Colors.white,
                                              height: size.height * 0.045,
                                              width: size.width * 0.15,
                                              child: StatefulBuilder(
                                                builder: (context, setState) {
                                                  // เก็บค่าเริ่มต้น
                                                  int originalValue = int.parse(priceCategory[index]['sumgas1.1'] ?? '0');

                                                  // ย้าย controller และ textColor ออกมาเพื่อให้คงค่าไว้
                                                  final TextEditingController controller = TextEditingController(
                                                    text: NumberFormat('#,##0', 'en_US').format(originalValue),
                                                  );
                                                  Color textColor = Colors.black;

                                                  return StatefulBuilder(
                                                    builder: (context, setInnerState) {
                                                      return TextField(
                                                        controller: controller,
                                                        keyboardType: TextInputType.number,
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(fontSize: 20, color: textColor),
                                                        onChanged: (value) {
                                                          // อัปเดตสีข้อความตามค่าใหม่เมื่อเปลี่ยนข้อความ
                                                          int? newValue = int.tryParse(value.replaceAll(',', ''));
                                                          if (newValue != null) {
                                                            setInnerState(() {
                                                              if (newValue > originalValue) {
                                                                textColor = Colors.green; // สีแดงถ้าค่าเพิ่มขึ้น
                                                              } else if (newValue < originalValue) {
                                                                textColor = Colors.red; // สีเขียวถ้าค่าลดลง
                                                              } else {
                                                                textColor = Colors.black; // สีปกติถ้าค่าเท่ากัน
                                                              }
                                                            });
                                                          }
                                                        },
                                                        onSubmitted: (value) {
                                                          // อัปเดตค่าล่าสุดกลับไปที่ data และตรวจสอบสีอีกครั้ง
                                                          int? newValue = int.tryParse(value.replaceAll(',', ''));
                                                          if (newValue != null) {
                                                            setInnerState(() {
                                                              if (newValue > originalValue) {
                                                                textColor = Colors.green;
                                                              } else if (newValue < originalValue) {
                                                                textColor = Colors.red;
                                                              } else {
                                                                textColor = Colors.black;
                                                              }
                                                              // บันทึกค่าใหม่กลับไปที่ originalValue
                                                              originalValue = newValue;
                                                              setState(() {
                                                                priceCategory[index]['sumgas1.1'] = newValue.toString();
                                                              });
                                                            });
                                                          }
                                                        },
                                                        decoration: InputDecoration(
                                                          border: OutlineInputBorder(),
                                                          contentPadding: EdgeInsets.symmetric(vertical: 5),
                                                        ),
                                                      );
                                                    },
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: size.width * 0.1,
                                          ),
                                          // Expanded(
                                          //   flex: 1,
                                          //   child: Container(
                                          //     color: Colors.white,
                                          //     height: size.height * 0.045,
                                          //     width: size.width * 0.15,
                                          //     child: TextField(
                                          //       controller: TextEditingController(
                                          //         text: NumberFormat('#,##0', 'en_US').format(int.parse(priceCategory[index]['sumgas2.1'] ?? '0')),
                                          //       ),
                                          //       keyboardType: TextInputType.number,
                                          //       textAlign: TextAlign.center,
                                          //       style: TextStyle(fontSize: 20),
                                          //       onSubmitted: (value) {
                                          //         setState(
                                          //           () {
                                          //             // อัปเดตค่าจาก TextField
                                          //             int? newValue = int.tryParse(value.replaceAll(',', ''));
                                          //             if (newValue != null) {
                                          //               priceCategory[index]['sumgas2.1'] = newValue.toString();
                                          //             }
                                          //           },
                                          //         );
                                          //       },
                                          //       decoration: InputDecoration(
                                          //         border: OutlineInputBorder(),
                                          //         contentPadding: EdgeInsets.symmetric(vertical: 5),
                                          //       ),
                                          //     ),
                                          //   ),
                                          // ),
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              color: Colors.white,
                                              height: size.height * 0.045,
                                              width: size.width * 0.15,
                                              child: StatefulBuilder(
                                                builder: (context, setState) {
                                                  // เก็บค่าเริ่มต้น
                                                  int originalValue = int.parse(priceCategory[index]['sumgas2.1'] ?? '0');

                                                  // ย้าย controller และ textColor ออกมาเพื่อให้คงค่าไว้
                                                  final TextEditingController controller = TextEditingController(
                                                    text: NumberFormat('#,##0', 'en_US').format(originalValue),
                                                  );
                                                  Color textColor = Colors.black;

                                                  return StatefulBuilder(
                                                    builder: (context, setInnerState) {
                                                      return TextField(
                                                        controller: controller,
                                                        keyboardType: TextInputType.number,
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(fontSize: 20, color: textColor),
                                                        onChanged: (value) {
                                                          // อัปเดตสีข้อความตามค่าใหม่เมื่อเปลี่ยนข้อความ
                                                          int? newValue = int.tryParse(value.replaceAll(',', ''));
                                                          if (newValue != null) {
                                                            setInnerState(() {
                                                              if (newValue > originalValue) {
                                                                textColor = Colors.green; // สีแดงถ้าค่าเพิ่มขึ้น
                                                              } else if (newValue < originalValue) {
                                                                textColor = Colors.red; // สีเขียวถ้าค่าลดลง
                                                              } else {
                                                                textColor = Colors.black; // สีปกติถ้าค่าเท่ากัน
                                                              }
                                                            });
                                                          }
                                                        },
                                                        onSubmitted: (value) {
                                                          // อัปเดตค่าล่าสุดกลับไปที่ data และตรวจสอบสีอีกครั้ง
                                                          int? newValue = int.tryParse(value.replaceAll(',', ''));
                                                          if (newValue != null) {
                                                            setInnerState(() {
                                                              if (newValue > originalValue) {
                                                                textColor = Colors.green;
                                                              } else if (newValue < originalValue) {
                                                                textColor = Colors.red;
                                                              } else {
                                                                textColor = Colors.black;
                                                              }
                                                              // บันทึกค่าใหม่กลับไปที่ originalValue
                                                              originalValue = newValue;
                                                              setState(() {
                                                                priceCategory[index]['sumgas2.1'] = newValue.toString();
                                                              });
                                                            });
                                                          }
                                                        },
                                                        decoration: InputDecoration(
                                                          border: OutlineInputBorder(),
                                                          contentPadding: EdgeInsets.symmetric(vertical: 5),
                                                        ),
                                                      );
                                                    },
                                                  );
                                                },
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
                                              '${priceCategory[index]['pricecategory2']}',
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ),
                                          // Expanded(
                                          //   flex: 1,
                                          //   child: Container(
                                          //     color: Colors.white,
                                          //     height: size.height * 0.045,
                                          //     width: size.width * 0.15,
                                          //     child: TextField(
                                          //       controller: TextEditingController(
                                          //         text: NumberFormat('#,##0', 'en_US').format(int.parse(priceCategory[index]['sumgas1.2'] ?? '0')),
                                          //       ),
                                          //       keyboardType: TextInputType.number,
                                          //       textAlign: TextAlign.center,
                                          //       style: TextStyle(fontSize: 20),
                                          //       onSubmitted: (value) {
                                          //         setState(
                                          //           () {
                                          //             // อัปเดตค่าจาก TextField
                                          //             int? newValue = int.tryParse(value.replaceAll(',', ''));
                                          //             if (newValue != null) {
                                          //               priceCategory[index]['sumgas1.2'] = newValue.toString();
                                          //             }
                                          //           },
                                          //         );
                                          //       },
                                          //       decoration: InputDecoration(
                                          //         border: OutlineInputBorder(),
                                          //         contentPadding: EdgeInsets.symmetric(vertical: 5),
                                          //       ),
                                          //     ),
                                          //   ),
                                          // ),
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              color: Colors.white,
                                              height: size.height * 0.045,
                                              width: size.width * 0.15,
                                              child: StatefulBuilder(
                                                builder: (context, setState) {
                                                  // เก็บค่าเริ่มต้น
                                                  int originalValue = int.parse(priceCategory[index]['sumgas1.2'] ?? '0');

                                                  // ย้าย controller และ textColor ออกมาเพื่อให้คงค่าไว้
                                                  final TextEditingController controller = TextEditingController(
                                                    text: NumberFormat('#,##0', 'en_US').format(originalValue),
                                                  );
                                                  Color textColor = Colors.black;

                                                  return StatefulBuilder(
                                                    builder: (context, setInnerState) {
                                                      return TextField(
                                                        controller: controller,
                                                        keyboardType: TextInputType.number,
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(fontSize: 20, color: textColor),
                                                        onChanged: (value) {
                                                          // อัปเดตสีข้อความตามค่าใหม่เมื่อเปลี่ยนข้อความ
                                                          int? newValue = int.tryParse(value.replaceAll(',', ''));
                                                          if (newValue != null) {
                                                            setInnerState(() {
                                                              if (newValue > originalValue) {
                                                                textColor = Colors.green; // สีแดงถ้าค่าเพิ่มขึ้น
                                                              } else if (newValue < originalValue) {
                                                                textColor = Colors.red; // สีเขียวถ้าค่าลดลง
                                                              } else {
                                                                textColor = Colors.black; // สีปกติถ้าค่าเท่ากัน
                                                              }
                                                            });
                                                          }
                                                        },
                                                        onSubmitted: (value) {
                                                          // อัปเดตค่าล่าสุดกลับไปที่ data และตรวจสอบสีอีกครั้ง
                                                          int? newValue = int.tryParse(value.replaceAll(',', ''));
                                                          if (newValue != null) {
                                                            setInnerState(() {
                                                              if (newValue > originalValue) {
                                                                textColor = Colors.green;
                                                              } else if (newValue < originalValue) {
                                                                textColor = Colors.red;
                                                              } else {
                                                                textColor = Colors.black;
                                                              }
                                                              // บันทึกค่าใหม่กลับไปที่ originalValue
                                                              originalValue = newValue;
                                                              setState(() {
                                                                priceCategory[index]['sumgas1.2'] = newValue.toString();
                                                              });
                                                            });
                                                          }
                                                        },
                                                        decoration: InputDecoration(
                                                          border: OutlineInputBorder(),
                                                          contentPadding: EdgeInsets.symmetric(vertical: 5),
                                                        ),
                                                      );
                                                    },
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: size.width * 0.1,
                                          ),
                                          // Expanded(
                                          //   flex: 1,
                                          //   child: Container(
                                          //     color: Colors.white,
                                          //     height: size.height * 0.045,
                                          //     width: size.width * 0.15,
                                          //     child: TextField(
                                          //       controller: TextEditingController(
                                          //         text: NumberFormat('#,##0', 'en_US').format(int.parse(priceCategory[index]['sumgas2.2'] ?? '0')),
                                          //       ),
                                          //       keyboardType: TextInputType.number,
                                          //       textAlign: TextAlign.center,
                                          //       style: TextStyle(fontSize: 20),
                                          //       onSubmitted: (value) {
                                          //         setState(
                                          //           () {
                                          //             // อัปเดตค่าจาก TextField
                                          //             int? newValue = int.tryParse(value.replaceAll(',', ''));
                                          //             if (newValue != null) {
                                          //               priceCategory[index]['sumgas2.2'] = newValue.toString();
                                          //             }
                                          //           },
                                          //         );
                                          //       },
                                          //       decoration: InputDecoration(
                                          //         border: OutlineInputBorder(),
                                          //         contentPadding: EdgeInsets.symmetric(vertical: 5),
                                          //       ),
                                          //     ),
                                          //   ),
                                          // ),
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              color: Colors.white,
                                              height: size.height * 0.045,
                                              width: size.width * 0.15,
                                              child: StatefulBuilder(
                                                builder: (context, setState) {
                                                  // เก็บค่าเริ่มต้น
                                                  int originalValue = int.parse(priceCategory[index]['sumgas2.2'] ?? '0');

                                                  // ย้าย controller และ textColor ออกมาเพื่อให้คงค่าไว้
                                                  final TextEditingController controller = TextEditingController(
                                                    text: NumberFormat('#,##0', 'en_US').format(originalValue),
                                                  );
                                                  Color textColor = Colors.black;

                                                  return StatefulBuilder(
                                                    builder: (context, setInnerState) {
                                                      return TextField(
                                                        controller: controller,
                                                        keyboardType: TextInputType.number,
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(fontSize: 20, color: textColor),
                                                        onChanged: (value) {
                                                          // อัปเดตสีข้อความตามค่าใหม่เมื่อเปลี่ยนข้อความ
                                                          int? newValue = int.tryParse(value.replaceAll(',', ''));
                                                          if (newValue != null) {
                                                            setInnerState(() {
                                                              if (newValue > originalValue) {
                                                                textColor = Colors.green; // สีแดงถ้าค่าเพิ่มขึ้น
                                                              } else if (newValue < originalValue) {
                                                                textColor = Colors.red; // สีเขียวถ้าค่าลดลง
                                                              } else {
                                                                textColor = Colors.black; // สีปกติถ้าค่าเท่ากัน
                                                              }
                                                            });
                                                          }
                                                        },
                                                        onSubmitted: (value) {
                                                          // อัปเดตค่าล่าสุดกลับไปที่ data และตรวจสอบสีอีกครั้ง
                                                          int? newValue = int.tryParse(value.replaceAll(',', ''));
                                                          if (newValue != null) {
                                                            setInnerState(() {
                                                              if (newValue > originalValue) {
                                                                textColor = Colors.green;
                                                              } else if (newValue < originalValue) {
                                                                textColor = Colors.red;
                                                              } else {
                                                                textColor = Colors.black;
                                                              }
                                                              // บันทึกค่าใหม่กลับไปที่ originalValue
                                                              originalValue = newValue;
                                                              setState(() {
                                                                priceCategory[index]['sumgas2.2'] = newValue.toString();
                                                              });
                                                            });
                                                          }
                                                        },
                                                        decoration: InputDecoration(
                                                          border: OutlineInputBorder(),
                                                          contentPadding: EdgeInsets.symmetric(vertical: 5),
                                                        ),
                                                      );
                                                    },
                                                  );
                                                },
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
                                              '${priceCategory[index]['pricecategory3']}',
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ),
                                          // Expanded(
                                          //   flex: 1,
                                          //   child: Container(
                                          //     color: Colors.white,
                                          //     height: size.height * 0.045,
                                          //     width: size.width * 0.15,
                                          //     child: TextField(
                                          //       controller: TextEditingController(
                                          //         text: NumberFormat('#,##0', 'en_US').format(int.parse(priceCategory[index]['sumgas1.3'] ?? '0')),
                                          //       ),
                                          //       keyboardType: TextInputType.number,
                                          //       textAlign: TextAlign.center,
                                          //       style: TextStyle(fontSize: 20),
                                          //       onSubmitted: (value) {
                                          //         setState(
                                          //           () {
                                          //             // อัปเดตค่าจาก TextField
                                          //             int? newValue = int.tryParse(value.replaceAll(',', ''));
                                          //             if (newValue != null) {
                                          //               priceCategory[index]['sumgas1.3'] = newValue.toString();
                                          //             }
                                          //           },
                                          //         );
                                          //       },
                                          //       decoration: InputDecoration(
                                          //         border: OutlineInputBorder(),
                                          //         contentPadding: EdgeInsets.symmetric(vertical: 5),
                                          //       ),
                                          //     ),
                                          //   ),
                                          // ),
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              color: Colors.white,
                                              height: size.height * 0.045,
                                              width: size.width * 0.15,
                                              child: StatefulBuilder(
                                                builder: (context, setState) {
                                                  // เก็บค่าเริ่มต้น
                                                  int originalValue = int.parse(priceCategory[index]['sumgas1.3'] ?? '0');

                                                  // ย้าย controller และ textColor ออกมาเพื่อให้คงค่าไว้
                                                  final TextEditingController controller = TextEditingController(
                                                    text: NumberFormat('#,##0', 'en_US').format(originalValue),
                                                  );
                                                  Color textColor = Colors.black;

                                                  return StatefulBuilder(
                                                    builder: (context, setInnerState) {
                                                      return TextField(
                                                        controller: controller,
                                                        keyboardType: TextInputType.number,
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(fontSize: 20, color: textColor),
                                                        onChanged: (value) {
                                                          // อัปเดตสีข้อความตามค่าใหม่เมื่อเปลี่ยนข้อความ
                                                          int? newValue = int.tryParse(value.replaceAll(',', ''));
                                                          if (newValue != null) {
                                                            setInnerState(() {
                                                              if (newValue > originalValue) {
                                                                textColor = Colors.green; // สีแดงถ้าค่าเพิ่มขึ้น
                                                              } else if (newValue < originalValue) {
                                                                textColor = Colors.red; // สีเขียวถ้าค่าลดลง
                                                              } else {
                                                                textColor = Colors.black; // สีปกติถ้าค่าเท่ากัน
                                                              }
                                                            });
                                                          }
                                                        },
                                                        onSubmitted: (value) {
                                                          // อัปเดตค่าล่าสุดกลับไปที่ data และตรวจสอบสีอีกครั้ง
                                                          int? newValue = int.tryParse(value.replaceAll(',', ''));
                                                          if (newValue != null) {
                                                            setInnerState(() {
                                                              if (newValue > originalValue) {
                                                                textColor = Colors.green;
                                                              } else if (newValue < originalValue) {
                                                                textColor = Colors.red;
                                                              } else {
                                                                textColor = Colors.black;
                                                              }
                                                              // บันทึกค่าใหม่กลับไปที่ originalValue
                                                              originalValue = newValue;
                                                              setState(() {
                                                                priceCategory[index]['sumgas1.3'] = newValue.toString();
                                                              });
                                                            });
                                                          }
                                                        },
                                                        decoration: InputDecoration(
                                                          border: OutlineInputBorder(),
                                                          contentPadding: EdgeInsets.symmetric(vertical: 5),
                                                        ),
                                                      );
                                                    },
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: size.width * 0.1,
                                          ),

                                          // Expanded(
                                          //   flex: 1,
                                          //   child: Container(
                                          //     color: Colors.white,
                                          //     height: size.height * 0.045,
                                          //     width: size.width * 0.15,
                                          //     child: TextField(
                                          //       controller: TextEditingController(
                                          //         text: NumberFormat('#,##0', 'en_US').format(int.parse(priceCategory[index]['sumgas2.3'] ?? '0')),
                                          //       ),
                                          //       keyboardType: TextInputType.number,
                                          //       textAlign: TextAlign.center,
                                          //       style: TextStyle(fontSize: 20),
                                          //       onSubmitted: (value) {
                                          //         setState(
                                          //           () {
                                          //             // อัปเดตค่าจาก TextField
                                          //             int? newValue = int.tryParse(value.replaceAll(',', ''));
                                          //             if (newValue != null) {
                                          //               priceCategory[index]['sumgas2.3'] = newValue.toString();
                                          //             }
                                          //           },
                                          //         );
                                          //       },
                                          //       decoration: InputDecoration(
                                          //         border: OutlineInputBorder(),
                                          //         contentPadding: EdgeInsets.symmetric(vertical: 5),
                                          //       ),
                                          //     ),
                                          //   ),
                                          // ),
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              color: Colors.white,
                                              height: size.height * 0.045,
                                              width: size.width * 0.15,
                                              child: StatefulBuilder(
                                                builder: (context, setState) {
                                                  // เก็บค่าเริ่มต้น
                                                  int originalValue = int.parse(priceCategory[index]['sumgas2.3'] ?? '0');

                                                  // ย้าย controller และ textColor ออกมาเพื่อให้คงค่าไว้
                                                  final TextEditingController controller = TextEditingController(
                                                    text: NumberFormat('#,##0', 'en_US').format(originalValue),
                                                  );
                                                  Color textColor = Colors.black;

                                                  return StatefulBuilder(
                                                    builder: (context, setInnerState) {
                                                      return TextField(
                                                        controller: controller,
                                                        keyboardType: TextInputType.number,
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(fontSize: 20, color: textColor),
                                                        onChanged: (value) {
                                                          // อัปเดตสีข้อความตามค่าใหม่เมื่อเปลี่ยนข้อความ
                                                          int? newValue = int.tryParse(value.replaceAll(',', ''));
                                                          if (newValue != null) {
                                                            setInnerState(() {
                                                              if (newValue > originalValue) {
                                                                textColor = Colors.green; // สีแดงถ้าค่าเพิ่มขึ้น
                                                              } else if (newValue < originalValue) {
                                                                textColor = Colors.red; // สีเขียวถ้าค่าลดลง
                                                              } else {
                                                                textColor = Colors.black; // สีปกติถ้าค่าเท่ากัน
                                                              }
                                                            });
                                                          }
                                                        },
                                                        onSubmitted: (value) {
                                                          // อัปเดตค่าล่าสุดกลับไปที่ data และตรวจสอบสีอีกครั้ง
                                                          int? newValue = int.tryParse(value.replaceAll(',', ''));
                                                          if (newValue != null) {
                                                            setInnerState(() {
                                                              if (newValue > originalValue) {
                                                                textColor = Colors.green;
                                                              } else if (newValue < originalValue) {
                                                                textColor = Colors.red;
                                                              } else {
                                                                textColor = Colors.black;
                                                              }
                                                              // บันทึกค่าใหม่กลับไปที่ originalValue
                                                              originalValue = newValue;
                                                              setState(() {
                                                                priceCategory[index]['sumgas2.3'] = newValue.toString();
                                                              });
                                                            });
                                                          }
                                                        },
                                                        decoration: InputDecoration(
                                                          border: OutlineInputBorder(),
                                                          contentPadding: EdgeInsets.symmetric(vertical: 5),
                                                        ),
                                                      );
                                                    },
                                                  );
                                                },
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
                                              '${priceCategory[index]['pricecategory4']}',
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              color: Colors.white,
                                              height: size.height * 0.045,
                                              width: size.width * 0.15,
                                              child: StatefulBuilder(
                                                builder: (context, setState) {
                                                  // เก็บค่าเริ่มต้น
                                                  int originalValue = int.parse(priceCategory[index]['sumgas1.4'] ?? '0');

                                                  // ย้าย controller และ textColor ออกมาเพื่อให้คงค่าไว้
                                                  final TextEditingController controller = TextEditingController(
                                                    text: NumberFormat('#,##0', 'en_US').format(originalValue),
                                                  );
                                                  Color textColor = Colors.black;

                                                  return StatefulBuilder(
                                                    builder: (context, setInnerState) {
                                                      return TextField(
                                                        controller: controller,
                                                        keyboardType: TextInputType.number,
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(fontSize: 20, color: textColor),
                                                        onChanged: (value) {
                                                          // อัปเดตสีข้อความตามค่าใหม่เมื่อเปลี่ยนข้อความ
                                                          int? newValue = int.tryParse(value.replaceAll(',', ''));
                                                          if (newValue != null) {
                                                            setInnerState(() {
                                                              if (newValue > originalValue) {
                                                                textColor = Colors.green; // สีแดงถ้าค่าเพิ่มขึ้น
                                                              } else if (newValue < originalValue) {
                                                                textColor = Colors.red; // สีเขียวถ้าค่าลดลง
                                                              } else {
                                                                textColor = Colors.black; // สีปกติถ้าค่าเท่ากัน
                                                              }
                                                            });
                                                          }
                                                        },
                                                        onSubmitted: (value) {
                                                          // อัปเดตค่าล่าสุดกลับไปที่ data และตรวจสอบสีอีกครั้ง
                                                          int? newValue = int.tryParse(value.replaceAll(',', ''));
                                                          if (newValue != null) {
                                                            setInnerState(() {
                                                              if (newValue > originalValue) {
                                                                textColor = Colors.green;
                                                              } else if (newValue < originalValue) {
                                                                textColor = Colors.red;
                                                              } else {
                                                                textColor = Colors.black;
                                                              }
                                                              // บันทึกค่าใหม่กลับไปที่ originalValue
                                                              originalValue = newValue;
                                                              setState(() {
                                                                priceCategory[index]['sumgas1.4'] = newValue.toString();
                                                              });
                                                            });
                                                          }
                                                        },
                                                        decoration: InputDecoration(
                                                          border: OutlineInputBorder(),
                                                          contentPadding: EdgeInsets.symmetric(vertical: 5),
                                                        ),
                                                      );
                                                    },
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: size.width * 0.1,
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              color: Colors.white,
                                              height: size.height * 0.045,
                                              width: size.width * 0.15,
                                              child: StatefulBuilder(
                                                builder: (context, setState) {
                                                  // เก็บค่าเริ่มต้น
                                                  int originalValue = int.parse(priceCategory[index]['sumgas2.4'] ?? '0');

                                                  // ย้าย controller และ textColor ออกมาเพื่อให้คงค่าไว้
                                                  final TextEditingController controller = TextEditingController(
                                                    text: NumberFormat('#,##0', 'en_US').format(originalValue),
                                                  );
                                                  Color textColor = Colors.black;

                                                  return StatefulBuilder(
                                                    builder: (context, setInnerState) {
                                                      return TextField(
                                                        controller: controller,
                                                        keyboardType: TextInputType.number,
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(fontSize: 20, color: textColor),
                                                        onChanged: (value) {
                                                          // อัปเดตสีข้อความตามค่าใหม่เมื่อเปลี่ยนข้อความ
                                                          int? newValue = int.tryParse(value.replaceAll(',', ''));
                                                          if (newValue != null) {
                                                            setInnerState(() {
                                                              if (newValue > originalValue) {
                                                                textColor = Colors.green; // สีแดงถ้าค่าเพิ่มขึ้น
                                                              } else if (newValue < originalValue) {
                                                                textColor = Colors.red; // สีเขียวถ้าค่าลดลง
                                                              } else {
                                                                textColor = Colors.black; // สีปกติถ้าค่าเท่ากัน
                                                              }
                                                            });
                                                          }
                                                        },
                                                        onSubmitted: (value) {
                                                          // อัปเดตค่าล่าสุดกลับไปที่ data และตรวจสอบสีอีกครั้ง
                                                          int? newValue = int.tryParse(value.replaceAll(',', ''));
                                                          if (newValue != null) {
                                                            setInnerState(() {
                                                              if (newValue > originalValue) {
                                                                textColor = Colors.green;
                                                              } else if (newValue < originalValue) {
                                                                textColor = Colors.red;
                                                              } else {
                                                                textColor = Colors.black;
                                                              }
                                                              // บันทึกค่าใหม่กลับไปที่ originalValue
                                                              originalValue = newValue;
                                                              setState(() {
                                                                priceCategory[index]['sumgas2.4'] = newValue.toString();
                                                              });
                                                            });
                                                          }
                                                        },
                                                        decoration: InputDecoration(
                                                          border: OutlineInputBorder(),
                                                          contentPadding: EdgeInsets.symmetric(vertical: 5),
                                                        ),
                                                      );
                                                    },
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              '${priceCategory[index]['km']}',
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
                                                '${priceCategory[index]['gas']}',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              '${priceCategory[index]['pricecategory1']}',
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              color: Colors.white,
                                              height: size.height * 0.045,
                                              width: size.width * 0.15,
                                              child: StatefulBuilder(
                                                builder: (context, setState) {
                                                  // เก็บค่าเริ่มต้น
                                                  int originalValue = int.parse(priceCategory[index]['sumgas1.1'] ?? '0');

                                                  // ย้าย controller และ textColor ออกมาเพื่อให้คงค่าไว้
                                                  final TextEditingController controller = TextEditingController(
                                                    text: NumberFormat('#,##0', 'en_US').format(originalValue),
                                                  );
                                                  Color textColor = Colors.black;

                                                  return StatefulBuilder(
                                                    builder: (context, setInnerState) {
                                                      return TextField(
                                                        controller: controller,
                                                        keyboardType: TextInputType.number,
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(fontSize: 20, color: textColor),
                                                        onChanged: (value) {
                                                          // อัปเดตสีข้อความตามค่าใหม่เมื่อเปลี่ยนข้อความ
                                                          int? newValue = int.tryParse(value.replaceAll(',', ''));
                                                          if (newValue != null) {
                                                            setInnerState(() {
                                                              if (newValue > originalValue) {
                                                                textColor = Colors.green; // สีแดงถ้าค่าเพิ่มขึ้น
                                                              } else if (newValue < originalValue) {
                                                                textColor = Colors.red; // สีเขียวถ้าค่าลดลง
                                                              } else {
                                                                textColor = Colors.black; // สีปกติถ้าค่าเท่ากัน
                                                              }
                                                            });
                                                          }
                                                        },
                                                        onSubmitted: (value) {
                                                          // อัปเดตค่าล่าสุดกลับไปที่ data และตรวจสอบสีอีกครั้ง
                                                          int? newValue = int.tryParse(value.replaceAll(',', ''));
                                                          if (newValue != null) {
                                                            setInnerState(() {
                                                              if (newValue > originalValue) {
                                                                textColor = Colors.green;
                                                              } else if (newValue < originalValue) {
                                                                textColor = Colors.red;
                                                              } else {
                                                                textColor = Colors.black;
                                                              }
                                                              // บันทึกค่าใหม่กลับไปที่ originalValue
                                                              originalValue = newValue;
                                                              setState(() {
                                                                priceCategory[index]['sumgas1.1'] = newValue.toString();
                                                              });
                                                            });
                                                          }
                                                        },
                                                        decoration: InputDecoration(
                                                          border: OutlineInputBorder(),
                                                          contentPadding: EdgeInsets.symmetric(vertical: 5),
                                                        ),
                                                      );
                                                    },
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: size.width * 0.1,
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
                                              '${priceCategory[index]['pricecategory2']}',
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              color: Colors.white,
                                              height: size.height * 0.045,
                                              width: size.width * 0.15,
                                              child: StatefulBuilder(
                                                builder: (context, setState) {
                                                  // เก็บค่าเริ่มต้น
                                                  int originalValue = int.parse(priceCategory[index]['sumgas1.2'] ?? '0');

                                                  // ย้าย controller และ textColor ออกมาเพื่อให้คงค่าไว้
                                                  final TextEditingController controller = TextEditingController(
                                                    text: NumberFormat('#,##0', 'en_US').format(originalValue),
                                                  );
                                                  Color textColor = Colors.black;

                                                  return StatefulBuilder(
                                                    builder: (context, setInnerState) {
                                                      return TextField(
                                                        controller: controller,
                                                        keyboardType: TextInputType.number,
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(fontSize: 20, color: textColor),
                                                        onChanged: (value) {
                                                          // อัปเดตสีข้อความตามค่าใหม่เมื่อเปลี่ยนข้อความ
                                                          int? newValue = int.tryParse(value.replaceAll(',', ''));
                                                          if (newValue != null) {
                                                            setInnerState(() {
                                                              if (newValue > originalValue) {
                                                                textColor = Colors.green; // สีแดงถ้าค่าเพิ่มขึ้น
                                                              } else if (newValue < originalValue) {
                                                                textColor = Colors.red; // สีเขียวถ้าค่าลดลง
                                                              } else {
                                                                textColor = Colors.black; // สีปกติถ้าค่าเท่ากัน
                                                              }
                                                            });
                                                          }
                                                        },
                                                        onSubmitted: (value) {
                                                          // อัปเดตค่าล่าสุดกลับไปที่ data และตรวจสอบสีอีกครั้ง
                                                          int? newValue = int.tryParse(value.replaceAll(',', ''));
                                                          if (newValue != null) {
                                                            setInnerState(() {
                                                              if (newValue > originalValue) {
                                                                textColor = Colors.green;
                                                              } else if (newValue < originalValue) {
                                                                textColor = Colors.red;
                                                              } else {
                                                                textColor = Colors.black;
                                                              }
                                                              // บันทึกค่าใหม่กลับไปที่ originalValue
                                                              originalValue = newValue;
                                                              setState(() {
                                                                priceCategory[index]['sumgas1.2'] = newValue.toString();
                                                              });
                                                            });
                                                          }
                                                        },
                                                        decoration: InputDecoration(
                                                          border: OutlineInputBorder(),
                                                          contentPadding: EdgeInsets.symmetric(vertical: 5),
                                                        ),
                                                      );
                                                    },
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: size.width * 0.1,
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
                                              '${priceCategory[index]['pricecategory3']}',
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              color: Colors.white,
                                              height: size.height * 0.045,
                                              width: size.width * 0.15,
                                              child: StatefulBuilder(
                                                builder: (context, setState) {
                                                  // เก็บค่าเริ่มต้น
                                                  int originalValue = int.parse(priceCategory[index]['sumgas1.3'] ?? '0');

                                                  // ย้าย controller และ textColor ออกมาเพื่อให้คงค่าไว้
                                                  final TextEditingController controller = TextEditingController(
                                                    text: NumberFormat('#,##0', 'en_US').format(originalValue),
                                                  );
                                                  Color textColor = Colors.black;

                                                  return StatefulBuilder(
                                                    builder: (context, setInnerState) {
                                                      return TextField(
                                                        controller: controller,
                                                        keyboardType: TextInputType.number,
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(fontSize: 20, color: textColor),
                                                        onChanged: (value) {
                                                          // อัปเดตสีข้อความตามค่าใหม่เมื่อเปลี่ยนข้อความ
                                                          int? newValue = int.tryParse(value.replaceAll(',', ''));
                                                          if (newValue != null) {
                                                            setInnerState(() {
                                                              if (newValue > originalValue) {
                                                                textColor = Colors.green; // สีแดงถ้าค่าเพิ่มขึ้น
                                                              } else if (newValue < originalValue) {
                                                                textColor = Colors.red; // สีเขียวถ้าค่าลดลง
                                                              } else {
                                                                textColor = Colors.black; // สีปกติถ้าค่าเท่ากัน
                                                              }
                                                            });
                                                          }
                                                        },
                                                        onSubmitted: (value) {
                                                          // อัปเดตค่าล่าสุดกลับไปที่ data และตรวจสอบสีอีกครั้ง
                                                          int? newValue = int.tryParse(value.replaceAll(',', ''));
                                                          if (newValue != null) {
                                                            setInnerState(() {
                                                              if (newValue > originalValue) {
                                                                textColor = Colors.green;
                                                              } else if (newValue < originalValue) {
                                                                textColor = Colors.red;
                                                              } else {
                                                                textColor = Colors.black;
                                                              }
                                                              // บันทึกค่าใหม่กลับไปที่ originalValue
                                                              originalValue = newValue;
                                                              setState(() {
                                                                priceCategory[index]['sumgas1.3'] = newValue.toString();
                                                              });
                                                            });
                                                          }
                                                        },
                                                        decoration: InputDecoration(
                                                          border: OutlineInputBorder(),
                                                          contentPadding: EdgeInsets.symmetric(vertical: 5),
                                                        ),
                                                      );
                                                    },
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: size.width * 0.1,
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
                                              '${priceCategory[index]['pricecategory4']}',
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              color: Colors.white,
                                              height: size.height * 0.045,
                                              width: size.width * 0.15,
                                              child: StatefulBuilder(
                                                builder: (context, setState) {
                                                  // เก็บค่าเริ่มต้น
                                                  int originalValue = int.parse(priceCategory[index]['sumgas1.4'] ?? '0');

                                                  // ย้าย controller และ textColor ออกมาเพื่อให้คงค่าไว้
                                                  final TextEditingController controller = TextEditingController(
                                                    text: NumberFormat('#,##0', 'en_US').format(originalValue),
                                                  );
                                                  Color textColor = Colors.black;

                                                  return StatefulBuilder(
                                                    builder: (context, setInnerState) {
                                                      return TextField(
                                                        controller: controller,
                                                        keyboardType: TextInputType.number,
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(fontSize: 20, color: textColor),
                                                        onChanged: (value) {
                                                          // อัปเดตสีข้อความตามค่าใหม่เมื่อเปลี่ยนข้อความ
                                                          int? newValue = int.tryParse(value.replaceAll(',', ''));
                                                          if (newValue != null) {
                                                            setInnerState(() {
                                                              if (newValue > originalValue) {
                                                                textColor = Colors.green; // สีแดงถ้าค่าเพิ่มขึ้น
                                                              } else if (newValue < originalValue) {
                                                                textColor = Colors.red; // สีเขียวถ้าค่าลดลง
                                                              } else {
                                                                textColor = Colors.black; // สีปกติถ้าค่าเท่ากัน
                                                              }
                                                            });
                                                          }
                                                        },
                                                        onSubmitted: (value) {
                                                          // อัปเดตค่าล่าสุดกลับไปที่ data และตรวจสอบสีอีกครั้ง
                                                          int? newValue = int.tryParse(value.replaceAll(',', ''));
                                                          if (newValue != null) {
                                                            setInnerState(() {
                                                              if (newValue > originalValue) {
                                                                textColor = Colors.green;
                                                              } else if (newValue < originalValue) {
                                                                textColor = Colors.red;
                                                              } else {
                                                                textColor = Colors.black;
                                                              }
                                                              // บันทึกค่าใหม่กลับไปที่ originalValue
                                                              originalValue = newValue;
                                                              setState(() {
                                                                priceCategory[index]['sumgas1.4'] = newValue.toString();
                                                              });
                                                            });
                                                          }
                                                        },
                                                        decoration: InputDecoration(
                                                          border: OutlineInputBorder(),
                                                          contentPadding: EdgeInsets.symmetric(vertical: 5),
                                                        ),
                                                      );
                                                    },
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: size.width * 0.1,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
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
                        description: 'คุณต้องการยกเลิกการแก้ไขราคาหรือไม่',
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
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
          ),
          Container(
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
                        description: 'ต้องการ Up Date ราคาสินค้าหรือไม่?',
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
                              builder: (context) => Confirmsetpice(
                                    productselect: widget.productselect,
                                  )),
                          (route) => false);
                    }
                  },
                  child: Text(
                    'ตกลง',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

List<Map<String, String>> price = [
  {
    'km': '4 กก',
    'brand1': 'ปตท',
    'sum1': '9',
    'brand2': 'ส.ว.ย',
    'sum2': '4',
    'unit': 'ถัง',
  },
  {
    'km': '7 กก',
    'brand1': 'ปตท',
    'sum1': '5',
    'brand2': 'ส.ว.ย',
    'sum2': '1',
    'unit': 'ถัง',
  },
  {
    'km': '15 กก',
    'brand1': 'ปตท',
    'sum1': '2',
    'brand2': 'ส.ว.ย',
    'sum2': '10',
    'unit': 'ถัง',
  },
  {
    'km': '48 กก',
    'brand1': 'ปตท',
    'sum1': '9',
    'brand2': 'ส.ว.ย',
    'sum2': '16',
    'unit': 'ถัง',
  },
];
List<Map<String, String>> producttype = [
  {
    'name': 'ถังใหม่',
  },
  {
    'name': 'น้ำแก็ส',
  },
];
List<Map<String, String>> priceCategory = [
  {
    'km': '4 กก',
    'pricecategory1': 'ราคารับหน้าร้าน',
    'pricecategory2': 'ราคารวมส่ง',
    'pricecategory3': 'ราคากรณีซื้อเยอะ',
    'pricecategory4': 'ราคารับฝากเติม',
    'brand1': 'ปตท',
    'brand2': 'ส.ว.ย',
    'sumgas1.1': '100',
    'sumgas1.2': '120',
    'sumgas1.3': '300',
    'sumgas1.4': '500',
    'sumgas2.1': '100',
    'sumgas2.2': '120',
    'sumgas2.3': '300',
    'sumgas2.4': '500',
    'gas': 'ราคาน้ำแก็ส',
  },
  {
    'km': '7 กก',
    'pricecategory1': 'ราคารับหน้าร้าน',
    'pricecategory2': 'ราคารวมส่ง',
    'pricecategory3': 'ราคากรณีซื้อเยอะ',
    'pricecategory4': 'ราคารับฝากเติม',
    'brand1': 'ปตท',
    'brand2': 'ส.ว.ย',
    'sumgas1.1': '100',
    'sumgas1.2': '120',
    'sumgas1.3': '300',
    'sumgas1.4': '500',
    'sumgas2.1': '180',
    'sumgas2.2': '1270',
    'sumgas2.3': '302',
    'sumgas2.4': '5005',
    'gas': 'ราคาน้ำแก็ส',
  },
  {
    'km': '15 กก',
    'pricecategory1': 'ราคารับหน้าร้าน',
    'pricecategory2': 'ราคารวมส่ง',
    'pricecategory3': 'ราคากรณีซื้อเยอะ',
    'pricecategory4': 'ราคารับฝากเติม',
    'brand1': 'ปตท',
    'brand2': 'ส.ว.ย',
    'sumgas1.1': '100',
    'sumgas1.2': '120',
    'sumgas1.3': '300',
    'sumgas1.4': '500',
    'sumgas2.1': '100',
    'sumgas2.2': '120',
    'sumgas2.3': '300',
    'sumgas2.4': '500',
    'gas': 'ราคาน้ำแก็ส',
  },
  {
    'km': '48 กก',
    'pricecategory1': 'ราคารับหน้าร้าน',
    'pricecategory2': 'ราคารวมส่ง',
    'pricecategory3': 'ราคากรณีซื้อเยอะ',
    'pricecategory4': 'ราคารับฝากเติม',
    'brand1': 'ปตท',
    'brand2': 'ส.ว.ย',
    'sumgas1.1': '100',
    'sumgas1.2': '120',
    'sumgas1.3': '300',
    'sumgas1.4': '500',
    'sumgas2.1': '100',
    'sumgas2.2': '120',
    'sumgas2.3': '300',
    'sumgas2.4': '500',
    'gas': 'ราคาน้ำแก็ส',
  },
];
List<Map<String, String>> priceConfirm = [
  {
    'km': '4 กก',
    'pricecategory1': 'ราคารับหน้าร้าน',
    'pricecategory3': 'ราคากรณีซื้อเยอะ',
    'pricecategory4': 'ราคารับฝากเติม',
    'brand1': 'ปตท',
    'gas': 'ราคาน้ำแก็ส',
    'brand2': 'ส.ว.ย',
    'sumgas1.3': '300',
    'sumgas1.4': '500',
    'sumgas2.1': '100',
    'sumgas2.2': '120',
  },
  {
    'km': '7 กก',
    'pricecategory1': 'ราคารับหน้าร้าน',
    'pricecategory3': 'ราคากรณีซื้อเยอะ',
    'pricecategory4': 'ราคารับฝากเติม',
    'brand1': 'ปตท',
    'gas': 'ราคาน้ำแก็ส',
    'brand2': 'ส.ว.ย',
    'sumgas1.3': '300',
    'sumgas1.4': '500',
    'sumgas2.1': '100',
    'sumgas2.2': '120',
  },
];
