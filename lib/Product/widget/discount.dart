import 'package:flutter/material.dart';
import 'package:stock_application_gas/widgets/Dialog.dart';

class DiscountPage extends StatefulWidget {
  const DiscountPage({super.key, this.discount, this.from, this.delete});
  final Function(String)? discount;
  final Function(String)? from;
  final Function(String)? delete;

  @override
  State<DiscountPage> createState() => _DiscountPageState();
}

class _DiscountPageState extends State<DiscountPage> {
  TextEditingController discount = TextEditingController();
  int? selectedIndex;
  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'ส่วนลด',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'IBMPlexSansThai',
                  fontSize: 25,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.close,
                ),
              )
            ],
          ),
          Divider(
            color: Colors.black,
            thickness: 1.5,
          ),
          Row(
            children: [
              Text(
                'การเลือกรูปแบบการลด',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF424242),
                  fontFamily: 'IBMPlexSansThai',
                ),
              ),
            ],
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                    onTap: () {
                      widget.from!('discount');
                      onItemTapped(0);
                    },
                    child: selectedIndex == 0
                        ? Container(
                            height: size.height * 0.065,
                            width: size.width * 0.42,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Color(0xFF1264E3)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Image.asset(
                                  'assets/icons/selectpoint.png',
                                  height: size.height * 0.025,
                                ),
                                Text(
                                  'จำนวนเงิน',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF424242),
                                    fontFamily: 'IBMPlexSansThai',
                                  ),
                                )
                              ],
                            ),
                          )
                        : Container(
                            height: size.height * 0.065,
                            width: size.width * 0.42,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Color(0xFF1264E3)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Image.asset(
                                  'assets/icons/unselectpoint.png',
                                  height: size.height * 0.025,
                                ),
                                Text(
                                  'จำนวนเงิน',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Color(0xFF424242),
                                    fontFamily: 'IBMPlexSansThai',
                                  ),
                                )
                              ],
                            ),
                          )),
                SizedBox(
                  width: 15,
                ),
                InkWell(
                    onTap: () {
                      widget.from!('discountPercen');
                      onItemTapped(1);
                    },
                    child: selectedIndex == 1
                        ? Container(
                            height: size.height * 0.065,
                            width: size.width * 0.42,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Color(0xFF1264E3)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Image.asset(
                                  'assets/icons/selectpoint.png',
                                  height: size.height * 0.025,
                                ),
                                Text(
                                  'เปอร์เซ็นต์ % ',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Color(0xFF424242),
                                    fontFamily: 'IBMPlexSansThai',
                                  ),
                                )
                              ],
                            ),
                          )
                        : Container(
                            height: size.height * 0.065,
                            width: size.width * 0.42,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Color(0xFF1264E3)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Image.asset(
                                  'assets/icons/unselectpoint.png',
                                  height: size.height * 0.025,
                                ),
                                Text(
                                  'เปอเซ็นต์ % ',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Color(0xFF424242),
                                    fontFamily: 'IBMPlexSansThai',
                                  ),
                                )
                              ],
                            ),
                          )),
              ],
            ),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          Container(
            width: size.width * 0.9,
            height: size.height * 0.08,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                Text(
                  selectedIndex == 0 ? "฿" : "%",
                  style: TextStyle(fontSize: 25),
                ),
                SizedBox(
                  width: size.width * 0.81,
                  child: TextFormField(
                    controller: discount,
                    textAlign: TextAlign.right,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    style: TextStyle(fontSize: 22),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                      hintText: '0.00',
                      hintStyle: TextStyle(fontSize: 22),
                      filled: true,
                      fillColor: Colors.transparent,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.transparent),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: size.height * 0.15,
          ),
          GestureDetector(
            onTap: () {
              if (discount.text != '' && discount.text.isNotEmpty && selectedIndex != null) {
                widget.discount!(discount.text);

                discount.clear();
                Navigator.pop(context);
              } else {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialogYes(
                    title: 'แจ้งเตือน',
                    description: 'กรุณากรอกจำนวนเงินหรือเลือกประเภทที่ต้องการลด',
                    pressYes: () {
                      Navigator.pop(context, true);
                    },
                  ),
                );
              }
            },
            child: Card(
              color: Colors.blue,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: SizedBox(
                width: size.width * 0.9,
                height: size.height * 0.06,
                child: Center(
                    child: Text(
                  'บันทึก',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'IBMPlexSansThai',
                  ),
                )),
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          GestureDetector(
            onTap: () {
              discount.clear();
            },
            child: Card(
              color: Colors.white,
              elevation: 5,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.red),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: SizedBox(
                width: size.width * 0.9,
                height: size.height * 0.06,
                child: Center(
                    child: Text(
                  'ล้างข้อมูล',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'IBMPlexSansThai',
                  ),
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
