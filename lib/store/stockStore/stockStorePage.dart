import 'package:flutter/material.dart';
import 'package:stock_application_gas/constants.dart';
import 'package:stock_application_gas/store/addOnItem.dart';
import 'package:stock_application_gas/widgetHub/waterMark.dart';

class Stockstorepage extends StatefulWidget {
  const Stockstorepage({super.key});

  @override
  State<Stockstorepage> createState() => _StockstorepageState();
}

class _StockstorepageState extends State<Stockstorepage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
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
              'สต็อกสินค้า',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            Image.asset(
              'assets/images/Gas Logo.png',
              scale: 10,
            ),
          ],
        ),
      ),
      body: Watermark(
        backgroundImage: const AssetImage(
          'assets/images/Gas Logo.png',
        ),
        child: Column(
          children: [
            cardItems.isNotEmpty
                ? SizedBox(
                    width: double.infinity,
                    height: size.height * 0.85,
                    child: ListView.builder(
                      // controller: _scrollController,
                      itemCount: gastank.length,
                      itemBuilder: (context, index) {
                        final items = gastank[index];
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: size.width * 0.5,
                                    height: size.height * 0.06,
                                    decoration: BoxDecoration(
                                      color: kbutton,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '${items['nameTank']}',
                                        style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => Addonitem(title: items['nameTank'] ?? '')));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: size.width * 0.3,
                                      height: size.height * 0.06,
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'เพิ่ม/ลด',
                                          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: size.width * 0.9,
                              height: size.height * 1,
                              decoration: BoxDecoration(
                                color: kbutton.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: List.generate(
                                  gas_km.length, // จำนวน items ในลิสต์
                                  (index) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: size.height * 0.02,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: kbutton,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          width: size.width * 0.3,
                                          height: size.height * 0.05,
                                          child: Center(
                                            child: Text(
                                              '${gas_km[index]['km']}',
                                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Colors.blue,
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              width: size.width * 0.3,
                                              height: size.height * 0.06,
                                              child: Center(
                                                child: Text(
                                                  '${gas_km[index]['brand1']}',
                                                  style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                            // ใช้ Expanded เพื่อให้ข้อความตรงกัน
                                            Expanded(
                                              child: Center(
                                                child: Text(
                                                  '${gas_km[index]['sum1']}',
                                                  style: TextStyle(fontSize: 20),
                                                ),
                                              ),
                                            ),
                                            Text(
                                              'จำนวน',
                                              textAlign: TextAlign.right,
                                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                color: const Color.fromARGB(255, 227, 45, 12),
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              width: size.width * 0.3,
                                              height: size.height * 0.06,
                                              child: Center(
                                                child: Text(
                                                  '${gas_km[index]['brand2']}',
                                                  style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                            // ใช้ Expanded เพื่อให้ข้อความตรงกัน
                                            Expanded(
                                              child: Center(
                                                child: Text(
                                                  '${gas_km[index]['sum2']}',
                                                  style: TextStyle(fontSize: 20),
                                                ),
                                              ),
                                            ),
                                            Text(
                                              'จำนวน',
                                              textAlign: TextAlign.right,
                                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  )
                : Center(child: Text('ขนะนี้ไม่มีร้านค้าที่ตั้บงเอาไว้'))
          ],
        ),
      ),
    );
  }
}
