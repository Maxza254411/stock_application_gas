import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stock_application_gas/constants.dart';
import 'package:stock_application_gas/diver/diverMenu/diverMenuPage.dart';
import 'package:stock_application_gas/store/storePage.dart';

class Sellreport extends StatefulWidget {
  Sellreport({super.key, required this.check});

  @override
  State<Sellreport> createState() => _SellreportState();
  int check;
}

class _SellreportState extends State<Sellreport> {
  String headtitle = '';
  int selectindex = 0;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  getprefs() async {
    final SharedPreferences prefs = await _prefs;
    final title = prefs.getString('title');
    setState(() {
      headtitle = title ?? '';
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getprefs();
  }

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
            widget.check == 1
                ? Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Storepage(
                        store: headtitle,
                      ),
                    ),
                    (route) => false)
                : Navigator.pushAndRemoveUntil(
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
            Text(''),
            Text(
              'รายงานรวมถังอัดบันจุ',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            Image.asset(
              'assets/icons/backgroundAsset_LoGo_24x 2.png',
              scale: 10,
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(
                  sellreport.length,
                  (index) {
                    // nametank = gastank[index]['nameTank'];

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectindex = index;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: selectindex == index ? kbutton : Colors.white,
                              border: Border.all(color: kbutton)),
                          width: size.width * 0.3,
                          height: size.height * 0.06,
                          child: Center(
                              child: Text(
                            sellreport[index]['nameTank'] ?? '',
                            style: TextStyle(fontSize: 20, color: selectindex == index ? Colors.white : kbutton, fontWeight: FontWeight.bold),
                          )),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          SizedBox(
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
                    ),
                    Divider(),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
