import 'package:flutter/material.dart';
import 'package:stock_application_gas/constants.dart';

class CardReport extends StatefulWidget {
  CardReport({
    super.key,
    required this.date,
    required this.productcode,
    required this.type,
    required this.brand,
    required this.claimtank,
    required this.sum,
    required this.unit,
    required this.pice,
    required this.section,
  });

  @override
  State<CardReport> createState() => _CardReportState();
  String date;
  String productcode;
  String type;
  String brand;
  String claimtank;
  String sum;
  String unit;
  String pice;
  String section;
}

class _CardReportState extends State<CardReport> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        width: size.width * 1,
        // height: size.height * 0.25,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.productcode,
                        style: TextStyle(color: kbutton, fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.date,
                        style: TextStyle(color: const Color.fromARGB(255, 172, 172, 172), fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ประเภท',
                            style: TextStyle(color: const Color.fromARGB(255, 172, 172, 172), fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            widget.type,
                            style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ยี่ห้อ',
                            style: TextStyle(color: const Color.fromARGB(255, 172, 172, 172), fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            widget.brand,
                            style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.section,
                            style: TextStyle(color: const Color.fromARGB(255, 172, 172, 172), fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            widget.claimtank,
                            style: TextStyle(color: widget.section != 'ทุน' ? Colors.black : Colors.green, fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'รวม X${widget.unit}',
                        style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '฿${widget.pice}',
                        style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
              Divider(
                thickness: 5,
                color: Color.fromARGB(255, 235, 234, 234),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'รวมทั้งหมด',
                        style: TextStyle(color: kbutton, fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '฿${widget.sum}',
                        style: TextStyle(color: kbutton, fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
