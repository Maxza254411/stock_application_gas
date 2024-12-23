// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart';
// import 'package:provider/provider.dart';
// import 'package:stock_application_gas/Models/order.dart';
// import 'package:stock_application_gas/Models/orderpayments.dart';
// import 'package:stock_application_gas/payment/service/paymentController.dart';
// import 'package:stock_application_gas/payment/service/paymentService.dart';
// import 'package:stock_application_gas/success/successPage.dart';
// import 'package:stock_application_gas/utils/ApiExeption.dart';
// import 'package:stock_application_gas/widgets/Dialog.dart';
// import 'package:stock_application_gas/widgets/LoadingDialog.dart';

// class SelectedPayment extends StatefulWidget {
//   const SelectedPayment(
//       {super.key,
//       required this.sumPrice,
//       required this.order,
//       required this.serviceCharge,
//       required this.discount,
//       required this.showServiceChargeRate});
//   final double sumPrice, serviceCharge, discount, showServiceChargeRate;
//   final Order order;

//   @override
//   State<SelectedPayment> createState() => _SelectedPaymentState();
// }

// class _SelectedPaymentState extends State<SelectedPayment> {
//   int? selectedIndex;
//   int? idPayment;
//   String? namePayment;
//   @override
//   void initState() {
//     super.initState();
//     getListPayment();
//   }

