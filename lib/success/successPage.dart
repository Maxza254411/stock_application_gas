import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;
import 'package:image/image.dart' as img;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:stock_application_gas/Models/branch.dart';
import 'package:stock_application_gas/Models/nextpayment.dart';
import 'package:stock_application_gas/Models/order.dart';
import 'package:stock_application_gas/Models/profile.dart';
import 'package:stock_application_gas/Product/ProductPage.dart';
import 'package:stock_application_gas/Models/reservedatas.dart';
import 'package:stock_application_gas/fristpage.dart';
import 'package:stock_application_gas/order/OrderPage.dart';
import 'package:stock_application_gas/order/OrderService.dart';
import 'package:stock_application_gas/payment/service/paymentService.dart';
import 'package:stock_application_gas/print.dart';
import 'package:stock_application_gas/widgets/Dialog.dart';
import 'package:stock_application_gas/widgets/LoadingDialog.dart';

class SuccessPage extends StatefulWidget {
  SuccessPage({
    super.key,
    required this.page,
    required this.order,
    this.payment,
  });
  final Reservedatas order;
  final String page;
  NextPayment? payment;
  @override
  State<SuccessPage> createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  Timer? _timer;
  Profile? profile;
  Branch? branch;

  @override
  void initState() {
    super.initState();
    if (widget.page == "พร้อมเพย์") {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await _initialize();
      });

