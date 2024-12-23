import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stock_application_gas/Models/reservedatas.dart';
import 'package:stock_application_gas/selectPayment/selectPyment.dart';

class DetailOrder extends StatefulWidget {
  const DetailOrder({super.key, required this.transaction});
  final Reservedatas transaction;

  @override
  State<DetailOrder> createState() => _DetailOrderState();
}

class _DetailOrderState extends State<DetailOrder> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('รายละเอียด'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.transaction.roomNo == '' || widget.transaction.roomNo == '0' || widget.transaction.roomNo == null
                  ? SizedBox.shrink()
                  : Text(
                      'บ้านเลขที่# ${widget.transaction.roomNo}',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
              widget.transaction.Hn == '' || widget.transaction.Hn == '0' || widget.transaction.Hn == null
                  ? SizedBox.shrink()
                  : Text(
                      'เบอร์โทร# ${widget.transaction.Hn}',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
              widget.transaction.customerName == '' || widget.transaction.customerName == '0' || widget.transaction.customerName == null
                  ? SizedBox.shrink()
                  : Text(
                      'ชื่อ# ${widget.transaction.customerName}',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
              Text(
                'No# ${widget.transaction.orderNo}',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                'วันที่# ${DateFormat('dd-MM-y HH:mm').format((widget.transaction.orderDate!).add(const Duration(hours: 7)))}',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                height: size.height * 0.45,
                child: SingleChildScrollView(
                  child: Column(
                    children: List.generate(
                        widget.transaction.orderItems!.length,
                        (index) => Container(
                              margin: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(color: Colors.blue, width: 2.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.transaction.orderItems?[index].product?.name ?? ' - ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('จำนวน ${widget.transaction.orderItems?[index].quantity ?? 0}'),
                                        Text('ราคา ${widget.transaction.orderItems?[index].total!.toStringAsFixed(2) ?? 0}'),
                                      ],
                                    ),
                                    // widget.transaction.orderItems?[index].remark == ' ' ||
                                    widget.transaction.orderItems?[index].remark == '' || widget.transaction.orderItems?[index].remark == null
                                        ? SizedBox.shrink()
                                        : Text('Note# ${widget.transaction.orderItems?[index].remark ?? ''}'),
                                  ],
                                ),
                              ),
                            )),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              widget.transaction.serviceCharge == 0 && widget.transaction.vat == 0
                  ? SizedBox.shrink()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'ยอดรวมสุทธิ#',
                          style: TextStyle(
                            fontSize: widget.transaction.receivedStatus == 'complete' ? 22 : 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          widget.transaction.total?.toStringAsFixed(2) ?? 0.toStringAsFixed(2),
                          style: TextStyle(
                            fontSize: widget.transaction.receivedStatus == 'complete' ? 22 : 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
              widget.transaction.discount == 0 && widget.transaction.discount == null
                  ? SizedBox.shrink()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'ส่วนลด#',
                          style: TextStyle(
                            fontSize: widget.transaction.receivedStatus == 'complete' ? 22 : 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          widget.transaction.discount?.toStringAsFixed(2) ?? 0.toStringAsFixed(2),
                          style: TextStyle(
                            fontSize: widget.transaction.receivedStatus == 'complete' ? 22 : 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
              widget.transaction.serviceCharge == 0 || widget.transaction.serviceCharge == null
                  ? SizedBox.shrink()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Service Charge 10 %',
                          style: TextStyle(
                            fontSize: widget.transaction.receivedStatus == 'complete' ? 22 : 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          widget.transaction.serviceCharge?.toStringAsFixed(2) ?? 0.toStringAsFixed(2),
                          style: TextStyle(
                            fontSize: widget.transaction.receivedStatus == 'complete' ? 22 : 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
              widget.transaction.vat == 0 || widget.transaction.vat == null
                  ? SizedBox.shrink()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'vat#',
                          style: TextStyle(
                            fontSize: widget.transaction.receivedStatus == 'complete' ? 22 : 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          widget.transaction.vat?.toStringAsFixed(2) ?? 0.toStringAsFixed(2),
                          style: TextStyle(
                            fontSize: widget.transaction.receivedStatus == 'complete' ? 22 : 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
              widget.transaction.remark == '' || widget.transaction.remark == null
                  ? SizedBox.shrink()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Note# ',
                          style: TextStyle(
                            fontSize: widget.transaction.receivedStatus == 'complete' ? 25 : 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.73,
                          child: Text(
                            widget.transaction.remark ?? '',
                            style: TextStyle(
                              fontSize: widget.transaction.receivedStatus == 'complete' ? 25 : 25,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.end,
                            maxLines: 3,
                          ),
                        ),
                      ],
                    ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'ราคารวม#',
                    style: TextStyle(
                      fontSize: widget.transaction.receivedStatus == 'complete' ? 25 : 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.transaction.grandTotal?.toStringAsFixed(2) ?? 0.toStringAsFixed(2),
                    style: TextStyle(
                      fontSize: widget.transaction.receivedStatus == 'complete' ? 25 : 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: widget.transaction.receivedStatus == 'complete'
          ? SizedBox.shrink()
          : Padding(
              padding: const EdgeInsets.all(16),
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Selectpyment(
                      orderID: widget.transaction,
                    );
                  }));
                },
                child: Container(
                  width: size.width * 0.8,
                  height: size.height * 0.06,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                      child: Text(
                    'ชำระเงิน',
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  )),
                ),
              ),
            ),
    );
  }
}
