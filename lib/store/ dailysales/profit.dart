import 'package:flutter/material.dart';
import 'package:stock_application_gas/constants.dart';
import 'package:stock_application_gas/store/%20dailysales/%20dailySalesPage.dart';

class Profit extends StatefulWidget {
  const Profit({super.key});

  @override
  State<Profit> createState() => _ProfitState();
}

class _ProfitState extends State<Profit> {
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
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            children: [
              DataTable(
                columns: <DataColumn>[
                  DataColumn(label: Text('วันที่')),
                  DataColumn(label: Text('รหัสสินค้า')),
                  DataColumn(label: Text('ประเภท')),
                  DataColumn(label: Text('น้ำหนัก')),
                  DataColumn(label: Text('ยี่ห้อ')),
                  DataColumn(label: Text('ราคา')),
                  DataColumn(label: Text('จำนวน')),
                  DataColumn(label: Text('ทุน')),
                  DataColumn(label: Text('ประเภทการจ่าย')),
                  DataColumn(label: Text('จำวนรวม')),
                ],
                rows: <DataRow>[
                  DataRow(
                    color: WidgetStateProperty.resolveWith<Color?>(
                      (Set<WidgetState> states) {
                        return Colors.grey[200];
                      },
                    ),
                    cells: <DataCell>[
                      DataCell(Text('11-12-2025')),
                      DataCell(Text('0734')),
                      DataCell(Text('ถังใหม่')),
                      DataCell(Text('15')),
                      DataCell(Text('ปตท')),
                      DataCell(Text('425')),
                      DataCell(Text('2')),
                      DataCell(Text('250')),
                      DataCell(Text('เงินสด')),
                      DataCell(Text('160')),
                    ],
                  ),
                  DataRow(
                    color: WidgetStateProperty.resolveWith<Color?>(
                      (Set<WidgetState> states) {
                        return Colors.white;
                      },
                    ),
                    cells: <DataCell>[
                      DataCell(Text('11-12-2025')),
                      DataCell(Text('0742')),
                      DataCell(Text('น้ำแก็ส')),
                      DataCell(Text('04')),
                      DataCell(Text('ส.ว.ย')),
                      DataCell(Text('500')),
                      DataCell(Text('2')),
                      DataCell(Text('-100')),
                      DataCell(Text('โอน')),
                      DataCell(Text('160')),
                    ],
                  ),
                  DataRow(
                    color: WidgetStateProperty.resolveWith<Color?>(
                      (Set<WidgetState> states) {
                        return Colors.grey[200];
                      },
                    ),
                    cells: <DataCell>[
                      DataCell(Text('11-12-2025')),
                      DataCell(Text('0734')),
                      DataCell(Text('ถังใหม่')),
                      DataCell(Text('15')),
                      DataCell(Text('ปตท')),
                      DataCell(Text('425')),
                      DataCell(Text('2')),
                      DataCell(Text('100')),
                      DataCell(Text('เงินสด')),
                      DataCell(Text('160')),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