      Future.delayed(Duration(minutes: 10), () {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialogYes(
              title: 'หมดเวลาชำระเงิน',
              description: 'หากต้องการซื้อสินค้า โปรดทำรายการอีกครั้ง',
              pressYes: () {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: ((context) => ProductPage())), (route) => false);
              },
            );
          },
        );
      });
      // _timer = Timer.periodic(const Duration(seconds: 10), (timer) async {
      //   timer.cancel();
      //   var printqr = await showDialog(
      //     context: context,
      //     barrierDismissible: false,
      //     builder: (BuildContext context) {
      //       return AlertDialogYes(
      //         title: 'ชำระเงินสำเร็จ',
      //         description: 'กด ตกลง เพื่อกลับไปที่หน้าหลัก',
      //         pressYes: () {
      //           Navigator.pop(context, true);
      //         },
      //       );
      //     },
      //   );
      //   if (printqr == true) {
      //     Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: ((context) => OrderPage())), (route) => false);
      //   }
      // });
    }
    getprofileById();
  }

  getprofileById() async {
    final profile2 = await Paymentservice.getprofileById();
    final branch2 = await Paymentservice.getStore();
    setState(() {
      profile = profile2;
      branch = branch2;
    });
  }

  Future<void> _initialize() async {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) async {
      try {
        final orderPayment = await OrderService.getOrderPayment(id: widget.payment!.orderPayment!.id);
        if (orderPayment.status == 'success') {
          timer.cancel();
          final photo = await capturePngPag();
          // await Printing().printSummary(
          //   picture: photo!,
          // );
          if (!mounted) return;
          final out = await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialogYesNo(
                title: 'ชำระเงินสำเร็จ',
                description: 'กด หน้าแรก เพื่อกลับไปที่รายการอาหาร',
                pressNo: () {
                  Navigator.pop(context, false);
                },
                pressYes: () {
                  Navigator.pop(context, true);
                },
              );
            },
          );
          LoadingDialog.open(context);
          if (out == true) {
            if (!mounted) return;
            final photo2 = await capturePng();
            // await Printing().printSummary(
            //   picture: photo2!,
            // );
            if (!mounted) return;
            LoadingDialog.close(context);
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: ((context) => OrderPage())), (route) => false);
          } else {
            if (!mounted) return;
            LoadingDialog.close(context);
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: ((context) => OrderPage())), (route) => false);
          }
        }
      } on Exception catch (e) {
        if (!mounted) return;
        // LoadingDialog.close(context);
        timer.cancel();
        showDialog(
          context: context,
          builder: (context) => AlertDialogYes(
            title: 'แจ้งเตือน',
            description: '$e',
            pressYes: () {
              Navigator.pop(context);
            },
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  GlobalKey globalKey = GlobalKey();
  Uint8List? pngBytesPag;
  String? bs64;
  GlobalKey globalKey2 = GlobalKey();
  Uint8List? pngBytesPag2;
  String? bs642;

  // Future<Uint8List?> capturePngPag() async {
  //   try {
  //     // RenderRepaintBoundary boundary1 = globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
  //     // ui.Image image = await boundary1.toImage(pixelRatio: 1.75);
  //     // ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  //     // pngBytesPag = byteData!.buffer.asUint8List();
  //     // bs64 = base64Encode(pngBytesPag!);
  //     // setState(() {});
  //     // return pngBytesPag;
  //     RenderRepaintBoundary boundary1 = globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
  //     ui.Image image = await boundary1.toImage(pixelRatio: 1.75);
  //     ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  //     Uint8List pngBytesPag = byteData!.buffer.asUint8List();

  //     // Convert to grayscale using the image package
  //     img.Image originalImage = img.decodeImage(pngBytesPag)!;
  //     img.Image grayscaleImage = img.grayscale(originalImage);

  //     // Convert back to Uint8List
  //     Uint8List grayscaleBytes = Uint8List.fromList(img.encodePng(grayscaleImage));

  //     bs64 = base64Encode(grayscaleBytes);
  //     setState(() {});
  //     return grayscaleBytes;
  //   } catch (e) {}
  //   return null;
  // }

  // Future<Uint8List?> capturePng() async {
  //   try {
  //     // RenderRepaintBoundary boundary = globalKey2.currentContext!.findRenderObject() as RenderRepaintBoundary;
  //     // ui.Image image = await boundary.toImage(pixelRatio: 1.75);
  //     // ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  //     // pngBytesPag2 = byteData!.buffer.asUint8List();
  //     // bs642 = base64Encode(pngBytesPag2!);
  //     // setState(() {});
  //     // // return pngBytesPag2;
  //     RenderRepaintBoundary boundary = globalKey2.currentContext!.findRenderObject() as RenderRepaintBoundary;
  //     ui.Image image = await boundary.toImage(pixelRatio: 1.75);
  //     ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  //     Uint8List pngBytesPag2 = byteData!.buffer.asUint8List();

  //     // Convert to grayscale using the image package
  //     img.Image originalImage = img.decodeImage(pngBytesPag2)!;
  //     img.Image grayscaleImage = img.grayscale(originalImage);

  //     // Convert back to Uint8List
  //     Uint8List grayscaleBytes2 = Uint8List.fromList(img.encodePng(grayscaleImage));

  //     bs642 = base64Encode(grayscaleBytes2);
  //     setState(() {});
  //     return grayscaleBytes2;
  //   } catch (e) {}
  //   return null;
  // }

  Future<Uint8List?> capturePngPag() async {
    try {
      RenderRepaintBoundary boundary1 = globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary1.toImage(pixelRatio: 3);
      // สร้างภาพใหม่ที่มีพื้นหลังสีขาว
      final recorder = ui.PictureRecorder();
      final canvas = Canvas(recorder);
      // กำหนดขนาดของภาพ
      final paint = Paint();
      paint.color = Colors.white; // ตั้งค่าสีพื้นหลังเป็นสีขาว
      final size = Size(image.width.toDouble(), image.height.toDouble());
      // วาดพื้นหลังสีขาว
      canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
      // วาดภาพเดิมบนพื้นหลังสีขาว
      canvas.drawImage(image, Offset.zero, Paint());
      // สร้างภาพใหม่จาก Canvas
      final newImage = await recorder.endRecording().toImage(image.width, image.height);
      ByteData? byteData = await newImage.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();
      setState(() {});
      return pngBytes;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<Uint8List?> capturePng() async {
    try {
      RenderRepaintBoundary boundary = globalKey2.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3);
      // สร้างภาพใหม่ที่มีพื้นหลังสีขาว
      final recorder = ui.PictureRecorder();
      final canvas = Canvas(recorder);
      // กำหนดขนาดของภาพ
      final paint = Paint();
      paint.color = Colors.white; // ตั้งค่าสีพื้นหลังเป็นสีขาว
      final size = Size(image.width.toDouble(), image.height.toDouble());
      // วาดพื้นหลังสีขาว
      canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
      // วาดภาพเดิมบนพื้นหลังสีขาว
      canvas.drawImage(image, Offset.zero, Paint());
      // สร้างภาพใหม่จาก Canvas
      final newImage = await recorder.endRecording().toImage(image.width, image.height);
      ByteData? byteData = await newImage.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();
      setState(() {});
      return pngBytes;
    } catch (e) {
      print(e);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return PopScope(
      canPop: false,
      // onPopInvoked: (didPop) {
      //   print(didPop);
      //   // logic
      // },
      child: Scaffold(
          appBar: AppBar(
            title: Text('รายละเอียด'),
            centerTitle: true,
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back),
            ),
          ),
          body: SingleChildScrollView(
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Container(
                      width: double.infinity,
                      // height: size.height * 1,
                      color: Colors.white,
                      child: Column(
                        children: [
                          RepaintBoundary(
                            key: globalKey,
                            child: Column(
                              children: [
                                RepaintBoundary(
                                  key: globalKey2,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      widget.order.roomNo == '' || widget.order.roomNo == '0' || widget.order.roomNo == null
                                          ? SizedBox.shrink()
                                          : Center(
                                              child: Text(
                                                'บ้านเลขที่: ${widget.order.roomNo}',
                                                style: TextStyle(
                                                  fontSize: 25,
                                                ),
                                              ),
                                            ),
                                      // Text(
                                      //   'Sodexo@ ${branch?.name ?? ''}',
                                      //   style: TextStyle(
                                      //     fontSize: 20,
                                      //   ),
                                      // ),
                                      // Text(
                                      //   'POS ID : HandHeld',
                                      //   style: TextStyle(
                                      //     fontSize: 22,
                                      //   ),
                                      // ),
                                      Text(
                                        'DATE : ${DateFormat('dd-MM-y HH:mm').format((widget.order.orderDate ?? DateTime.now()).add(const Duration(hours: 7)))}',
                                        style: TextStyle(
                                          fontSize: 22,
                                        ),
                                      ),
                                      Text(
                                        'RECEIPT NO : ${widget.order.orderNo}',
                                        style: TextStyle(
                                          fontSize: 22,
                                        ),
                                      ),
                                      Text(
                                        'SERVICE BY :  ${profile?.fullName ?? ''}',
                                        style: TextStyle(
                                          fontSize: 22,
                                        ),
                                      ),
                                      Text(
                                        '--------------------------------------------------------------------------------------------',
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 200,
                                            child: Text(
                                              'Items/Services',
                                              style: TextStyle(
                                                fontSize: 22,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 50,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Qty.',
                                                  style: TextStyle(
                                                    fontSize: 22,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          SizedBox(
                                              width: 105,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    'Price',
                                                    style: TextStyle(
                                                      fontSize: 22,
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Column(
                                        children: List.generate(widget.order.orderItems!.length, (index) {
                                          return Row(
                                            children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width: 200,
                                                    child: Text(
                                                      widget.order.orderItems?[index].product.name ?? ' - ',
                                                      style: TextStyle(
                                                        fontSize: 22,
                                                      ),
                                                    ),
                                                  ),
                                                  // widget.order.orderItems?[index].remark == ' ' ||
                                                  widget.order.orderItems?[index].remark == '' || widget.order.orderItems?[index].remark == null
                                                      ? SizedBox.shrink()
                                                      : Text('Note# ${widget.order.orderItems?[index].remark ?? ''}'),
                                                ],
                                              ),
                                              SizedBox(
                                                width: 50,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      '${widget.order.orderItems?[index].quantity ?? 0}',
                                                      style: TextStyle(
                                                        fontSize: 22,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              SizedBox(
                                                  width: 105,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        widget.order.orderItems?[index].total.toStringAsFixed(2) ?? 0.toStringAsFixed(2),
                                                        style: TextStyle(
                                                          fontSize: 22,
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                            ],
                                          );
                                        }),
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Text(
                                        '--------------------------------------------------------------------------------------------',
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'AMOUNT',
                                            style: TextStyle(
                                              fontSize: 22,
                                            ),
                                          ),
                                          Text(
                                            widget.order.total!.toStringAsFixed(2),
                                            style: TextStyle(
                                              fontSize: 22,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'DISCOUNT',
                                            style: TextStyle(
                                              fontSize: 22,
                                            ),
                                          ),
                                          Text(
                                            widget.order.discount!.toStringAsFixed(2),
                                            style: TextStyle(
                                              fontSize: 22,
                                            ),
                                          ),
                                        ],
                                      ),
                                      widget.order.serviceCharge == 0
                                          ? SizedBox.shrink()
                                          : Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  'Service Charge 10 %',
                                                  style: TextStyle(
                                                    fontSize: 22,
                                                  ),
                                                ),
                                                Text(
                                                  widget.order.serviceCharge!.toStringAsFixed(2),
                                                  style: TextStyle(
                                                    fontSize: 22,
                                                  ),
                                                ),
                                              ],
                                            ),
                                      widget.order.vat == 0
                                          ? SizedBox.shrink()
                                          : Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  'Vat 7 %',
                                                  style: TextStyle(
                                                    fontSize: 22,
                                                  ),
                                                ),
                                                Text(
                                                  widget.order.vat!.toStringAsFixed(2),
                                                  style: TextStyle(
                                                    fontSize: 22,
                                                  ),
                                                ),
                                              ],
                                            ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'ยอดรวมสุทธิ',
                                            style: TextStyle(
                                              fontSize: 22,
                                            ),
                                          ),
                                          Text(
                                            widget.order.grandTotal!.toStringAsFixed(2),
                                            style: TextStyle(
                                              fontSize: 22,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      widget.order.serviceCharge != 0 || widget.order.vat != 0
                                          ? SizedBox.shrink()
                                          : Center(
                                              child: Text(
                                                '******* Vat Included *******',
                                                style: TextStyle(
                                                  fontSize: 22,
                                                ),
                                              ),
                                            ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'PAYMENT: ${widget.payment?.orderPayment?.paymentMethod?.name_2 ?? ''}',
                                            style: TextStyle(
                                              fontSize: 22,
                                            ),
                                          ),
                                          Text(
                                            widget.order.grandTotal!.toStringAsFixed(2),
                                            style: TextStyle(
                                              fontSize: 22,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        '--------------------------------------------------------------------------------------------',
                                      ),
                                      widget.order.Hn == '' || widget.order.Hn == null
                                          ? SizedBox.shrink()
                                          : Text(
                                              'เบอร์โทร:  ${widget.order.Hn ?? ''}',
                                              style: TextStyle(
                                                fontSize: 22,
                                              ),
                                            ),
                                      widget.order.customerName == '' || widget.order.customerName == null
                                          ? SizedBox.shrink()
                                          : Text(
                                              'Name:  ${widget.order.customerName ?? ''}',
                                              style: TextStyle(
                                                fontSize: 22,
                                              ),
                                            ),
                                      widget.order.remark == '' || widget.order.remark == null
                                          ? SizedBox.shrink()
                                          : Text(
                                              'Note:  ${widget.order.remark ?? ''}',
                                              style: TextStyle(
                                                fontSize: 22,
                                              ),
                                            ),
                                      Text(
                                        'เวลา ณ ที่พิมพ์:  ${DateFormat('dd/MM/y HH:mm').format(DateTime.now())}',
                                        style: TextStyle(
                                          fontSize: 22,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 70,
                                ),
                                Text(
                                  '--------------------------------------------------------------------------------------------',
                                ),
                                Center(
                                    child: Text(
                                  'ลายเซ็นลูกค้า',
                                  style: TextStyle(
                                    fontSize: 22,
                                  ),
                                )),
                                SizedBox(
                                  height: 20,
                                ),
                                Center(
                                    child: Text(
                                  '*** ขอบคุณที่มาใช้บริการ ***',
                                  style: TextStyle(
                                    fontSize: 22,
                                  ),
                                )),
                              ],
                            ),
                          ),
                          widget.page != "พร้อมเพย์"
                              ? Column(
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            LoadingDialog.open(context);
                                            try {
                                              if (widget.payment?.orderPayment?.paymentMethod?.name == "Room Service") {
                                                final photo = await capturePngPag();
                                                await Paymentservice.payRoomService(
                                                    orderId: widget.order.id!, orderPaymentId: widget.payment!.orderPayment!.id);
                                                // await Printing().printSummary(
                                                //   picture: photo!,
                                                // );
                                                Timer.periodic(const Duration(seconds: 3), (timer) async {
                                                  timer.cancel();
                                                  LoadingDialog.close(context);
                                                  final out = await showDialog(
                                                    context: context,
                                                    barrierDismissible: false,
                                                    builder: (BuildContext context) {
                                                      return AlertDialogSuccessNew(
                                                        order: widget.order,
                                                        payment: widget.payment,
                                                        title: 'ชำระเงินสำเร็จ',
                                                        description: 'กด หน้าแรก เพื่อกลับไปที่รายการอาหาร',
                                                        pressNo: () {
                                                          Navigator.pop(context, false);
                                                        },
                                                        pressYes: () {
                                                          Navigator.pop(context, true);
                                                        },
                                                      );
                                                    },
                                                  );
                                                  if (out == true) {
                                                    LoadingDialog.open(context);
                                                    final photo2 = await capturePng();
                                                    // await Printing().printSummary(
                                                    //   picture: photo2!,
                                                    // );
                                                    LoadingDialog.close(context);
                                                    Navigator.pushAndRemoveUntil(
                                                        context, MaterialPageRoute(builder: ((context) => ProductPage())), (route) => false);
                                                  } else {
                                                    LoadingDialog.close(context);
                                                    Navigator.pushAndRemoveUntil(
                                                        context, MaterialPageRoute(builder: ((context) => ProductPage())), (route) => false);
                                                  }
                                                });
                                              } else {
                                                final photo = await capturePngPag();
                                                await Paymentservice.alternativePayment(
                                                    orderId: widget.order.id!, orderPaymentId: widget.payment!.orderPayment!.id);
                                                // await Printing().printSummary(
                                                //   picture: photo!,
                                                // );
                                                Timer.periodic(const Duration(seconds: 3), (timer) async {
                                                  timer.cancel();
                                                  LoadingDialog.close(context);
                                                  final out = await showDialog(
                                                    context: context,
                                                    barrierDismissible: false,
                                                    builder: (BuildContext context) {
                                                      return AlertDialogSuccessNew(
                                                        order: widget.order,
                                                        payment: widget.payment,
                                                        title: 'ชำระเงินสำเร็จ',
                                                        description: 'กด หน้าแรก เพื่อกลับไปที่รายการอาหาร',
                                                        pressNo: () {
                                                          Navigator.pop(context, false);
                                                        },
                                                        pressYes: () {
                                                          Navigator.pop(context, true);
                                                        },
                                                      );
                                                    },
                                                  );
                                                  if (out == true) {
                                                    LoadingDialog.open(context);
                                                    // final photo2 = await capturePng();
                                                    // await Printing().printSummary(
                                                    //   picture: photo2!,
                                                    // );
                                                    LoadingDialog.close(context);
                                                    Navigator.pushAndRemoveUntil(
                                                        context, MaterialPageRoute(builder: ((context) => FirstPage())), (route) => false);
                                                  } else {
                                                    LoadingDialog.close(context);
                                                    Navigator.pushAndRemoveUntil(
                                                        context, MaterialPageRoute(builder: ((context) => FirstPage())), (route) => false);
                                                  }
                                                });
                                              }
                                            } on Exception catch (e) {
                                              if (!mounted) return;
                                              LoadingDialog.close(context);
                                              showDialog(
                                                context: context,
                                                builder: (context) => AlertDialogYes(
                                                  title: 'แจ้งเตือน',
                                                  description: '$e',
                                                  pressYes: () {
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              );
                                            }
                                          },
                                          child: Container(
                                            width: size.width * 0.35,
                                            height: size.height * 0.065,
                                            decoration: BoxDecoration(color: Color(0xFF1264E3), borderRadius: BorderRadius.circular(8)),
                                            child: Center(
                                              child: Text(
                                                textAlign: TextAlign.center,
                                                'รับเงินสำเร็จ',
                                                style: TextStyle(color: Colors.white, fontSize: 16),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              : SizedBox.shrink()
                        ],
                      ),
                    ),
                  ),
                ),
                widget.page == "พร้อมเพย์" || widget.page == 'Truemoney'
                    ? Container(
                        width: double.infinity,
                        height: size.height * 1,
                        color: Colors.white,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 50,
                            ),
                            LoadingAnimationWidget.hexagonDots(
                              color: Colors.blue,
                              size: 80,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'ดำเนินการชำระเงิน',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'ประเภท: ${widget.payment?.orderPayment?.paymentMethod?.name ?? ''}',
                              style: TextStyle(
                                fontSize: 22,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              '${widget.order.grandTotal!.toStringAsFixed(2)} ฿',
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.blue,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: size.width * 0.75,
                              height: size.width * 0.75,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: const ui.Color.fromARGB(255, 2, 94, 169)),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/PromptPay2.png',
                                    scale: 2,
                                  ),
                                  Center(
                                    child: Image.memory(
                                      base64.decode(
                                        widget.payment!.payment!.image!.split(',').last,
                                      ),
                                      height: size.height * 0.232,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    : SizedBox.shrink(),
                // widget.page == 'พร้อมเพย์'
                //     ? Container(
                //         color: Colors.white,
                //         width: double.infinity,
                //         height: size.height * 1,
                //         child: Column(
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           children: [
                //             Center(
                //               child: CircularProgressIndicator(),
                //             ),
                //             SizedBox(
                //               height: 10,
                //             ),
                //             Text('กำลังตรวจสอบรายการ')
                //           ],
                //         ),
                //       )
                //     : Container(
                //         color: Colors.white,
                //         width: double.infinity,
                //         height: size.height * 1,
                //         child: Column(
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           children: [
                //             Center(
                //               child: Container(
                //                 height: size.height * 0.5,
                //                 width: size.width * 0.9,
                //                 decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                //                 child: Padding(
                //                   padding: const EdgeInsets.all(10.0),
                //                   child: Column(
                //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //                     children: [
                //                       Image.asset(
                //                         'assets/icons/Frame (3).png',
                //                         scale: 9,
                //                       ),
                //                       Text(
                //                         'ชำระเงิน',
                //                         style: TextStyle(fontSize: 30),
                //                       ),
                //                       Text(
                //                         'ประเภท : ${widget.page}',
                //                         style: TextStyle(color: Color.fromARGB(206, 66, 66, 66), fontSize: 20),
                //                       ),
                //                       Row(
                //                         mainAxisAlignment: MainAxisAlignment.center,
                //                         children: [
                //                           Text(
                //                             'ใบเสร็จ : ',
                //                             style: TextStyle(color: Color.fromARGB(206, 66, 66, 66), fontSize: 20),
                //                           ),
                //                           Text(
                //                             '${widget.order.orderNo}',
                //                             style: TextStyle(color: Color(0xFF1264E3), fontSize: 20),
                //                           ),
                //                         ],
                //                       ),
                //                       Divider(
                //                         color: Color(0xFF78909C),
                //                       ),
                //                       Row(
                //                         mainAxisAlignment: MainAxisAlignment.center,
                //                         children: [
                //                           GestureDetector(
                //                             onTap: () async {
                //                               LoadingDialog.open(context);
                //                               await capturePngPag();
                //                               await OrderService.alternativePayment(orderId: widget.order.id!, orderPaymentId: widget.payment!.orderPayment!.id);
                //                               await Printing().printSummary(
                //                                 picture: pngBytesPag!,
                //                               );
                //                               LoadingDialog.close(context);
                //                               Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: ((context) => OrderPage())), (route) => false);
                //                             },
                //                             child: Container(
                //                               width: size.width * 0.35,
                //                               height: size.height * 0.065,
                //                               decoration: BoxDecoration(color: Color(0xFF1264E3), borderRadius: BorderRadius.circular(8)),
                //                               child: Center(
                //                                 child: Text(
                //                                   textAlign: TextAlign.center,
                //                                   'รับเงินสำเร็จ',
                //                                   style: TextStyle(color: Colors.white, fontSize: 16),
                //                                 ),
                //                               ),
                //                             ),
                //                           ),
                //                         ],
                //                       ),
                //                     ],
                //                   ),
                //                 ),
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
              ],
            ),
          )),
    );
  }
}
