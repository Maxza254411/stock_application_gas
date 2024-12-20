import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stock_application_gas/Models/nextpayment.dart';
import 'package:stock_application_gas/Models/order.dart';
import 'package:stock_application_gas/constants.dart';

class AlertDialogYes extends StatefulWidget {
  AlertDialogYes({Key? key, required this.description, this.pressYes, required this.title, InkWell? onTap}) : super(key: key);
  final String title, description;
  final VoidCallback? pressYes;

  @override
  State<AlertDialogYes> createState() => _AlertDialogYesState();
}

class _AlertDialogYesState extends State<AlertDialogYes> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AlertDialog(
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.grey, // ตรวจสอบว่ามีการกำหนดค่า kTextButtonColor แล้ว
      title: Center(
        child: Text(
          widget.title,
          style: TextStyle(
            fontSize: 20, // ปรับขนาดใหญ่ขึ้นเล็กน้อยเพื่อความเด่นชัด
            fontWeight: FontWeight.bold, // เพิ่มความหนาของตัวอักษรเพื่อความเด่นชัด
          ),
        ),
      ),
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0), // เพิ่ม padding ให้ข้อความไม่ชิดขอบ
        child: Text(
          widget.description,
          style: TextStyle(
            fontSize: 16, // ลดขนาดตัวอักษรลงเล็กน้อยเพื่อความสมดุล
          ),
          textAlign: TextAlign.center, // ตั้งค่าการจัดตำแหน่งข้อความให้อยู่ตรงกลาง
        ),
      ),
      actionsAlignment: MainAxisAlignment.center, // ปรับการจัดตำแหน่งของปุ่มให้อยู่กลาง
      actions: [
        GestureDetector(
          onTap: widget.pressYes,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.blue,
            ),
            height: size.height * 0.05,
            width: size.width * 0.3,
            child: Center(
              child: Text(
                'ตกลง',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class AlertDialogYesNo extends StatefulWidget {
  AlertDialogYesNo({Key? key, required this.description, this.pressYes, this.pressNo, required this.title, InkWell? onTap}) : super(key: key);
  final String title, description;
  final VoidCallback? pressYes;
  final VoidCallback? pressNo;

  @override
  State<AlertDialogYesNo> createState() => _AlertDialogYesNoState();
}

class _AlertDialogYesNoState extends State<AlertDialogYesNo> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AlertDialog(
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.grey, // ตรวจสอบว่ามีการกำหนดค่า kTextButtonColor แล้ว
      title: Center(
        child: Text(
          widget.title,
          style: TextStyle(
            fontSize: 20, // ปรับขนาดใหญ่ขึ้นเล็กน้อยเพื่อความเด่นชัด
            fontWeight: FontWeight.bold, // เพิ่มความหนาของตัวอักษรเพื่อความเด่นชัด
          ),
        ),
      ),
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0), // เพิ่ม padding ให้ข้อความไม่ชิดขอบ
        child: Text(
          widget.description,
          style: TextStyle(
            fontSize: 16, // ลดขนาดตัวอักษรลงเล็กน้อยเพื่อความสมดุล
          ),
          textAlign: TextAlign.center, // ตั้งค่าการจัดตำแหน่งข้อความให้อยู่ตรงกลาง
        ),
      ),
      // actionsAlignment: MainAxisAlignment.center, // ปรับการจัดตำแหน่งของปุ่มให้อยู่กลาง
      actions: [
        Row(
          children: [
            GestureDetector(
              onTap: widget.pressNo,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color.fromARGB(255, 227, 227, 227),
                ),
                height: size.height * 0.05,
                width: size.width * 0.3,
                child: Center(
                  child: Text(
                    'หน้าแรก',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 30,
            ),
            GestureDetector(
              onTap: widget.pressYes,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.blue,
                ),
                height: size.height * 0.05,
                width: size.width * 0.3,
                child: Center(
                  child: Text(
                    'พิมพ์ใบเสร็จ',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class AlertDialogSuccessNew extends StatefulWidget {
  AlertDialogSuccessNew({Key? key, required this.description, this.pressYes, this.pressNo, required this.title, required this.order, this.payment})
      : super(key: key);
  final String title, description;
  final VoidCallback? pressYes;
  final VoidCallback? pressNo;
  final Order order;
  NextPayment? payment;

  @override
  State<AlertDialogSuccessNew> createState() => _AlertDialogSuccessNewState();
}

class _AlertDialogSuccessNewState extends State<AlertDialogSuccessNew> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Dialog(
      child: Container(
        height: size.height * 0.7,
        width: size.width * 0.9,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/icons/CheckCircle.png',
              scale: 9,
            ),
            Text(
              'ชำระเงินสำเร็จ',
              style: TextStyle(color: ktextColr, fontSize: 30),
            ),
            Text(
              'ประเภท : ${widget.payment!.orderPayment!.paymentMethod!.name_2}',
              style: TextStyle(color: Color.fromARGB(206, 66, 66, 66), fontSize: 20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'ใบเสร็จ : ',
                  style: TextStyle(color: Color.fromARGB(206, 66, 66, 66), fontSize: 20),
                ),
                Text(
                  '${widget.order.orderNo}',
                  style: TextStyle(color: Color(0xFF1264E3), fontSize: 20),
                ),
              ],
            ),
            Divider(
              color: Color(0xFF78909C),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'จากยอดรวมทั้งหมด',
                  style: TextStyle(color: Color.fromARGB(206, 66, 66, 66), fontSize: 18),
                ),
                Text(
                  textAlign: TextAlign.end,
                  '${NumberFormat('#,##0.00', 'en_US').format(widget.order.grandTotal)} ฿',
                  style: TextStyle(color: ktextColr, fontSize: 25),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'ยอดชำระ',
                  style: TextStyle(color: Color.fromARGB(206, 66, 66, 66), fontSize: 18),
                ),
                Text(
                  textAlign: TextAlign.end,
                  '${NumberFormat('#,##0.00', 'en_US').format(widget.order.grandTotal)} ฿',
                  style: TextStyle(color: ktextColr, fontSize: 25),
                )
              ],
            ),
            Column(
              children: [
                InkWell(
                  onTap: widget.pressNo,
                  child: Container(
                    width: size.width * 0.8,
                    height: size.height * 0.065,
                    decoration: BoxDecoration(color: Color(0xFF1264E3), borderRadius: BorderRadius.circular(8)),
                    child: Center(
                      child: Text(
                        textAlign: TextAlign.center,
                        'เสร็จ',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: widget.pressYes,
                  child: Container(
                    width: size.width * 0.8,
                    height: size.height * 0.065,
                    decoration:
                        BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: Color(0xFF1264E3))),
                    child: Center(
                      child: Text(
                        textAlign: TextAlign.center,
                        'พิมใบเสร็จ',
                        style: TextStyle(color: Color(0xFF1264E3), fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AlertDialogYesNo2 extends StatefulWidget {
  AlertDialogYesNo2({
    Key? key,
    required this.description,
    required this.pressYes,
    required this.title,
    required this.pressNo,
    required this.orderNo,
  }) : super(key: key);
  final String title, description, orderNo;
  final VoidCallback pressYes;
  final VoidCallback pressNo;

  @override
  State<AlertDialogYesNo2> createState() => _AlertDialogYesNo2State();
}

class _AlertDialogYesNo2State extends State<AlertDialogYesNo2> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AlertDialog(
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(2))),
      backgroundColor: kTextButtonColor,
      title: Center(
        child: Text(
          widget.title,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold // ปรับขนาดใหญ่ขึ้นเล็กน้อยเพื่อความเด่นชัด
              ),
        ),
      ),
      content: widget.description != ""
          ? Wrap(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${widget.description} ',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            )
          : SizedBox.shrink(),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: GestureDetector(
                onTap: widget.pressNo,
                child: Card(
                  //color: Colors.blue,
                  surfaceTintColor: Colors.white,
                  elevation: 5,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0), side: BorderSide(color: kButtonColor)),

                  child: SizedBox(
                    width: size.width * 0.25,
                    height: size.height * 0.06,
                    child: Center(
                        child: Text(
                      'ยกเลิก',
                      style: TextStyle(color: kButtonColor, fontFamily: 'IBMPlexSansThai', fontSize: 16, fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: GestureDetector(
                onTap: widget.pressYes,
                child: Card(
                  color: Colors.blue,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: SizedBox(
                    width: size.width * 0.25,
                    height: size.height * 0.06,
                    child: Center(
                        child: Text(
                      'ตกลง',
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
            ),
          ],
        ),
      ],
    );
  }
}

class Opendialogremark2 extends StatefulWidget {
  Opendialogremark2({
    super.key,
    // required this.size,
    required this.initText,
    required this.pressOk,
    // required this.pressCancel,
    // required this.pressClose,
    // this.controllerRemark,
    // required this.pressclearData,
  });

  // final Size size;
  final Function(String remark) pressOk;
  // final VoidCallback pressCancel;
  // final VoidCallback pressClose;
  // final VoidCallback pressclearData;
  // TextEditingController? controllerRemark;
  final String initText;

  @override
  State<Opendialogremark2> createState() => _Opendialogremark2State();
}

class _Opendialogremark2State extends State<Opendialogremark2> {
  final TextEditingController controllerRemark = TextEditingController();
  // Global key for the form
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    controllerRemark.text = widget.initText;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AlertDialog(
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(2))),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('หมายเหตุ'),
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.close)),
        ],
      ),
      content: Form(
        key: _formKey, // Assign the form key
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Divider(),
              SizedBox(height: size.height * 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: size.width * 0.2,
                    child: Text(
                      "หมายเหตุ",
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                  Container(
                    color: Color.fromARGB(255, 241, 241, 241),
                    width: size.width * 0.48,
                    child: TextFormField(
                      style: TextStyle(fontSize: 22),
                      controller: controllerRemark,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 10),
                        hintText: 'ระบุหมายเหตุ**',
                        hintStyle: TextStyle(fontSize: 22),
                      ),
                      // Validator for empty input
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "กรุณากรอกข้อมูล"; // Return the error message
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _buildActionButton(
                icon: Icon(
                  Icons.replay_outlined,
                  color: Colors.white,
                ),
                text: 'เคลียข้อมูล',
                onTap: () {
                  setState(() {
                    controllerRemark.clear();
                  });
                },
                size: size,
                textColor: Colors.white,
                backgroundColor: Colors.red),
            SizedBox(width: 10),
            _buildActionButton(
              icon: Icon(
                Icons.close,
                color: Colors.red,
              ),
              text: 'ยกเลิก',
              onTap: () {
                Navigator.pop(context);
              },
              size: size,
              textColor: kButtonColor,
              backgroundColor: Colors.white,
            ),
            SizedBox(width: 10),
            _buildActionButton(
              icon: Icon(
                Icons.check,
                color: Colors.white,
              ),
              text: 'ตกลง',
              onTap: () {
                // Validate the form, if valid call pressOk
                if (_formKey.currentState?.validate() ?? false) {
                  widget.pressOk(controllerRemark.text);
                  Navigator.pop(context);
                }
              },
              size: size,
              backgroundColor: kButtonColor,
              textColor: Colors.white,
            ),
          ],
        ),
      ],
    );
  }

  // Helper method to build action buttons
  Widget _buildActionButton(
      {required String text,
      required VoidCallback onTap,
      required Size size,
      required Color textColor,
      required Color backgroundColor,
      required Widget icon}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: backgroundColor,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: SizedBox(
          width: size.width * 0.12,
          height: size.height * 0.06,
          child: Center(
            child: icon,
            // child: Text(
            //   text,
            //   style: TextStyle(color: textColor, fontSize: 16, fontWeight: FontWeight.bold),
            // ),
          ),
        ),
      ),
    );
  }
}

// Helper method to build the input row with validation
Widget _buildInputRow(String label, TextEditingController? controller, Size size, String errorMessage) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      SizedBox(
        width: size.width * 0.2,
        child: Text(
          label,
          style: TextStyle(fontSize: 16),
        ),
      ),
      Container(
        color: Color.fromARGB(255, 241, 241, 241),
        width: size.width * 0.35,
        child: TextFormField(
          style: TextStyle(fontSize: 22),
          controller: controller,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 10),
            hintText: 'ระบุหมายเหตุ**',
            hintStyle: TextStyle(fontSize: 22),
          ),
          // Validator for empty input
          validator: (value) {
            if (value == null || value.isEmpty) {
              return errorMessage; // Return the error message
            }
            return null;
          },
        ),
      ),
    ],
  );
}

class AlertDialogLockOut extends StatefulWidget {
  AlertDialogLockOut({Key? key, required this.description, this.pressYes, this.pressNo, required this.title, InkWell? onTap}) : super(key: key);
  final String title, description;
  final VoidCallback? pressYes;
  final VoidCallback? pressNo;

  @override
  State<AlertDialogLockOut> createState() => _AlertDialogLockOutState();
}

class _AlertDialogLockOutState extends State<AlertDialogLockOut> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AlertDialog(
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.grey, // ตรวจสอบว่ามีการกำหนดค่า kTextButtonColor แล้ว
      title: Center(
        child: Text(
          widget.title,
          style: TextStyle(
            fontSize: 20, // ปรับขนาดใหญ่ขึ้นเล็กน้อยเพื่อความเด่นชัด
            fontWeight: FontWeight.bold, // เพิ่มความหนาของตัวอักษรเพื่อความเด่นชัด
          ),
        ),
      ),
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0), // เพิ่ม padding ให้ข้อความไม่ชิดขอบ
        child: Text(
          widget.description,
          style: TextStyle(
            fontSize: 16, // ลดขนาดตัวอักษรลงเล็กน้อยเพื่อความสมดุล
          ),
          textAlign: TextAlign.center, // ตั้งค่าการจัดตำแหน่งข้อความให้อยู่ตรงกลาง
        ),
      ),
      // actionsAlignment: MainAxisAlignment.center, // ปรับการจัดตำแหน่งของปุ่มให้อยู่กลาง
      actions: [
        Row(
          children: [
            GestureDetector(
              onTap: widget.pressNo,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color.fromARGB(255, 227, 227, 227),
                ),
                height: size.height * 0.05,
                width: size.width * 0.3,
                child: Center(
                  child: Text(
                    'ยกเลิก',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 30,
            ),
            GestureDetector(
              onTap: widget.pressYes,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.blue,
                ),
                height: size.height * 0.05,
                width: size.width * 0.3,
                child: Center(
                  child: Text(
                    'ตกลง',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
