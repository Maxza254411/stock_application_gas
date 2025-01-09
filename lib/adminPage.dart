import 'package:flutter/material.dart';
import 'package:stock_application_gas/constants.dart';
import 'package:stock_application_gas/login/loginPage.dart';
import 'package:stock_application_gas/store/stockStore/storePage.dart';
import 'package:stock_application_gas/widgetHub/waterMark.dart';

class Adminpage extends StatefulWidget {
  const Adminpage({super.key});

  @override
  State<Adminpage> createState() => _AdminpageState();
}

class _AdminpageState extends State<Adminpage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: size.height * 0.1,
        automaticallyImplyLeading: false,
        backgroundColor: kbutton,
        title: Center(
          child: Text(
            'หน้าการจัดการของเเอดมิน',
            style: TextStyle(color: kTextButtonColor, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Watermark(
        backgroundImage: const AssetImage('assets/images/Gas Logo.png'),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'โกดังสินค้า',
                    style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Divider(),
                  cardItems.isNotEmpty
                      ? SizedBox(
                          width: double.infinity,
                          height: size.height * 0.5,
                          child: ListView.builder(
                            // controller: _scrollController,
                            itemCount: cardItems.length,
                            itemBuilder: (context, index) {
                              final items = cardItems[index];
                              return Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  ListTile(
                                    leading: Icon(
                                      Icons.store,
                                      color: Colors.black,
                                      size: 24,
                                    ),
                                    title: Text(
                                      '${items['nameStore']}',
                                      style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                                    ),
                                    trailing: Icon(Icons.arrow_forward_ios),
                                    onTap: () async {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Storepage(
                                                  store: items['nameStore'] ?? '',
                                                )),
                                      );
                                    },
                                  ),
                                  Divider(),
                                  // Container(
                                  //   width: double.infinity,
                                  //   height: size.height * 0.06,
                                  //   decoration: BoxDecoration(
                                  //     color: kbutton,
                                  //     borderRadius: BorderRadius.circular(10),
                                  //   ),
                                  //   child: Center(
                                  //     child: Text(
                                  //       '${items['nameStore']}',
                                  //       style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                                  //     ),
                                  //   ),
                                  // ),
                                  // GestureDetector(
                                  //   onTap: () {
                                  //     Navigator.push(
                                  //       context,
                                  //       MaterialPageRoute(
                                  //           builder: (context) => Storepage(
                                  //                 store: items['nameStore'] ?? '',
                                  //               )),
                                  //     );
                                  //   },
                                  //   child: Padding(
                                  //     padding: const EdgeInsets.all(8.0),
                                  //     child: Container(
                                  //       width: size.width * 0.3,
                                  //       height: size.height * 0.06,
                                  //       decoration: BoxDecoration(
                                  //         color: Colors.grey,
                                  //         borderRadius: BorderRadius.circular(10),
                                  //       ),
                                  //       child: Center(
                                  //         child: Text(
                                  //           'ตั้งค่าร้านค้า',
                                  //           style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              );
                            },
                          ),
                        )
                      : Center(child: Text('ขนะนี้ไม่มีร้านค้าที่ตั้บงเอาไว้'))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
