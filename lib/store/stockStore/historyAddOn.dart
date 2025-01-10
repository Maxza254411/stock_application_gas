import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stock_application_gas/constants.dart';
import 'package:stock_application_gas/store/setPrice/%20editprice.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart' as picker;
import 'package:stock_application_gas/widgets/LoadingDialog.dart';
import 'dart:ui' as ui;

class Historyaddon extends StatefulWidget {
  Historyaddon({super.key});

  @override
  State<Historyaddon> createState() => _HistoryaddonState();
}

class _HistoryaddonState extends State<Historyaddon> {
  String pickerDate = DateFormat('dd/MM/y').format(DateTime.now());
  String? stringTime;
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
            Navigator.pop(context);
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(''),
            Text(
              'ประวัติรายการเพิ่มลด',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            Image.asset(
              'assets/images/Gas Logo.png',
              scale: 10,
            ),
          ],
        ),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
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
                    headerColor: kbutton,
                    backgroundColor: Colors.white,
                    itemStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
                    doneStyle: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
                    cancelStyle: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
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
                    // await getOrder(status: status, roomNo: roomNo.text == '' ? null : roomNo.text, date: stringTime);
                    if (!mounted) return;
                    LoadingDialog.close(context);
                  },
                );
              },
              child: Container(
                padding: EdgeInsets.all(8),
                width: double.infinity,
                height: size.height * 0.06,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 198, 196, 196),
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
          SizedBox(
            width: double.infinity,
            height: size.height * 0.8,
            child: ListView.builder(
              // controller: _scrollController,
              itemCount: history.length,
              itemBuilder: (context, index) {
                final items = history[index];
                return Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                      padding: const EdgeInsets.all(10.0),
                      width: double.infinity,
                      height: size.height * 0.15,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(history[index]['name'] ?? ''),
                              Text(history[index]['time'] ?? ''),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(flex: 1, child: Text(history[index]['km'] ?? '')),
                              Expanded(flex: 1, child: Text(history[index]['brand1'] ?? '')),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  history[index]['sum1'] ?? '',
                                  style:
                                      TextStyle(color: history[index]['sum1'] == '9' || history[index]['sum1'] == '8' ? Colors.green : Colors.black),
                                ),
                              ),
                              Expanded(flex: 1, child: Text(history[index]['brand2'] ?? '')),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  history[index]['sum2'] ?? '',
                                  style: TextStyle(color: history[index]['sum2'] == '7' ? Colors.red : Colors.black),
                                ),
                              ),
                              Expanded(flex: 1, child: Text(history[index]['unit'] ?? '')),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Text(
                                    history[index]['km2'] ?? '',
                                  )),
                              Expanded(flex: 1, child: Text(history[index]['brand1'] ?? '')),
                              Expanded(
                                  flex: 1,
                                  child: Text(
                                    history[index]['sum3'] ?? '',
                                    style: TextStyle(color: history[index]['sum3'] == '5' ? Colors.red : Colors.black),
                                  )),
                              Expanded(flex: 1, child: Text(history[index]['brand2'] ?? '')),
                              Expanded(flex: 1, child: Text(history[index]['sum4'] ?? '')),
                              Expanded(flex: 1, child: Text(history[index]['unit'] ?? '')),
                            ],
                          ),
                          history[index]['km3'] != null
                              ? Row(
                                  children: [
                                    Expanded(flex: 1, child: Text(history[index]['km3'] ?? '')),
                                    Expanded(flex: 1, child: Text(history[index]['brand1'] ?? '')),
                                    Expanded(flex: 1, child: Text(history[index]['sum5'] ?? '')),
                                    Expanded(flex: 1, child: Text(history[index]['brand2'] ?? '')),
                                    Expanded(
                                        flex: 1,
                                        child: Text(
                                          history[index]['sum6'] ?? '',
                                          style: TextStyle(color: history[index]['sum6'] == '25' ? Colors.green : Colors.black),
                                        )),
                                    Expanded(flex: 1, child: Text(history[index]['unit'] ?? '')),
                                  ],
                                )
                              : SizedBox.shrink()
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      )),
    );
  }
}
