import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart';
import 'package:stock_application_gas/Models/orderpayments.dart';
import 'package:stock_application_gas/Models/payment.dart';

import 'package:stock_application_gas/Models/reservedatas.dart';
import 'package:stock_application_gas/order/OrderService.dart';
import 'package:stock_application_gas/success/successPage.dart';

import 'package:stock_application_gas/utils/ApiExeption.dart';
import 'package:stock_application_gas/widgets/Dialog.dart';
import 'package:stock_application_gas/widgets/LoadingDialog.dart';

class Selectpyment extends StatefulWidget {
  const Selectpyment({super.key, required this.orderID});
  final Reservedatas orderID;

  @override
  State<Selectpyment> createState() => _SelectpymentState();
}

class _SelectpymentState extends State<Selectpyment> {
  List<Payment> listpayment = [];
  double serviceCharge = 0.00;
  double? showCharge;
  String? base;

  GlobalKey globalKey = GlobalKey();
  Uint8List? pngBytesPag;
  String? bs64;

  @override
  void initState() {
    super.initState();
    getListPayment();
    print(widget.orderID);
  }

  Future<void> getListPayment() async {
    try {
      final listpay = await OrderService.getPayment();
      setState(() {
        listpayment = listpay;
      });
    } on Exception catch (e) {
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (context) => AlertDialogYes(
          title: 'แจ้งเตือน',
          description: '$e',
          pressYes: () {
            Navigator.pop(context, true);
          },
        ),
      );
    }
  }

  Future<Uint8List?> capturePngPag() async {
    try {
      RenderRepaintBoundary boundary1 = globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary1.toImage(pixelRatio: 1.75);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      pngBytesPag = byteData!.buffer.asUint8List();
      bs64 = base64Encode(pngBytesPag!);

      setState(() {});
      return pngBytesPag;
    } catch (e) {
      print(e);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('เลือกการชำระ'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // base == null
          //     ? SizedBox.shrink()
          //     : RepaintBoundary(
          //         key: globalKey,
          //         child: Image.memory(
          //           base64.decode(
          //             base!.split(',').last,
          //           ),
          //           height: size.height * 0.232,
          //         ),
          //       ),
          Container(
            color: Colors.white,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.push(context, MaterialPageRoute(builder: (context) {
                  //       return SlipPage(
                  //         order: widget.orderID,
                  //       );
                  //     }));
                  //   },
                  //   child: Container(
                  //     width: double.infinity,
                  //     height: size.height * 0.06,
                  //     decoration: BoxDecoration(
                  //       border: Border.all(
                  //         color: Colors.blue,
                  //       ),
                  //       borderRadius: BorderRadius.circular(10),
                  //     ),
                  //   ),
                  // ),
                  // InkWell(
                  //   onTap: () async {
                  //     try {
                  //       LoadingDialog.open(context);
                  //       final qe = await OrderService.nextPayment(orderId: widget.orderID.id!);
                  //       await Printing().printSummary(picture: qe.payment!.image);
                  //       LoadingDialog.close(context);
                  //       Navigator.push(context, MaterialPageRoute(builder: (context) {
                  //         return SuccessPage(
                  //           order: widget.orderID,
                  //           page: 'Promtpay',
                  //         );
                  //       }));
                  //     } on Exception catch (e) {
                  //       if (!mounted) return;
                  //       LoadingDialog.close(context);
                  //       showDialog(
                  //         context: context,
                  //         builder: (context) => AlertDialogYes(
                  //           title: 'แจ้งเตือน',
                  //           description: '$e',
                  //           pressYes: () {
                  //             Navigator.pop(context);
                  //           },
                  //         ),
                  //       );
                  //     }
                  //   },
                  //   child: Container(
                  //     width: double.infinity,
                  //     height: size.height * 0.06,
                  //     decoration: BoxDecoration(
                  //       border: Border.all(
                  //         color: Colors.blue,
                  //       ),
                  //       borderRadius: BorderRadius.circular(10),
                  //     ),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       children: [
                  //         Icon(
                  //           Icons.qr_code,
                  //           color: Colors.blue,
                  //         ),
                  //         SizedBox(
                  //           width: 10,
                  //         ),
                  //         Text(
                  //           'Promtpay',
                  //           style: TextStyle(color: Colors.blue, fontSize: 16, fontWeight: FontWeight.bold),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // InkWell(
                  //   onTap: () async {
                  //     try {
                  //       LoadingDialog.open(context);
                  //       final pay = await OrderService.nextPayment(orderId: widget.orderID.id!);
                  //       LoadingDialog.close(context);
                  //       Navigator.push(context, MaterialPageRoute(builder: (context) {
                  //         return SuccessPage(
                  //           order: widget.orderID,
                  //           page: 'เงินสด',
                  //           payment: pay,
                  //         );
                  //       }));
                  //     } on Exception catch (e) {
                  //       if (!mounted) return;
                  //       LoadingDialog.close(context);
                  //       showDialog(
                  //         context: context,
                  //         builder: (context) => AlertDialogYes(
                  //           title: 'แจ้งเตือน',
                  //           description: '$e',
                  //           pressYes: () {
                  //             Navigator.pop(context);
                  //           },
                  //         ),
                  //       );
                  //     }
                  //   },
                  //   child: Container(
                  //     width: double.infinity,
                  //     height: size.height * 0.06,
                  //     decoration: BoxDecoration(
                  //       border: Border.all(
                  //         color: Colors.blue,
                  //       ),
                  //       borderRadius: BorderRadius.circular(10),
                  //     ),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       children: [
                  //         Icon(
                  //           Icons.money,
                  //           color: Colors.blue,
                  //         ),
                  //         SizedBox(
                  //           width: 10,
                  //         ),
                  //         Text(
                  //           'เงินสด',
                  //           style: TextStyle(color: Colors.blue, fontSize: 16, fontWeight: FontWeight.bold),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  listpayment.isEmpty
                      ? Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: listpayment.length,
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 4.0, //
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ListTile(
                                onTap: () async {
                                  LoadingDialog.open(context);
                                  List<OrderPayments> payment = [];
                                  try {
                                    final orderPayment = OrderPayments(listpayment[index].id, widget.orderID.grandTotal!, '');
                                    payment.add(orderPayment);
                                    await OrderService.paymentSelected(
                                      orderId: widget.orderID.id!,
                                      orderPayments: payment,
                                      paid: widget.orderID.grandTotal!,
                                      change: 0.00,
                                      discount: 0.00,
                                      serviceCharge: widget.orderID.serviceCharge!.toDouble(),
                                      serviceChargeRate: 10,
                                    );
                                    final qe = await OrderService.nextPayment(orderId: widget.orderID.id!);
                                    // setState(() {
                                    //   base = qe.payment?.image;
                                    // });
                                    if (listpayment[index].name == 'พร้อมเพย์' || listpayment[index].name == 'Truemoney') {
                                      // Timer.periodic(const Duration(seconds: 3), (timer) async {
                                      // await capturePngPag();
                                      // timer.cancel();
                                      // await Printing().printSummary(
                                      //   picture: pngBytesPag!,
                                      // );
                                      // setState(() {
                                      //   base = null;
                                      // });
                                      LoadingDialog.close(context);
                                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                                        return SuccessPage(
                                          order: widget.orderID,
                                          page: listpayment[index].name!,
                                          payment: qe,
                                        );
                                      }));
                                      // });
                                    } else if (listpayment[index].name == 'Room Service') {
                                      if (widget.orderID.roomNo != '' && widget.orderID.roomNo != null) {
                                        LoadingDialog.close(context);
                                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                                          return SuccessPage(
                                            order: widget.orderID,
                                            page: listpayment[index].name!,
                                            payment: qe,
                                          );
                                        }));
                                      } else {
                                        LoadingDialog.close(context);
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialogYes(
                                            title: 'แจ้งเตือน',
                                            description: 'ไม่สามารถชำระเงินด้วยวิธีการนี้ได้ \nกรุณาเลือกวิธีชำระอื่น\nเนื่องจาก ไม่ได้กรอกเลขห้อง',
                                            pressYes: () {
                                              Navigator.pop(context, true);
                                            },
                                          ),
                                        );
                                      }
                                    } else {
                                      LoadingDialog.close(context);
                                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                                        return SuccessPage(
                                          order: widget.orderID,
                                          page: listpayment[index].name!,
                                          payment: qe,
                                        );
                                      }));
                                    }
                                  } on ClientException catch (e) {
                                    if (!mounted) return;
                                    LoadingDialog.close(context);
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialogYes(
                                        title: 'แจ้งเตือน',
                                        description: '$e',
                                        pressYes: () {
                                          Navigator.pop(context, true);
                                        },
                                      ),
                                    );
                                  } on ApiException catch (e) {
                                    if (!mounted) return;
                                    LoadingDialog.close(context);
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialogYes(
                                        title: 'แจ้งเตือน',
                                        description: '$e',
                                        pressYes: () {
                                          Navigator.pop(context, true);
                                        },
                                      ),
                                    );
                                  }
                                },
                                title: Text(listpayment[index].name_2 ?? ''),
                                trailing: Icon(Icons.arrow_forward_ios),
                              ),
                            );
                          },
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
