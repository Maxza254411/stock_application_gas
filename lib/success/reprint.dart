// import 'dart:convert';
// import 'dart:typed_data';
// import 'dart:ui' as ui;

// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:intl/intl.dart';
// import 'package:sct_order/models/branch.dart';
// import 'package:sct_order/models/profile.dart';
// import 'package:sct_order/models/reservedata.dart';
// import 'package:sct_order/order/OrderService.dart';
// import 'package:sct_order/print.dart';
// import 'package:sct_order/widgets/LoadingDialog.dart';

// class ReprintPage extends StatefulWidget {
//   const ReprintPage({super.key, required this.order});
//   final Reservedata order;

//   @override
//   State<ReprintPage> createState() => _ReprintPageState();
// }

// class _ReprintPageState extends State<ReprintPage> {
//   Profile? profile;
//   Branch? branch;
//   GlobalKey globalKey2 = GlobalKey();
//   Uint8List? pngBytesPag2;
//   String? bs642;
//   Reservedata? orderId;

//   @override
//   void initState() {
//     super.initState();
//     getprofileById();
//     getorder();
//   }

//   getprofileById() async {
//     final profile2 = await OrderService.getprofileById();
//     final branch2 = await OrderService.getStore();
//     setState(() {
//       profile = profile2;
//       branch = branch2;
//     });
//   }

//   getorder() async {
//     final orderId2 = await OrderService.getOrderID(id: widget.order.id!);
//     setState(() {
//       orderId = orderId2;
//     });
//   }

