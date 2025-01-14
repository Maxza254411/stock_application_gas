import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stock_application_gas/constants.dart';
import 'package:stock_application_gas/store/%20dailysales/%20dailySalesPage.dart';
import 'package:stock_application_gas/store/%20dailysales/cardReport.dart';
import 'package:stock_application_gas/widgets/Dialog.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart' as picker;
import 'package:stock_application_gas/widgets/LoadingDialog.dart';

class Profit extends StatefulWidget {
  const Profit({super.key});

  @override
  State<Profit> createState() => _ProfitState();
}

class _ProfitState extends State<Profit> {
  String pickerDate = DateFormat('dd/MM/y').format(DateTime.now());
  String? stringTime;
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
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => DailySalesPage(),
                ),
                (route) => false);
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(''),
            Text(
              'ผลกำไร/ขาดทุน',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            Image.asset(
              'assets/icons/backgroundAsset_LoGo_24x 2.png',
              scale: 10,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
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
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  reportTank.length,
                  (index) {
                    return CardReport(
                      date: dataTablerow[index]['date'],
                      productcode: dataTablerow[index]['productcode'],
                      type: dataTablerow[index]['type'],
                      brand: dataTablerow[index]['brand'],
                      claimtank: dataTablerow[index]['capital'],
                      sum: dataTablerow[index]['totalamount'],
                      unit: dataTablerow[index]['unit'],
                      pice: dataTablerow[index]['pice'],
                      section: 'ทุน',
                    );
                  },
                ),
              ),
            ),
            // SingleChildScrollView(
            //   scrollDirection: Axis.vertical,
            //   child: SingleChildScrollView(
            //     scrollDirection: Axis.horizontal,
            //     child: Column(
            //       children: [
            //         DataTable(
            //           columns: <DataColumn>[
            //             DataColumn(label: Text('วันที่')),
            //             DataColumn(label: Text('รหัสสินค้า')),
            //             DataColumn(label: Text('ประเภท')),
            //             DataColumn(label: Text('น้ำหนัก')),
            //             DataColumn(label: Text('ยี่ห้อ')),
            //             DataColumn(label: Text('ราคา')),
            //             DataColumn(label: Text('จำนวน')),
            //             DataColumn(label: Text('ถังเคลม')),
            //             DataColumn(label: Text('ประเภทการจ่าย')),
            //             DataColumn(label: Text('จำวนรวม')),
            //           ],
            //           rows: <DataRow>[
            //             DataRow(
            //               color: WidgetStateProperty.resolveWith<Color?>(
            //                 (Set<WidgetState> states) {
            //                   return Colors.grey[200];
            //                 },
            //               ),
            //               cells: <DataCell>[
            //                 DataCell(Text('11-12-2025')),
            //                 DataCell(Text('0734')),
            //                 DataCell(Text('ถังใหม่')),
            //                 DataCell(Text('15')),
            //                 DataCell(Text('ปตท')),
            //                 DataCell(Text('425')),
            //                 DataCell(Text('2')),
            //                 DataCell(Text('ปกติ')),
            //                 DataCell(Text('เงินสด')),
            //                 DataCell(Text('160')),
            //               ],
            //             ),
            //             DataRow(
            //               color: WidgetStateProperty.resolveWith<Color?>(
            //                 (Set<WidgetState> states) {
            //                   return Colors.white;
            //                 },
            //               ),
            //               cells: <DataCell>[
            //                 DataCell(Text('11-12-2025')),
            //                 DataCell(Text('0742')),
            //                 DataCell(Text('น้ำแก็ส')),
            //                 DataCell(Text('04')),
            //                 DataCell(Text('ส.ว.ย')),
            //                 DataCell(Text('500')),
            //                 DataCell(Text('2')),
            //                 DataCell(Text('ปกติ')),
            //                 DataCell(Text('โอน')),
            //                 DataCell(Text('160')),
            //               ],
            //             ),
            //             DataRow(
            //               color: WidgetStateProperty.resolveWith<Color?>(
            //                 (Set<WidgetState> states) {
            //                   return Colors.grey[200];
            //                 },
            //               ),
            //               cells: <DataCell>[
            //                 DataCell(Text('11-12-2025')),
            //                 DataCell(Text('0734')),
            //                 DataCell(Text('ถังใหม่')),
            //                 DataCell(Text('15')),
            //                 DataCell(Text('ปตท')),
            //                 DataCell(Text('425')),
            //                 DataCell(Text('2')),
            //                 DataCell(Text('ปกติ')),
            //                 DataCell(Text('เงินสด')),
            //                 DataCell(Text('160')),
            //               ],
            //             ),
            //           ],
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
      // body: SingleChildScrollView(
      //   scrollDirection: Axis.vertical,
      //   child: SingleChildScrollView(
      //     scrollDirection: Axis.horizontal,
      //     child: Column(
      //       children: [
      //         DataTable(
      //           columns: <DataColumn>[
      //             DataColumn(label: Text('วันที่')),
      //             DataColumn(label: Text('รหัสสินค้า')),
      //             DataColumn(label: Text('ประเภท')),
      //             DataColumn(label: Text('น้ำหนัก')),
      //             DataColumn(label: Text('ยี่ห้อ')),
      //             DataColumn(label: Text('ราคา')),
      //             DataColumn(label: Text('จำนวน')),
      //             DataColumn(label: Text('ทุน')),
      //             DataColumn(label: Text('ประเภทการจ่าย')),
      //             DataColumn(label: Text('จำวนรวม')),
      //           ],
      //           rows: <DataRow>[
      //             DataRow(
      //               color: WidgetStateProperty.resolveWith<Color?>(
      //                 (Set<WidgetState> states) {
      //                   return Colors.grey[200];
      //                 },
      //               ),
      //               cells: <DataCell>[
      //                 DataCell(Text('11-12-2025')),
      //                 DataCell(Text('0734')),
      //                 DataCell(Text('ถังใหม่')),
      //                 DataCell(Text('15')),
      //                 DataCell(Text('ปตท')),
      //                 DataCell(Text('425')),
      //                 DataCell(Text('2')),
      //                 DataCell(Text('250')),
      //                 DataCell(Text('เงินสด')),
      //                 DataCell(Text('160')),
      //               ],
      //             ),
      //             DataRow(
      //               color: WidgetStateProperty.resolveWith<Color?>(
      //                 (Set<WidgetState> states) {
      //                   return Colors.white;
      //                 },
      //               ),
      //               cells: <DataCell>[
      //                 DataCell(Text('11-12-2025')),
      //                 DataCell(Text('0742')),
      //                 DataCell(Text('น้ำแก็ส')),
      //                 DataCell(Text('04')),
      //                 DataCell(Text('ส.ว.ย')),
      //                 DataCell(Text('500')),
      //                 DataCell(Text('2')),
      //                 DataCell(Text('-100')),
      //                 DataCell(Text('โอน')),
      //                 DataCell(Text('160')),
      //               ],
      //             ),
      //             DataRow(
      //               color: WidgetStateProperty.resolveWith<Color?>(
      //                 (Set<WidgetState> states) {
      //                   return Colors.grey[200];
      //                 },
      //               ),
      //               cells: <DataCell>[
      //                 DataCell(Text('11-12-2025')),
      //                 DataCell(Text('0734')),
      //                 DataCell(Text('ถังใหม่')),
      //                 DataCell(Text('15')),
      //                 DataCell(Text('ปตท')),
      //                 DataCell(Text('425')),
      //                 DataCell(Text('2')),
      //                 DataCell(Text('100')),
      //                 DataCell(Text('เงินสด')),
      //                 DataCell(Text('160')),
      //               ],
      //             ),
      //           ],
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
