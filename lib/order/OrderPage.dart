import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:intl/intl.dart';
import 'package:stock_application_gas/login/loginPage.dart';
import 'package:stock_application_gas/models/reservedatas.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart' as picker;
import 'package:stock_application_gas/order/DetailOrder/DetailOrder.dart';
import 'package:stock_application_gas/order/OrderService.dart';
import 'package:stock_application_gas/print.dart';
import 'package:stock_application_gas/widgets/Dialog.dart';
import 'package:stock_application_gas/widgets/LoadingDialog.dart';
import 'package:stock_application_gas/widgets/input.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> with TickerProviderStateMixin {
  late TabController _tabController;

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  TextEditingController roomNo = TextEditingController();
  Timer? time;
  List<Reservedatas> listOrder = [];
  ScrollController scrollController = ScrollController();
  // final iminPrinter = IminPrinter();
  GlobalKey globalKey = GlobalKey();
  Uint8List? pngBytesPag;
  String? bs64;
  int _currentMax = 12;

  int _currentPage = 1;
  bool isLoading = false;
  bool _hasMoreData = true;
  String deviceName = '';
  String name = '';

  String status = 'cooking';
  List<String> selectStatus = ['cooking', 'sending', 'complete'];
  String pickerDate = DateFormat('dd/MM/y').format(DateTime.now());

  String? stringTime;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    getOrder(
        status: status,
        date: '\$btw:${DateFormat('yyyy-MM-dd').format(DateTime.now())} 00:00:00,${DateFormat('yyyy-MM-dd').format(DateTime.now())} 23:59:59');
    // initPrinter();
  }

  // Future<void> initPrinter() async {
  //   await iminPrinter.initPrinter();
  //   final status = await iminPrinter.getPrinterStatus();
  //   if (status == 'Failed to initialize the printer!') {
  //     await iminPrinter.resetDevice();
  //     initPrinter();
  //   }
  // }

  @override
  void dispose() {
    scrollController.dispose();
    time?.cancel();
    super.dispose();
  }

  // void _scrollListener() {
  //   if (scrollController.position.pixels == scrollController.position.maxScrollExtent && !isLoading) {
  //     _loadMoreData();
  //   }
  // }

  // Future<void> _loadMoreData() async {
  //   if (!_hasMoreData) return;

  //   setState(() {
  //     isLoading = true;
  //   });

  //   final newTransactions = await getOrder2();

  //   setState(() {
  //     if (newTransactions.isEmpty) {
  //       _hasMoreData = false;
  //     } else {
  //       listOrder.addAll(newTransactions);
  //       _currentMax += newTransactions.length;
  //       _currentPage++;
  //     }
  //     isLoading = false;
  //   });
  // }

  // Future<List<Reservedata>> getOrder2() async {
  //   final order = await OrderService.getreserve(
  //     page: _currentPage,
  //     limit: _currentMax,
  //   );
  //   listOrder = order.data!.take(_currentMax).toList();
  //   scrollController.addListener(_scrollListener);

  //   return order.data!;
  // }

  Future getOrder({String? status, String? roomNo, String? date}) async {
    try {
      final order = await OrderService.getreserve(page: 1, limit: 55, receivedStatus: status, roomNo: roomNo, fillterDate: date);
      // _currentPage++;
      listOrder.clear();
      setState(() {
        listOrder = order.data!;
        time?.cancel();
        // listOrder = order.data!.take(_currentMax).toList();
        // scrollController.addListener(_scrollListener);
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
  }

  Future<void> clearToken() async {
    SharedPreferences prefs = await _prefs;
    prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leadingWidth: 80,
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Ver. 1.0.9b1'),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          "รายการ",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
        ),
        actions: [
          GestureDetector(
            onTap: () async {
              final out = await showDialog(
                context: context,
                builder: (context) => AlertDialogLockOut(
                  title: 'แจ้งเตือน',
                  description: 'ยืนยันที่จะออกจากระบบ',
                  pressYes: () {
                    Navigator.pop(context, true);
                  },
                  pressNo: () {
                    Navigator.pop(context, false);
                  },
                ),
              );
              if (out == true) {
                await clearToken();
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginPage()), (route) => true);
              }
            },
            child: Container(
              width: 35,
              height: 35,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Image.asset(
                "assets/images/Vector-2.png",
              ),
            ),
          ),
        ],
      ),
      body: Container(
          width: double.infinity,
          // height: size.height * 0.88,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InputTextFormField(
                        width: size.width * 0.55,
                        height: size.height * 0.06,
                        hintText: 'ค้นหาเลขห้อง',
                        controller: roomNo,
                        // onFieldSubmitted: (p0) async {
                        //   LoadingDialog.open(context);
                        //   await getOrder(status: status, roomNo: roomNo.text == '' ? null : roomNo.text);
                        //   if (!mounted) return;
                        //   LoadingDialog.close(context);
                        // },
                      ),
                      GestureDetector(
                        onTap: () async {
                          LoadingDialog.open(context);
                          await getOrder(status: status, roomNo: roomNo.text == '' ? null : roomNo.text);
                          if (!mounted) return;
                          LoadingDialog.close(context);
                          roomNo.clear();
                        },
                        child: Container(
                          width: size.width * 0.3,
                          height: size.height * 0.06,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                              child: Text(
                            'ค้นหา',
                            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                          )),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    picker.DatePicker.showDatePicker(
                      context,
                      showTitleActions: true,
                      currentTime: DateTime.now(),
                      locale: picker.LocaleType.th,
                      minTime: DateTime(1900, 1, 1),
                      maxTime: DateTime(2200, 1, 1),
                      theme: picker.DatePickerTheme(
                        containerHeight: size.height * 0.5,
                        itemHeight: size.height * 0.075,
                        titleHeight: size.height * 0.08,
                        headerColor: Colors.blue,
                        backgroundColor: Colors.white,
                        itemStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
                        doneStyle: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
                        cancelStyle: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      // onChanged: (date) {
                      //   print('change $date in time zone ' + date.timeZoneOffset.inHours.toString());
                      // },
                      onConfirm: (date) async {
                        print('confirm $date');
                        setState(
                          () {
                            pickerDate = DateFormat('dd/MM/y').format(date);
                            stringTime = "\$btw:${DateFormat('yyyy-MM-dd').format(date)} 00:00:00,${DateFormat('yyyy-MM-dd').format(date)} 23:59:59";
                          },
                        );
                        LoadingDialog.open(context);
                        await getOrder(status: status, roomNo: roomNo.text == '' ? null : roomNo.text, date: stringTime);
                        if (!mounted) return;
                        LoadingDialog.close(context);
                      },
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      width: double.infinity,
                      height: size.height * 0.06,
                      decoration: BoxDecoration(
                        color: const ui.Color.fromARGB(255, 212, 212, 212),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            pickerDate == '' ? 'เลือกวันที่' : pickerDate,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(Icons.search)
                        ],
                      ),
                    ),
                  ),
                ),
                // Container(
                //   padding: EdgeInsets.all(8),
                //   width: double.infinity,
                //   height: size.height * 0.08,
                //   child: Card(
                //     surfaceTintColor: Colors.white,
                //     color: Colors.white,
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(8.0),
                //     ),
                //     elevation: 2,
                //     child: DropdownButtonHideUnderline(
                //       child: DropdownButton2<String>(
                //         isExpanded: true,
                //         hint: Text(
                //           'เลือกประเภทการใช้งาน',
                //           style: TextStyle(
                //             fontSize: 14,
                //             fontFamily: 'IBMPlexSansThai',
                //             color: Theme.of(context).hintColor,
                //           ),
                //         ),
                //         items: selectStatus
                //             .map((String item) => DropdownMenuItem<String>(
                //                   value: item,
                //                   child: Text(
                //                     item,
                //                     style: TextStyle(
                //                       fontSize: 14,
                //                       fontFamily: 'IBMPlexSansThai',
                //                     ),
                //                   ),
                //                 ))
                //             .toList(),
                //         value: status,
                //         onChanged: (String? va) async {
                //           setState(() {
                //             status = va!;
                //           });
                //           LoadingDialog.open(context);
                //           await getOrder(status: va);
                //           LoadingDialog.close(context);
                //         },
                //         buttonStyleData: ButtonStyleData(
                //           padding: EdgeInsets.symmetric(horizontal: 8),
                //           height: size.height * 0.08,
                //         ),
                //         menuItemStyleData: MenuItemStyleData(
                //           height: size.height * 0.08,
                //         ),
                //       ),
                //     ),
                //   ),
                // ),

                TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelPadding: EdgeInsetsDirectional.symmetric(vertical: 8, horizontal: 16),
                  padding: EdgeInsets.all(8),
                  controller: _tabController,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  dividerColor: Colors.transparent,
                  indicatorColor: Colors.transparent,
                  indicator: BoxDecoration(
                    color: ui.Color.fromARGB(248, 203, 203, 203),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  onTap: (value) async {
                    listOrder.clear();
                    if (value == 0) {
                      LoadingDialog.open(context);
                      setState(() {
                        status = 'cooking';
                      });
                      await getOrder(
                          status: 'cooking',
                          date: stringTime ??
                              '\$btw:${DateFormat('yyyy-MM-dd').format(DateTime.now())} 00:00:00,${DateFormat('yyyy-MM-dd').format(DateTime.now())} 23:59:59');
                      LoadingDialog.close(context);
                    } else if (value == 1) {
                      LoadingDialog.open(context);
                      setState(() {
                        status = 'sending';
                      });
                      await getOrder(
                          status: 'sending',
                          date: stringTime ??
                              '\$btw:${DateFormat('yyyy-MM-dd').format(DateTime.now())} 00:00:00,${DateFormat('yyyy-MM-dd').format(DateTime.now())} 23:59:59');
                      LoadingDialog.close(context);
                    } else {
                      LoadingDialog.open(context);
                      setState(() {
                        status = 'complete';
                      });
                      await getOrder(
                          status: 'complete',
                          date: stringTime ??
                              '\$btw:${DateFormat('yyyy-MM-dd').format(DateTime.now())} 00:00:00,${DateFormat('yyyy-MM-dd').format(DateTime.now())} 23:59:59');
                      LoadingDialog.close(context);
                    }
                  },
                  labelStyle: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'NotoSansThai'),
                  tabs: [
                    Tab(
                      child: Text(
                        'จัดของ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'กำลังขนส่ง',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'สำเร็จ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 1,
                  child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    controller: _tabController,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: size.height * 0.655,
                                  width: double.infinity,
                                  child: RefreshIndicator(
                                    onRefresh: () async {
                                      LoadingDialog.open(context);
                                      listOrder.clear();

                                      await getOrder(status: status, roomNo: roomNo.text == '' ? null : roomNo.text, date: stringTime);
                                      LoadingDialog.close(context);
                                    },
                                    child: listOrder.isEmpty
                                        ? SizedBox.shrink()
                                        : ListView.builder(
                                            itemCount: listOrder.length,
                                            // isLoading ? listOrder.length + 1 : listOrder.length,
                                            itemBuilder: (context, index) {
                                              // if (index == listOrder.length && isLoading) {
                                              //   return _buildProgressIndicator();
                                              // } else if (index < listOrder.length) {
                                              var transaction = listOrder[index];
                                              return InkWell(
                                                onTap: () async {
                                                  // await capturePngPag();
                                                  // Printing().printSummary(picture: pngBytesPag);
                                                  if (transaction.receivedStatus == 'sending' || transaction.receivedStatus == 'complete') {
                                                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                                                      return DetailOrder(transaction: transaction);
                                                    }));
                                                  } else {
                                                    final statusOrder = await showDialog(
                                                        barrierDismissible: false,
                                                        context: context,
                                                        builder: (context) {
                                                          return AlertDialog(
                                                            title: Text(
                                                              'ยืนยันการอัพเดทสถานะ',
                                                              style: TextStyle(fontWeight: FontWeight.bold),
                                                            ),
                                                            content: Text(
                                                              'ยืนยันที่จะเปลี่ยนแปลงสถานะของออเดอร์ใช่หรือไม่',
                                                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                                                            ),
                                                            actions: [
                                                              GestureDetector(
                                                                onTap: () {
                                                                  Navigator.pop(context, false);
                                                                },
                                                                child: Container(
                                                                  width: size.width * 0.3,
                                                                  height: size.height * 0.06,
                                                                  decoration: BoxDecoration(
                                                                      color: Colors.white,
                                                                      borderRadius: BorderRadius.circular(10),
                                                                      border: Border.all(color: Colors.red)),
                                                                  child: Center(
                                                                      child: Text(
                                                                    'ยกเลิก',
                                                                    style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold),
                                                                  )),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 20,
                                                              ),
                                                              GestureDetector(
                                                                onTap: () {
                                                                  Navigator.pop(context, true);
                                                                },
                                                                child: Container(
                                                                  width: size.width * 0.3,
                                                                  height: size.height * 0.06,
                                                                  decoration: BoxDecoration(
                                                                    color: Colors.blue,
                                                                    borderRadius: BorderRadius.circular(10),
                                                                  ),
                                                                  child: Center(
                                                                      child: Text(
                                                                    'ตกลง',
                                                                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                                                                  )),
                                                                ),
                                                              ),
                                                            ],
                                                          );
                                                        });

                                                    if (statusOrder == true) {
                                                      try {
                                                        if (!mounted) return;
                                                        LoadingDialog.open(context);
                                                        await OrderService.updateStatus(orderId: transaction.id!);
                                                        await getOrder(
                                                            status: status, roomNo: roomNo.text == '' ? null : roomNo.text, date: stringTime);
                                                        LoadingDialog.close(context);
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
                                                    }
                                                  }
                                                },
                                                child: Container(
                                                  margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                                                  padding: const EdgeInsets.all(10.0),
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    color: Colors.transparent,
                                                    border: Border.all(color: Colors.blue, width: 2.0),
                                                    borderRadius: BorderRadius.circular(10.0),
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          transaction.roomNo == '' || transaction.roomNo == '0' || transaction.roomNo == null
                                                              ? SizedBox.shrink()
                                                              : Text(
                                                                  "บ้านเลขที่# ${transaction.roomNo} ",
                                                                ),
                                                          Text(
                                                            "สถานะ: ${transaction.receivedStatus} ",
                                                          ),
                                                        ],
                                                      ),
                                                      transaction.Hn == '' || transaction.Hn == null
                                                          ? SizedBox.shrink()
                                                          : Text(
                                                              "เบอร์โทร# ${transaction.Hn ?? ' - '}",
                                                            ),
                                                      transaction.customerName == '' || transaction.customerName == null
                                                          ? SizedBox.shrink()
                                                          : Text(
                                                              "ชื่อ# ${transaction.customerName ?? ' - '}",
                                                            ),
                                                      Text(
                                                        "NO# ${transaction.orderNo} ",
                                                      ),
                                                      Text(
                                                        'วันที่# ${DateFormat('dd-MM-y HH:mm').format((transaction.orderDate!).add(const Duration(hours: 7)))}',
                                                      ),
                                                      Text(
                                                        'ราคารวม# ${transaction.grandTotal ?? 0}',
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                              // } else {
                                              //   return Container();
                                              // }
                                            },
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: size.height * 0.655,
                                  width: double.infinity,
                                  child: RefreshIndicator(
                                    onRefresh: () async {
                                      LoadingDialog.open(context);
                                      listOrder.clear();
                                      await getOrder(status: status, roomNo: roomNo.text == '' ? null : roomNo.text, date: stringTime);
                                      LoadingDialog.close(context);
                                    },
                                    child: listOrder.isEmpty
                                        ? SizedBox.shrink()
                                        : ListView.builder(
                                            itemCount: listOrder.length,
                                            // isLoading ? listOrder.length + 1 : listOrder.length,
                                            itemBuilder: (context, index) {
                                              // if (index == listOrder.length && isLoading) {
                                              //   return _buildProgressIndicator();
                                              // } else if (index < listOrder.length) {
                                              var transaction = listOrder[index];
                                              return InkWell(
                                                onTap: () async {
                                                  // await capturePngPag();
                                                  // Printing().printSummary(picture: pngBytesPag);
                                                  if (transaction.receivedStatus == 'sending' || transaction.receivedStatus == 'complete') {
                                                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                                                      return DetailOrder(transaction: transaction);
                                                    }));
                                                  } else {
                                                    final statusOrder = await showDialog(
                                                        barrierDismissible: false,
                                                        context: context,
                                                        builder: (context) {
                                                          return AlertDialog(
                                                            title: Text(
                                                              'ยืนยันการอัพเดทสถานะ',
                                                              style: TextStyle(fontWeight: FontWeight.bold),
                                                            ),
                                                            content: Text(
                                                              'ยืนยันที่จะเปลี่ยนแปลงสถานะของออเดอร์ใช่หรือไม่',
                                                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                                                            ),
                                                            actions: [
                                                              GestureDetector(
                                                                onTap: () {
                                                                  Navigator.pop(context, false);
                                                                },
                                                                child: Container(
                                                                  width: size.width * 0.3,
                                                                  height: size.height * 0.06,
                                                                  decoration: BoxDecoration(
                                                                      color: Colors.white,
                                                                      borderRadius: BorderRadius.circular(10),
                                                                      border: Border.all(color: Colors.red)),
                                                                  child: Center(
                                                                      child: Text(
                                                                    'ยกเลิก',
                                                                    style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold),
                                                                  )),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 20,
                                                              ),
                                                              GestureDetector(
                                                                onTap: () {
                                                                  Navigator.pop(context, true);
                                                                },
                                                                child: Container(
                                                                  width: size.width * 0.3,
                                                                  height: size.height * 0.06,
                                                                  decoration: BoxDecoration(
                                                                    color: Colors.blue,
                                                                    borderRadius: BorderRadius.circular(10),
                                                                  ),
                                                                  child: Center(
                                                                      child: Text(
                                                                    'ตกลง',
                                                                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                                                                  )),
                                                                ),
                                                              ),
                                                            ],
                                                          );
                                                        });

                                                    if (statusOrder == true) {
                                                      try {
                                                        if (!mounted) return;
                                                        LoadingDialog.open(context);
                                                        await OrderService.updateStatus(orderId: transaction.id!);
                                                        await getOrder(status: status, roomNo: roomNo.text == '' ? null : roomNo.text);
                                                        LoadingDialog.close(context);
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
                                                    }
                                                  }
                                                },
                                                child: Container(
                                                  margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                                                  padding: const EdgeInsets.all(10.0),
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    color: Colors.transparent,
                                                    border: Border.all(color: Colors.blue, width: 2.0),
                                                    borderRadius: BorderRadius.circular(10.0),
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          transaction.roomNo == '' || transaction.roomNo == '0' || transaction.roomNo == null
                                                              ? SizedBox.shrink()
                                                              : Text(
                                                                  "บ้านเลขที่ ${transaction.roomNo} ",
                                                                ),
                                                          Text(
                                                            "สถานะ: ${transaction.receivedStatus} ",
                                                          ),
                                                        ],
                                                      ),
                                                      transaction.Hn == '' || transaction.Hn == null
                                                          ? SizedBox.shrink()
                                                          : Text(
                                                              "เบอร์โทร# ${transaction.Hn ?? ' - '}",
                                                            ),
                                                      transaction.customerName == '' || transaction.customerName == null
                                                          ? SizedBox.shrink()
                                                          : Text(
                                                              "ชื่อ# ${transaction.customerName ?? ' - '}",
                                                            ),
                                                      Text(
                                                        "NO# ${transaction.orderNo} ",
                                                      ),
                                                      Text(
                                                        'วันที่# ${DateFormat('dd-MM-y HH:mm').format((transaction.orderDate!).add(const Duration(hours: 7)))}',
                                                      ),
                                                      Text(
                                                        'ราคารวม# ${transaction.grandTotal ?? 0}',
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                              // } else {
                                              //   return Container();
                                              // }
                                            },
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: size.height * 0.655,
                                  width: double.infinity,
                                  child: RefreshIndicator(
                                    onRefresh: () async {
                                      LoadingDialog.open(context);
                                      listOrder.clear();

                                      await getOrder(status: status, roomNo: roomNo.text == '' ? null : roomNo.text, date: stringTime);
                                      LoadingDialog.close(context);
                                    },
                                    child: listOrder.isEmpty
                                        ? SizedBox.shrink()
                                        : ListView.builder(
                                            itemCount: listOrder.length,
                                            // isLoading ? listOrder.length + 1 : listOrder.length,
                                            itemBuilder: (context, index) {
                                              // if (index == listOrder.length && isLoading) {
                                              //   return _buildProgressIndicator();
                                              // } else if (index < listOrder.length) {
                                              var transaction = listOrder[index];
                                              return InkWell(
                                                onTap: () async {
                                                  // await capturePngPag();
                                                  // Printing().printSummary(picture: pngBytesPag);
                                                  if (transaction.receivedStatus == 'sending' || transaction.receivedStatus == 'complete') {
                                                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                                                      return DetailOrder(transaction: transaction);
                                                    }));
                                                  } else {
                                                    final statusOrder = await showDialog(
                                                        barrierDismissible: false,
                                                        context: context,
                                                        builder: (context) {
                                                          return AlertDialog(
                                                            title: Text(
                                                              'ยืนยันการอัพเดทสถานะ',
                                                              style: TextStyle(fontWeight: FontWeight.bold),
                                                            ),
                                                            content: Text(
                                                              'ยืนยันที่จะเปลี่ยนแปลงสถานะของออเดอร์ใช่หรือไม่',
                                                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                                                            ),
                                                            actions: [
                                                              GestureDetector(
                                                                onTap: () {
                                                                  Navigator.pop(context, false);
                                                                },
                                                                child: Container(
                                                                  width: size.width * 0.3,
                                                                  height: size.height * 0.06,
                                                                  decoration: BoxDecoration(
                                                                      color: Colors.white,
                                                                      borderRadius: BorderRadius.circular(10),
                                                                      border: Border.all(color: Colors.red)),
                                                                  child: Center(
                                                                      child: Text(
                                                                    'ยกเลิก',
                                                                    style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold),
                                                                  )),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 20,
                                                              ),
                                                              GestureDetector(
                                                                onTap: () {
                                                                  Navigator.pop(context, true);
                                                                },
                                                                child: Container(
                                                                  width: size.width * 0.3,
                                                                  height: size.height * 0.06,
                                                                  decoration: BoxDecoration(
                                                                    color: Colors.blue,
                                                                    borderRadius: BorderRadius.circular(10),
                                                                  ),
                                                                  child: Center(
                                                                      child: Text(
                                                                    'ตกลง',
                                                                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                                                                  )),
                                                                ),
                                                              ),
                                                            ],
                                                          );
                                                        });

                                                    if (statusOrder == true) {
                                                      try {
                                                        if (!mounted) return;
                                                        LoadingDialog.open(context);
                                                        await OrderService.updateStatus(orderId: transaction.id!);
                                                        await getOrder(status: status, roomNo: roomNo.text == '' ? null : roomNo.text);
                                                        LoadingDialog.close(context);
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
                                                    }
                                                  }
                                                },
                                                child: Container(
                                                  margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                                                  padding: const EdgeInsets.all(10.0),
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    color: Colors.transparent,
                                                    border: Border.all(color: Colors.blue, width: 2.0),
                                                    borderRadius: BorderRadius.circular(10.0),
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          transaction.roomNo == '' || transaction.roomNo == '0' || transaction.roomNo == null
                                                              ? SizedBox.shrink()
                                                              : Text(
                                                                  "เลขที่ห้อง# ${transaction.roomNo} ",
                                                                ),
                                                          Text(
                                                            "สถานะ: ${transaction.receivedStatus} ",
                                                          ),
                                                        ],
                                                      ),
                                                      transaction.Hn == '' || transaction.Hn == null
                                                          ? SizedBox.shrink()
                                                          : Text(
                                                              "HN# ${transaction.Hn ?? ' - '}",
                                                            ),
                                                      transaction.customerName == '' || transaction.customerName == null
                                                          ? SizedBox.shrink()
                                                          : Text(
                                                              "ชื่อ# ${transaction.customerName ?? ' - '}",
                                                            ),
                                                      Text(
                                                        "NO# ${transaction.orderNo} ",
                                                      ),
                                                      Text(
                                                        'วันที่# ${DateFormat('dd-MM-y HH:mm').format((transaction.orderDate!).add(const Duration(hours: 7)))}',
                                                      ),
                                                      Text(
                                                        'ราคารวม# ${transaction.grandTotal ?? 0}',
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                              // } else {
                                              //   return Container();
                                              // }
                                            },
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // listOrder.isEmpty
                //     ? GestureDetector(
                //         onTap: () async {
                //           listOrder.clear();
                //           await getOrder(status: status);
                //         },
                //         child: SizedBox(
                //           height: size.height * 0.705,
                //           child: Center(
                //             child: Text('ไม่พบข้อมูล'),
                //           ),
                //         ),
                //       )
                //     : Padding(
                //         padding: const EdgeInsets.all(10.0),
                //         child: Column(
                //           children: [
                //             SizedBox(
                //               height: size.height * 0.705,
                //               width: double.infinity,
                //               child: ListView.builder(
                //                 itemCount: listOrder.length,
                //                 // isLoading ? listOrder.length + 1 : listOrder.length,
                //                 itemBuilder: (context, index) {
                //                   // if (index == listOrder.length && isLoading) {
                //                   //   return _buildProgressIndicator();
                //                   // } else if (index < listOrder.length) {
                //                   var transaction = listOrder[index];
                //                   return InkWell(
                //                     onTap: () async {
                //                       // await capturePngPag();
                //                       // Printing().printSummary(picture: pngBytesPag);
                //                       if (transaction.receivedStatus == 'sending' || transaction.receivedStatus == 'complete') {
                //                         Navigator.push(context, MaterialPageRoute(builder: (context) {
                //                           return DetailOrder(transaction: transaction);
                //                         }));
                //                       } else {
                //                         final statusOrder = await showDialog(
                //                             barrierDismissible: false,
                //                             context: context,
                //                             builder: (context) {
                //                               return AlertDialog(
                //                                 title: Text(
                //                                   'ยืนยันการอัพเดทสถานะ',
                //                                   style: TextStyle(fontWeight: FontWeight.bold),
                //                                 ),
                //                                 content: Text(
                //                                   'ยืนยันที่จะเปลี่ยนแปลงสถานะของออเดอร์ใช่หรือไม่',
                //                                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                //                                 ),
                //                                 actions: [
                //                                   GestureDetector(
                //                                     onTap: () {
                //                                       Navigator.pop(context, false);
                //                                     },
                //                                     child: Container(
                //                                       width: size.width * 0.3,
                //                                       height: size.height * 0.06,
                //                                       decoration:
                //                                           BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.red)),
                //                                       child: Center(
                //                                           child: Text(
                //                                         'ยกเลิก',
                //                                         style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold),
                //                                       )),
                //                                     ),
                //                                   ),
                //                                   SizedBox(
                //                                     width: 20,
                //                                   ),
                //                                   GestureDetector(
                //                                     onTap: () {
                //                                       Navigator.pop(context, true);
                //                                     },
                //                                     child: Container(
                //                                       width: size.width * 0.3,
                //                                       height: size.height * 0.06,
                //                                       decoration: BoxDecoration(
                //                                         color: Colors.blue,
                //                                         borderRadius: BorderRadius.circular(10),
                //                                       ),
                //                                       child: Center(
                //                                           child: Text(
                //                                         'ตกลง',
                //                                         style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                //                                       )),
                //                                     ),
                //                                   ),
                //                                 ],
                //                               );
                //                             });

                //                         if (statusOrder == true) {
                //                           try {
                //                             if (!mounted) return;
                //                             LoadingDialog.open(context);
                //                             await OrderService.updateStatus(orderId: transaction.id!);
                //                             await getOrder(status: status, roomNo: roomNo.text == '' ? null : roomNo.text);
                //                             LoadingDialog.close(context);
                //                           } on Exception catch (e) {
                //                             if (!mounted) return;
                //                             LoadingDialog.close(context);
                //                             showDialog(
                //                               context: context,
                //                               builder: (context) => AlertDialogYes(
                //                                 title: 'แจ้งเตือน',
                //                                 description: '$e',
                //                                 pressYes: () {
                //                                   Navigator.pop(context);
                //                                 },
                //                               ),
                //                             );
                //                           }
                //                         }
                //                       }
                //                     },
                //                     child: Container(
                //                       margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                //                       padding: const EdgeInsets.all(10.0),
                //                       width: double.infinity,
                //                       decoration: BoxDecoration(
                //                         color: Colors.transparent,
                //                         border: Border.all(color: Colors.blue, width: 2.0),
                //                         borderRadius: BorderRadius.circular(10.0),
                //                       ),
                //                       child: Column(
                //                         crossAxisAlignment: CrossAxisAlignment.start,
                //                         children: [
                //                           Row(
                //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //                             children: [
                //                               transaction.roomNo == '' || transaction.roomNo == '0' || transaction.roomNo == null
                //                                   ? SizedBox.shrink()
                //                                   : Text(
                //                                       "เลขที่ห้อง# ${transaction.roomNo} ",
                //                                     ),
                //                               Text(
                //                                 "สถานะ: ${transaction.receivedStatus} ",
                //                               ),
                //                             ],
                //                           ),
                //                           transaction.Hn == '' || transaction.Hn == null
                //                               ? SizedBox.shrink()
                //                               : Text(
                //                                   "HN# ${transaction.Hn ?? ' - '}",
                //                                 ),
                //                           transaction.customerName == '' || transaction.customerName == null
                //                               ? SizedBox.shrink()
                //                               : Text(
                //                                   "ชื่อ# ${transaction.customerName ?? ' - '}",
                //                                 ),
                //                           Text(
                //                             "NO# ${transaction.orderNo} ",
                //                           ),
                //                           Text(
                //                             'วันที่# ${DateFormat('dd-MM-y HH:mm').format((transaction.orderDate!).add(const Duration(hours: 7)))}',
                //                           ),
                //                           Text(
                //                             'ราคารวม# ${transaction.grandTotal ?? 0}',
                //                             style: TextStyle(
                //                               fontSize: 15,
                //                               fontWeight: FontWeight.bold,
                //                             ),
                //                           ),
                //                         ],
                //                       ),
                //                     ),
                //                   );
                //                   // } else {
                //                   //   return Container();
                //                   // }
                //                 },
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

  Widget _buildProgressIndicator() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