//   Future<Uint8List?> capturePng() async {
//     try {
//       RenderRepaintBoundary boundary = globalKey2.currentContext!.findRenderObject() as RenderRepaintBoundary;
//       ui.Image image = await boundary.toImage(pixelRatio: 1.75);
//       ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
//       pngBytesPag2 = byteData!.buffer.asUint8List();
//       bs642 = base64Encode(pngBytesPag2!);
//       setState(() {});
//       return pngBytesPag2;
//     } catch (e) {}
//     return null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('รายละเอียด'),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Container(
//             width: double.infinity,
//             height: size.height * 1,
//             color: Colors.white,
//             child: Column(
//               children: [
//                 RepaintBoundary(
//                   key: globalKey2,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Center(
//                         child: Text(
//                           '(Copy)',
//                           style: TextStyle(
//                             fontSize: 25,
//                           ),
//                         ),
//                       ),
//                       orderId?.roomNo == '' || orderId?.roomNo == '0' || orderId?.roomNo == null
//                           ? SizedBox.shrink()
//                           : Center(
//                               child: Text(
//                                 'ห้อง: ${orderId?.roomNo}',
//                                 style: TextStyle(
//                                   fontSize: 25,
//                                 ),
//                               ),
//                             ),
//                       Text(
//                         'Sodexo@ ${branch?.name ?? ''}',
//                         style: TextStyle(
//                           fontSize: 20,
//                         ),
//                       ),
//                       Text(
//                         'POS ID : HandHeld',
//                         style: TextStyle(
//                           fontSize: 22,
//                         ),
//                       ),
//                       Text(
//                         'DATE : ${DateFormat('dd-MM-y HH:mm').format((orderId?.orderDate ?? DateTime.now()).add(const Duration(hours: 7)))}',
//                         style: TextStyle(
//                           fontSize: 22,
//                         ),
//                       ),
//                       Text(
//                         'RECEIPT NO : ${orderId?.orderNo}',
//                         style: TextStyle(
//                           fontSize: 22,
//                         ),
//                       ),
//                       Text(
//                         'SERVICE BY :  ${profile?.fullName ?? ''}',
//                         style: TextStyle(
//                           fontSize: 22,
//                         ),
//                       ),
//                       Text(
//                         '-----------------------------------------------------------------',
//                       ),
//                       Row(
//                         children: [
//                           SizedBox(
//                             width: 200,
//                             child: Text(
//                               'Items/Services',
//                               style: TextStyle(
//                                 fontSize: 22,
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             width: 50,
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   'Qty.',
//                                   style: TextStyle(
//                                     fontSize: 22,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(
//                             width: 20,
//                           ),
//                           SizedBox(
//                               width: 105,
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: [
//                                   Text(
//                                     'Price',
//                                     style: TextStyle(
//                                       fontSize: 22,
//                                     ),
//                                   ),
//                                 ],
//                               )),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       Column(
//                         children: List.generate(orderId?.orderItems?.length ?? 0, (index) {
//                           return Row(
//                             children: [
//                               Column(
//                                 children: [
//                                   SizedBox(
//                                     width: 200,
//                                     child: Text(
//                                       orderId?.orderItems?[index].product?.name ?? ' - ',
//                                       style: TextStyle(
//                                         fontSize: 22,
//                                       ),
//                                     ),
//                                   ),
//                                   // orderId?.orderItems?[index].remark == ' ' ||
//                                   orderId?.orderItems?[index].remark == '' || orderId?.orderItems?[index].remark == null
//                                       ? SizedBox.shrink()
//                                       : Text('Note# ${orderId?.orderItems?[index].remark ?? ''}'),
//                                 ],
//                               ),
//                               SizedBox(
//                                 width: 50,
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Text(
//                                       '${orderId?.orderItems?[index].quantity ?? 0}',
//                                       style: TextStyle(
//                                         fontSize: 22,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: 20,
//                               ),
//                               SizedBox(
//                                   width: 105,
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.end,
//                                     children: [
//                                       Text(
//                                         '${orderId?.orderItems?[index].total!.toStringAsFixed(2) ?? 0.toStringAsFixed(2)}',
//                                         style: TextStyle(
//                                           fontSize: 22,
//                                         ),
//                                       ),
//                                     ],
//                                   )),
//                             ],
//                           );
//                         }),
//                       ),
//                       SizedBox(
//                         height: 30,
//                       ),
//                       Text(
//                         '-----------------------------------------------------------------',
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             'AMOUNT',
//                             style: TextStyle(
//                               fontSize: 22,
//                             ),
//                           ),
//                           Text(
//                             orderId?.total?.toStringAsFixed(2) ?? '',
//                             style: TextStyle(
//                               fontSize: 22,
//                             ),
//                           ),
//                         ],
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             'DISCOUNT',
//                             style: TextStyle(
//                               fontSize: 22,
//                             ),
//                           ),
//                           Text(
//                             orderId?.discount?.toStringAsFixed(2) ?? '',
//                             style: TextStyle(
//                               fontSize: 22,
//                             ),
//                           ),
//                         ],
//                       ),
//                       orderId?.serviceCharge == 0
//                           ? SizedBox.shrink()
//                           : Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   'Service Charge 10 %',
//                                   style: TextStyle(
//                                     fontSize: 22,
//                                   ),
//                                 ),
//                                 Text(
//                                   orderId?.serviceCharge?.toStringAsFixed(2) ?? '',
//                                   style: TextStyle(
//                                     fontSize: 22,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                       orderId?.vat == 0
//                           ? SizedBox.shrink()
//                           : Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   'Vat 7 %',
//                                   style: TextStyle(
//                                     fontSize: 22,
//                                   ),
//                                 ),
//                                 Text(
//                                   orderId?.vat?.toStringAsFixed(2) ?? '',
//                                   style: TextStyle(
//                                     fontSize: 22,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             'ยอดรวมสุทธิ',
//                             style: TextStyle(
//                               fontSize: 22,
//                             ),
//                           ),
//                           Text(
//                             orderId?.grandTotal?.toStringAsFixed(2) ?? '',
//                             style: TextStyle(
//                               fontSize: 22,
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       orderId?.serviceCharge != 0 || orderId?.vat != 0
//                           ? SizedBox.shrink()
//                           : Center(
//                               child: Text(
//                                 '******* Vat Included *******',
//                                 style: TextStyle(
//                                   fontSize: 22,
//                                 ),
//                               ),
//                             ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             'PAYMENT: ${orderId?.orderPayments?[0].paymentMethod?.name ?? ''}',
//                             style: TextStyle(
//                               fontSize: 22,
//                             ),
//                           ),
//                           Text(
//                             orderId?.grandTotal?.toStringAsFixed(2) ?? '',
//                             style: TextStyle(
//                               fontSize: 22,
//                             ),
//                           ),
//                         ],
//                       ),
//                       Text(
//                         '-----------------------------------------------------------------',
//                       ),
//                       orderId?.Hn == '' || orderId?.Hn == null
//                           ? SizedBox.shrink()
//                           : Text(
//                               'HN:  ${orderId?.Hn ?? ''}',
//                               style: TextStyle(
//                                 fontSize: 22,
//                               ),
//                             ),
//                       orderId?.remark == '' || orderId?.remark == null
//                           ? SizedBox.shrink()
//                           : Text(
//                               'Note:  ${orderId?.remark ?? ''}',
//                               style: TextStyle(
//                                 fontSize: 22,
//                               ),
//                             ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 GestureDetector(
//                   onTap: () async {
//                     LoadingDialog.open(context);
//                     if (!mounted) return;
//                     await capturePng();
//                     await Printing().printSummary(
//                       picture: pngBytesPag2!,
//                     );
//                     if (!mounted) return;
//                     LoadingDialog.close(context);
//                   },
//                   child: Container(
//                     width: size.width * 0.35,
//                     height: size.height * 0.065,
//                     decoration: BoxDecoration(color: Color(0xFF1264E3), borderRadius: BorderRadius.circular(8)),
//                     child: Center(
//                       child: Text(
//                         textAlign: TextAlign.center,
//                         'พิมพ์ใบเสร็จ',
//                         style: TextStyle(color: Colors.white, fontSize: 16),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
