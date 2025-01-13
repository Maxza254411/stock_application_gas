import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stock_application_gas/constants.dart';
import 'package:stock_application_gas/store/setPrice/%20Editprice.dart';
import 'package:stock_application_gas/store/storePage.dart';

class Setpicepage extends StatefulWidget {
  Setpicepage({super.key, this.title});

  @override
  State<Setpicepage> createState() => _SetpicepageState();
  String? title;
}

class _SetpicepageState extends State<Setpicepage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  String? headtitle;
  @override
  void initState() {
    super.initState();
    getprefs();
  }

  getprefs() async {
    final SharedPreferences prefs = await _prefs;
    final title = prefs.getString('title');
    setState(() {
      headtitle = title ?? '';
    });
  }

  int selectindex = 0;
  String? productselect;
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
                  builder: (context) => Storepage(
                    store: headtitle!,
                  ),
                ),
                (route) => false);
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(''),
            Text(
              'กำหนดราคาสินค้า',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            Image.asset(
              'assets/icons/backgroundAsset_LoGo_24x 2.png',
              scale: 10,
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(
                    producttype.length,
                    (index) {
                      productselect = selectindex == 0 ? 'ถังใหม่' : 'น้ำแก็ส';
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectindex = index;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: selectindex == index ? kbutton : Colors.white,
                              border: Border.all(color: kbutton)),
                          width: size.width * 0.3,
                          height: size.height * 0.06,
                          child: Center(
                            child: Text(
                              producttype[index]['name'] ?? '',
                              style: TextStyle(fontSize: 20, color: selectindex == index ? Colors.white : kbutton, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(
                width: size.width,
                height: size.height * 0.7,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: priceCategory.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Container(
                              height: size.height * 0.2,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.grey[300],
                              ),
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${priceCategory[index]['km']}',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    '${priceCategory[index]['pricecategory1']}',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    '${priceCategory[index]['pricecategory2']}',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    '${priceCategory[index]['pricecategory3']}',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    '${priceCategory[index]['pricecategory4']}',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            flex: 1,
                            child: Container(
                              height: size.height * 0.2,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.grey[300],
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${priceCategory[index]['brand1']}',
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 8),
                                    Text(NumberFormat('#,##0', 'en_US').format(int.parse(priceCategory[index]['sumgas1.1'] ?? '0')),
                                        style: TextStyle(fontSize: 18)),
                                    Text(NumberFormat('#,##0', 'en_US').format(int.parse(priceCategory[index]['sumgas1.2'] ?? '0')),
                                        style: TextStyle(fontSize: 18)),
                                    Text(NumberFormat('#,##0', 'en_US').format(int.parse(priceCategory[index]['sumgas1.3'] ?? '0')),
                                        style: TextStyle(fontSize: 18)),
                                    Text(NumberFormat('#,##0', 'en_US').format(int.parse(priceCategory[index]['sumgas1.4'] ?? '0')),
                                        style: TextStyle(fontSize: 18)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            flex: 1,
                            child: Container(
                              height: size.height * 0.2,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.grey[300],
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      priceCategory[index]['brand2'] ?? '',
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 8),
                                    Text(NumberFormat('#,##0', 'en_US').format(int.parse(priceCategory[index]['sumgas2.1'] ?? '0')),
                                        style: TextStyle(fontSize: 18)),
                                    Text(NumberFormat('#,##0', 'en_US').format(int.parse(priceCategory[index]['sumgas2.2'] ?? '0')),
                                        style: TextStyle(fontSize: 18)),
                                    Text(NumberFormat('#,##0', 'en_US').format(int.parse(priceCategory[index]['sumgas2.3'] ?? '0')),
                                        style: TextStyle(fontSize: 18)),
                                    Text(NumberFormat('#,##0', 'en_US').format(int.parse(priceCategory[index]['sumgas2.4'] ?? '0')),
                                        style: TextStyle(fontSize: 18)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(8),
        child: SizedBox(
          height: size.height * 0.07,
          width: size.width * 0.4,
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: kbutton,
                // side: BorderSide(color: textColor),
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onPressed: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Editprice(
                              productselect: productselect,
                            )));
              },
              child: Text(
                'แก้ไขราคาสินค้า',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

List<Map<String, String>> price = [
  {
    'km': '4 กก',
    'brand1': 'ปตท',
    'sum1': '9',
    'brand2': 'ส.ว.ย',
    'sum2': '4',
    'unit': 'ถัง',
  },
  {
    'km': '7 กก',
    'brand1': 'ปตท',
    'sum1': '5',
    'brand2': 'ส.ว.ย',
    'sum2': '1',
    'unit': 'ถัง',
  },
  {
    'km': '15 กก',
    'brand1': 'ปตท',
    'sum1': '2',
    'brand2': 'ส.ว.ย',
    'sum2': '10',
    'unit': 'ถัง',
  },
  {
    'km': '48 กก',
    'brand1': 'ปตท',
    'sum1': '9',
    'brand2': 'ส.ว.ย',
    'sum2': '16',
    'unit': 'ถัง',
  },
];
List<Map<String, String>> producttype = [
  {
    'name': 'ถังใหม่',
  },
  {
    'name': 'น้ำแก็ส',
  },
];
// List<Map<String, String>> priceCategory = [
//   {
//     'km': '4 กก',
//     'pricecategory1': 'ราคารับหน้าร้าน',
//     'pricecategory2': 'ราคารวมส่ง',
//     'pricecategory3': 'ราคากรณีซื้อเยอะ',
//     'pricecategory4': 'ราคารับฝากเติม',
//     'brand1': 'ปตท',
//     'brand2': 'ส.ว.ย',
//     'sumgas1': '100',
//     'sumgas2': '150',
//   },
//   {
//     'km': '7 กก',
//     'pricecategory1': 'ราคารับหน้าร้าน',
//     'pricecategory2': 'ราคารวมส่ง',
//     'pricecategory3': 'ราคากรณีซื้อเยอะ',
//     'pricecategory4': 'ราคารับฝากเติม',
//     'brand1': 'ปตท',
//     'brand2': 'ส.ว.ย',
//     'sumptgas': '100',
//     'sumgas2': '150',
//   },
//   {
//     'km': '15 กก',
//     'pricecategory1': 'ราคารับหน้าร้าน',
//     'pricecategory2': 'ราคารวมส่ง',
//     'pricecategory3': 'ราคากรณีซื้อเยอะ',
//     'pricecategory4': 'ราคารับฝากเติม',
//     'brand1': 'ปตท',
//     'brand2': 'ส.ว.ย',
//     'sumptgas': '100',
//     'sumgas2': '150',
//   },
//   {
//     'km': '48 กก',
//     'pricecategory1': 'ราคารับหน้าร้าน',
//     'pricecategory2': 'ราคารวมส่ง',
//     'pricecategory3': 'ราคากรณีซื้อเยอะ',
//     'pricecategory4': 'ราคารับฝากเติม',
//     'brand1': 'ปตท',
//     'brand2': 'ส.ว.ย',
//     'sumptgas': '100',
//     'sumgas2': '150',
//   },
// ];