//   void onItemTapped(int index, int id, String name) => setState(() {
//         selectedIndex = index;
//         idPayment = id;
//         namePayment = name;
//         // widget.onPayment(context.read<PaymentController>().payments[selectedIndex]);
//       });
//   Future<void> getListPayment() async {
//     try {
//       await context.read<PaymentController>().getListPayment();
//       if (context.read<PaymentController>().payments.isNotEmpty) {
//         // widget.onPayment(context.read<PaymentController>().payments[0]);
//       }
//     } on Exception catch (e) {
//       if (!mounted) return;
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialogYes(
//           title: 'แจ้งเตือน',
//           description: '$e',
//           pressYes: () {
//             Navigator.pop(context, true);
//           },
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         leading: GestureDetector(
//           onTap: () {
//             Navigator.pop(context);
//           },
//           child: Icon(
//             Icons.arrow_back,
//             color: Colors.white,
//           ),
//         ),
//         title: Text(
//           'ชำระเงิน',
//           style: TextStyle(color: Colors.white),
//         ),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             padding: EdgeInsetsDirectional.symmetric(horizontal: 16),
//             width: double.infinity,
//             height: size.height * 0.08,
//             color: Color(0xFFDCEDC8),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'ราคารวม',
//                   style: TextStyle(
//                     fontSize: 25,
//                     color: Color(0xFF424242),
//                     fontFamily: 'IBMPlexSansThai',
//                   ),
//                 ),
//                 Text(
//                   '${widget.sumPrice.toStringAsFixed(2)} ฿',
//                   style: TextStyle(
//                     fontSize: 32,
//                     color: Color(0xFF424242),
//                     fontFamily: 'IBMPlexSansThai',
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(
//               horizontal: 16,
//             ),
//             child: Text(
//               'วิธีการชำระเงิน',
//               style: TextStyle(
//                 fontSize: 25,
//                 color: Color(0xFF424242),
//                 fontFamily: 'IBMPlexSansThai',
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: SizedBox(
//               height: size.height * 0.61,
//               width: double.infinity,
//               child: Consumer<PaymentController>(
//                 builder: (context, productController, child) => GridView.builder(
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     mainAxisSpacing: 15,
//                     childAspectRatio: 3,
//                     crossAxisSpacing: 15,
//                   ),
//                   itemCount: productController.payments.length,
//                   itemBuilder: (BuildContext context, int index) => InkWell(
//                     onTap: () => onItemTapped(index, productController.payments[index].id, productController.payments[index].name!),
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: selectedIndex == index ? const Color(0xfffe8eaf6) : Colors.white,
//                         border: Border.all(color: const Color(0xff1264E3)),
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       height: size.height * 0.089,
//                       width: size.width * 0.5,
//                       child: Row(
//                         children: [
//                           // productController.payments[index].icon == null
//                           // ? SizedBox.shrink()
//                           // : Padding(
//                           //     padding: const EdgeInsets.only(left: 10),
//                           //     child: SvgPicture.network(
//                           //       productController.payments[index].icon!,
//                           //     )),
//                           Padding(
//                             padding: const EdgeInsets.only(left: 10),
//                             child: Text(
//                               productController.payments[index].name_2!,
//                               style: TextStyle(fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Divider()
//         ],
//       ),
//       bottomNavigationBar: InkWell(
//         onTap: () async {
//           if (idPayment != null) {
//             LoadingDialog.open(context);
//             List<OrderPayments> payment = [];
//             try {
//               final orderPayment = OrderPayments(idPayment!, widget.sumPrice, '');
//               payment.add(orderPayment);
//               await Paymentservice.paymentSelected(
//                 orderId: widget.order.id!,
//                 orderPayments: payment,
//                 paid: widget.sumPrice,
//                 change: 0.00,
//                 discount: widget.discount,
//                 serviceCharge: widget.serviceCharge,
//                 serviceChargeRate: widget.showServiceChargeRate,
//                 grandTotal: widget.sumPrice,
//               );
//               final qe = await Paymentservice.nextPayment(orderId: widget.order.id!);
//               final order2 = await Paymentservice.getOrderId(orderId: widget.order.id!);

//               if (namePayment == 'พร้อมเพย์' || namePayment == 'Truemoney') {
//                 LoadingDialog.close(context);
//                 Navigator.push(context, MaterialPageRoute(builder: (context) {
//                   return SuccessPage(
//                     orders: widget.order,
//                     page: namePayment!,
//                     payment: qe,
//                     order: order2,
//                   );
//                 }));
//               } else if (namePayment == 'Room Service') {
//                 if (widget.order.roomNo != '' && widget.order.roomNo != null) {
//                   LoadingDialog.close(context);
//                   Navigator.push(context, MaterialPageRoute(builder: (context) {
//                     return SuccessPage(
//                       orders: widget.order,
//                       page: namePayment!,
//                       payment: qe,
//                       order: order2,
//                     );
//                   }));
//                 } else {
//                   LoadingDialog.close(context);
//                   showDialog(
//                     context: context,
//                     builder: (context) => AlertDialogYes(
//                       title: 'แจ้งเตือน',
//                       description: 'กรุณากรอกเลขห้อง',
//                       pressYes: () {
//                         Navigator.pop(context, true);
//                       },
//                     ),
//                   );
//                 }
//               } else {
//                 LoadingDialog.close(context);
//                 Navigator.push(context, MaterialPageRoute(builder: (context) {
//                   return SuccessPage(
//                     orders: widget.order,
//                     page: namePayment!,
//                     payment: qe,
//                     order: order2,
//                   );
//                 }));
//               }
//             } on ClientException catch (e) {
//               if (!mounted) return;
//               LoadingDialog.close(context);
//               showDialog(
//                 context: context,
//                 builder: (context) => AlertDialogYes(
//                   title: 'แจ้งเตือน',
//                   description: '$e',
//                   pressYes: () {
//                     Navigator.pop(context, true);
//                   },
//                 ),
//               );
//             } on ApiException catch (e) {
//               if (!mounted) return;
//               LoadingDialog.close(context);
//               showDialog(
//                 context: context,
//                 builder: (context) => AlertDialogYes(
//                   title: 'แจ้งเตือน',
//                   description: '$e',
//                   pressYes: () {
//                     Navigator.pop(context, true);
//                   },
//                 ),
//               );
//             }
//           } else {
//             showDialog(
//               context: context,
//               builder: (context) => AlertDialogYes(
//                 title: 'แจ้งเตือน',
//                 description: 'กรุณาเลือกวิธีการชำระ',
//                 pressYes: () {
//                   Navigator.pop(context, true);
//                 },
//               ),
//             );
//           }
//         },
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Card(
//             color: Colors.blue,
//             elevation: 5,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(5.0),
//             ),
//             child: SizedBox(
//               width: size.width * 0.9,
//               height: size.height * 0.06,
//               child: Center(
//                   child: Text(
//                 'ยืนยัน',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   fontFamily: 'IBMPlexSansThai',
//                 ),
//               )),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
