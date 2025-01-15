import 'package:flutter/material.dart';
import 'package:stock_application_gas/constants.dart';
import 'package:stock_application_gas/diver/StorageReport/storageReportConfirm.dart';
import 'package:stock_application_gas/diver/diverMenu/diverMenuPage.dart';
import 'package:stock_application_gas/widgets/Dialog.dart';

class Storagereportpage extends StatefulWidget {
  const Storagereportpage({super.key});

  @override
  State<Storagereportpage> createState() => _StoragereportpageState();
}

class _StoragereportpageState extends State<Storagereportpage> {
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
                  builder: (context) => Divermenupage(),
                ),
                (route) => false);
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'รายการเก็บถังซ้อม/เข้าโกดัง',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Image.asset(
              'assets/icons/backgroundAsset_LoGo_24x 2.png',
              scale: 10,
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: size.height * 0.5,
          child: ListView.builder(
            // controller: _scrollController,
            itemCount: gas_km.length,
            itemBuilder: (context, index) {
              final items = gas_km[index];
              return Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    leading: Container(
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
                    title: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                '${gas_km[index]['brand1']}',
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                '${gas_km[index]['sum1']}',
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                '${gas_km[index]['unit']}',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                '${gas_km[index]['brand2']}',
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                '${gas_km[index]['sum2']}',
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                '${gas_km[index]['unit']}',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    // trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () async {},
                  ),
                  Divider(),
                ],
              );
            },
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
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onPressed: () async {
                final ok = await showDialog(
                  context: context,
                  builder: (context) => AlertDialogYesNo(
                    title: 'แจ้งเตือน',
                    description: 'คุณต้องการบันทึกรายการต่อไปนี้ใช่หรือไม่',
                    pressYes: () {
                      Navigator.pop(context, true);
                    },
                    pressNo: () {
                      Navigator.pop(context, false);
                    },
                  ),
                );
                if (ok == true) {
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => StorageReportConfirm()), (route) => false);
                }
              },
              child: Text(
                'บันทึกการทำรายการ',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
