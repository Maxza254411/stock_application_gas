import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stock_application_gas/Models/orderDiscount.dart';
import 'package:stock_application_gas/Models/order_dto.dart';
import 'package:stock_application_gas/Product/ProductPage.dart';
import 'package:stock_application_gas/Product/service/productService.dart';
import 'package:stock_application_gas/Product/widget/discount.dart';
import 'package:stock_application_gas/constants.dart';
import 'package:stock_application_gas/fristpage.dart';
import 'package:stock_application_gas/payment/SelectedPayment.dart';
import 'package:stock_application_gas/utils/ApiExeption.dart';
import 'package:stock_application_gas/widgets/Dialog.dart';
import 'package:stock_application_gas/widgets/LoadingDialog.dart';
import 'package:stock_application_gas/widgets/input.dart';

class Selecteditem extends StatefulWidget {
  const Selecteditem({
    super.key,
    required this.orderDtoList,
    required this.openservicecharge,
    required this.openvat,
    required this.serviceChargePer,
    required this.opennumroom,
  });
  final List<OrderDto> orderDtoList;
  final bool openservicecharge;
  final bool openvat;
  final double serviceChargePer;
  final bool opennumroom;

  @override
  State<Selecteditem> createState() => _SelecteditemState();
}

class _SelecteditemState extends State<Selecteditem> {
  TextEditingController remark = TextEditingController();
  TextEditingController roomNO = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController name = TextEditingController();
  double priceDiscountPercen = 0;
  double priceDiscount = 0;

  double serviceCharge = 0.00;
  double? showCharge;
  double discountedPrice = 0.00;

  double? total = 0.00;
  double? beforegrandTotal = 0.00;

  double vat = 0.0;
  double vatRate = 7;

  String? from = 'discount';
  double discountpercen = 0.0;
  String discount = '0.00 ฿';
  List<OrderDiscount> listdiscount = [];

  @override
  void initState() {
    super.initState();
    getserviceChargeRate();
    vatcalculation();
  }

  // Future<void> getSharedPreferences() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   // branchID = prefs.getInt('branch');
  //   // deviceID = prefs.getInt('deviceid');
  //   // panelID = prefs.getInt('panelid');
  //   // openservicecharge = prefs.getBool('statusservicecharge') ?? false;
  //   // openvat = prefs.getBool('statusvat');
  //   // serviceChargePer = prefs.getDouble('serviceChargeRate') ?? 0.0;
  //   opennumroom = prefs.getBool('statusnumroom');
  // }

  Future<void> getserviceChargeRate() async {
    showCharge = (widget.serviceChargePer / 100);
    serviceCharge = widget.orderDtoList[0].grandtotal * showCharge!;
  }

  void vatcalculation() {
    total = (widget.orderDtoList[0].grandtotal + serviceCharge) - priceDiscount;

    if (widget.openvat) {
      vat = (total! * (vatRate / 100));
    } else {
      vat = 0.0;
    }

    beforegrandTotal = total! + vat;

    widget.orderDtoList[0].grandtotal = _roundToNearestDecimal(beforegrandTotal!);
  }

  double _roundToNearestDecimal(double value) {
    // หาเศษของค่า value
    double fraction = value - value.floor();

    if (fraction == 0.5) {
      // ถ้าเศษเท่ากับ 0.5 ราคาให้คงที่ไว้
      return value.floor() + 0.5;
    } else if (fraction < 0.5) {
      // ถ้าเศษน้อยกว่า 0.5 ปัดลงเป็นจำนวนเต็ม
      return value.floor().toDouble();
    } else {
      // ถ้าเศษมากกว่า 0.5 ปัดขึ้นเป็นจำนวนเต็มถัดไป
      return value.floor() + 1.0;
    }
  }

  void vatcalculationDiscountPercen() {
    final scSumprece = (widget.orderDtoList[0].grandtotal + serviceCharge);
    discountpercen = (priceDiscountPercen / 100) * widget.orderDtoList[0].grandtotal;
    total = scSumprece - discountpercen;

    if (widget.openvat) {
      vat = (total! * (vatRate / 100));
    } else {
      vat = 0.0;
    }

    beforegrandTotal = total! + vat;
    widget.orderDtoList[0].grandtotal = _roundToNearestDecimal(beforegrandTotal!);
    setState(() {});
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    for (var orderDto in widget.orderDtoList) {
      orderDto.total = orderDto.orderItems!.fold(0.0, (sum, curr) => sum + curr.total);
      orderDto.grandtotal = orderDto.orderItems!.fold(0.0, (sum, curr) => sum + curr.total);
    }
    getserviceChargeRate();
    from == 'discount' ? vatcalculation() : vatcalculationDiscountPercen();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: GestureDetector(
          onTap: () {
            if (widget.orderDtoList.isNotEmpty) {
              Navigator.pop(context, widget.orderDtoList);
            } else {
              Navigator.pop(context);
            }
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Text(
          'รายการชำระ',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Colors.white,
                width: double.infinity,
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    widget.opennumroom == false
                        ? SizedBox.shrink()
                        : Column(
                            children: [
                              // InputTextFormField(
                              //   width: size.width * 0.95,
                              //   controller: roomNO,
                              //   // hintText: 'RoomNO',
                              //   label: Text('RoomNO'),
                              // ),
                              InputTextFormField(
                                width: size.width * 0.95,
                                controller: name,
                                label: Text('ชื่อ - สกุล'),
                                validator: (value) {
                                  if (value?.isEmpty ?? true) {
                                    return 'กรุณากรอกชื่อ - สกุล';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              InputTextFormField(
                                width: size.width * 0.95,
                                controller: phone,
                                // hintText: 'Hn',
                                label: Text('เบอร์โทร'),
                                keyboardType: TextInputType.phone,
                                format: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(10),
                                  PhoneNumberFormatter(),
                                ],
                                validator: (value) {
                                  if (value?.isEmpty ?? true) {
                                    return 'กรุณากรอกเบอร์โทร';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              InputTextFormField(
                                width: size.width * 0.95,
                                controller: roomNO,
                                // hintText: 'ชื่อ - สกุล',
                                label: Text('ที่อยู่'),
                                validator: (value) {
                                  if (value?.isEmpty ?? true) {
                                    return 'กรุณากรอกที่อยู่';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                    // InputTextFormField(
                    //   width: size.width * 0.95,
                    //   controller: remark,
                    //   // hintText: 'ชื่อ - สกุล',
                    //   label: Text('หมายเหตุ'),
                    // ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsetsDirectional.symmetric(horizontal: 16),
                color: Colors.grey,
                width: double.infinity,
                height: size.height * 0.04,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Order#'),
                    GestureDetector(
                      onTap: () async {
                        final deleteOrder = await showModalBottomSheet(
                            isDismissible: false,
                            context: context,
                            builder: (context) => Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    children: [
                                      Center(
                                        child: Icon(
                                          Icons.delete_forever,
                                          color: Colors.red,
                                          size: 150,
                                        ),
                                      ),
                                      Text(
                                        'ยืนยันลบบิล',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'IBMPlexSansThai',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30,
                                        ),
                                      ),
                                      Text(
                                        'รายการสินค้าและข้อมูลผู้ซื้อจะถูกจ้างทั้งหมดและไม่สามารถนำกลับมาได้',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'IBMPlexSansThai',
                                          fontSize: 20,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.pop(context, true);
                                        },
                                        child: Container(
                                          width: size.width * 0.9,
                                          height: size.height * 0.065,
                                          decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(8)),
                                          child: Center(
                                            child: Text(
                                              textAlign: TextAlign.center,
                                              'ยืนยัน',
                                              style: TextStyle(color: Colors.white, fontSize: 16),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.pop(context, false);
                                        },
                                        child: Container(
                                          width: size.width * 0.9,
                                          height: size.height * 0.065,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(8),
                                              border: Border.all(color: Color(0xFF1264E3))),
                                          child: Center(
                                            child: Text(
                                              textAlign: TextAlign.center,
                                              'ยกเลิก',
                                              style: TextStyle(color: Color(0xFF1264E3), fontSize: 16),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ));
                        if (deleteOrder == true) {
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: ((context) => ProductPage())), (route) => false);
                        }
                      },
                      child: Row(
                        children: [
                          Icon(Icons.cancel),
                          SizedBox(
                            width: 5,
                          ),
                          Text('ลบบิล'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  padding: EdgeInsetsDirectional.symmetric(vertical: 5),
                  color: Colors.white,
                  width: double.infinity,
                  child: SingleChildScrollView(
                    child: Column(
                      children: List.generate(
                        widget.orderDtoList[0].orderItems!.length,
                        (index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Wrap(children: [
                                      SizedBox(
                                        height: 20,
                                        width: size.width * 0.2,
                                        child: Text(
                                          widget.orderDtoList[0].orderItems![index].productName,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: 'IBMPlexSansThai',
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF455A64),
                                          ),
                                        ),
                                      ),
                                    ]),
                                    SizedBox(
                                      width: 1,
                                    ),
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            if (widget.orderDtoList[0].orderItems![index].quantity > 1) {
                                              widget.orderDtoList[0].orderItems![index].quantity -= 1;
                                              widget.orderDtoList[0].orderItems![index].total = (widget.orderDtoList[0].orderItems![index].price +
                                                      widget.orderDtoList[0].orderItems![index].totalAttribute()) *
                                                  widget.orderDtoList[0].orderItems![index].quantity;
                                              getserviceChargeRate();
                                              vatcalculation();
                                            } else {
                                              // widget.orderDtoList[0].orderItems?.removeAt(index);
                                              // getserviceChargeRate();
                                              // vatcalculation();
                                            }
                                            setState(() {});
                                          },
                                          child: Container(
                                            width: size.width * 0.07,
                                            height: size.width * 0.07,
                                            decoration: BoxDecoration(color: Color(0xFFCFD8DC), borderRadius: BorderRadius.circular(6)),
                                            child: Icon(
                                              Icons.remove,
                                              size: 15,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text("${widget.orderDtoList[0].orderItems![index].quantity}"),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            widget.orderDtoList[0].orderItems![index].quantity += 1;
                                            widget.orderDtoList[0].orderItems![index].total = (widget.orderDtoList[0].orderItems![index].price +
                                                    widget.orderDtoList[0].orderItems![index].totalAttribute()) *
                                                widget.orderDtoList[0].orderItems![index].quantity;
                                            getserviceChargeRate();
                                            vatcalculation();
                                            setState(() {});
                                          },
                                          child: Container(
                                            width: size.width * 0.07,
                                            height: size.width * 0.07,
                                            decoration: BoxDecoration(color: Color(0xFFCFD8DC), borderRadius: BorderRadius.circular(6)),
                                            child: Icon(
                                              Icons.add,
                                              size: 15,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Visibility(
                                  visible: widget.orderDtoList[0].orderItems![index].attributes?.isNotEmpty ?? false,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                                      child: Column(
                                        children: List.generate(
                                          widget.orderDtoList[0].orderItems![index].attributes!.length,
                                          (i) {
                                            final itemQuantitySelect = widget.orderDtoList[0].orderItems![index].attributes?[i].attributeValues
                                                .firstWhereOrNull((e) => e.quantity != 1);

                                            return Row(
                                              children: [
                                                Text(
                                                  widget.orderDtoList[0].orderItems![index].attributes![i].attributeName,
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontFamily: 'IBMPlexSansThai',
                                                    color: Color(0xFF455A64),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  itemQuantitySelect != null
                                                      ? itemQuantitySelect.quantity.toString()
                                                      : widget.orderDtoList[0].orderItems![index].attributes![i].attributeValues
                                                          .map((e) => e.attributeValueName)
                                                          .toList()
                                                          .join(','),
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontFamily: 'IBMPlexSansThai',
                                                    color: Color(0xFF455A64),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                widget.orderDtoList[0].orderItems![index].attributes?.isNotEmpty ?? false
                                    ? SizedBox.shrink()
                                    : SizedBox(
                                        height: 10,
                                      ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      widget.orderDtoList[0].orderItems![index].price.toStringAsFixed(2),
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'IBMPlexSansThai',
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF455A64),
                                      ),
                                    ),
                                    Text(
                                      widget.orderDtoList[0].orderItems![index].total.toStringAsFixed(2),
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'IBMPlexSansThai',
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF455A64),
                                      ),
                                    ),
                                  ],
                                ),
                                widget.orderDtoList[0].orderItems![index].remark != null
                                    ? Row(
                                        children: [
                                          Text("Note: ${widget.orderDtoList[0].orderItems![index].remark ?? ""}"),
                                        ],
                                      )
                                    : SizedBox.shrink(),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        final out = await showDialog(
                                          context: context,
                                          builder: (context) => AlertDialogYesNo2(
                                            title: 'แจ้งเตือน',
                                            description: 'รายการสิ้นค้าจะถูกลบออกจากรายการ',
                                            orderNo: '',
                                            pressYes: () {
                                              Navigator.pop(context, true);
                                            },
                                            pressNo: () {
                                              Navigator.pop(context, false);
                                            },
                                          ),
                                        );
                                        if (out == true) {
                                          setState(() {
                                            widget.orderDtoList[0].orderItems?.removeAt(index);
                                          });
                                          if (widget.orderDtoList[0].orderItems!.isEmpty) {
                                            Navigator.pushAndRemoveUntil(
                                                context, MaterialPageRoute(builder: ((context) => ProductPage())), (route) => false);
                                          }
                                        }
                                      },
                                      child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            color: kCancleButton,
                                          ),
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.all(2),
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                          )),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) => Opendialogremark2(
                                            pressOk: (String remark) {
                                              setState(() {
                                                widget.orderDtoList[0].orderItems![index].remark = remark;
                                              });
                                            },
                                            initText: widget.orderDtoList[0].orderItems![index].remark ?? "",
                                          ),
                                        );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8),
                                          color: kButtonColor,
                                        ),
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.all(2),
                                        child: Icon(
                                          Icons.edit_outlined,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Divider()
                              ],
                            ),
                          );
                        },
                      ).reversed.toList(),
                    ),
                  )),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsetsDirectional.symmetric(horizontal: 8),
                color: Colors.white,
                height: size.height * 0.22, // ความสูงของ Container นี้อาจจะสูงเกินไปถ้าเนื้อหามาก
                width: double.infinity,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("จำนวนสินค้า"),
                        Text(
                          "${widget.orderDtoList[0].sumQuantity()}",
                          style: TextStyle(),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("รวม"),
                        Text("${widget.orderDtoList[0].total.toStringAsFixed(2)} ฿"),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        priceDiscountPercen == 0 ? Text("ส่วนลด") : Text("ส่วนลด ${NumberFormat('#,##0', 'en_US').format(priceDiscountPercen)} %"),
                        Text(
                          textAlign: TextAlign.end,
                          priceDiscountPercen == 0
                              ? '${NumberFormat('#,##0.00', 'en_US').format(priceDiscount)} ฿ '
                              : '${discountpercen.toStringAsFixed(2)} ฿',
                          // '${calculateSubtract(discount: discountedPrice, totalPrice: widget.orderDtoList[0].grandtotal).toStringAsFixed(2)} ฿',

                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                    widget.openservicecharge == true
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Service Charge ${widget.serviceChargePer} %"),
                              Text(
                                textAlign: TextAlign.end,
                                widget.serviceChargePer == 00.0 ? '0.00 ฿  ' : ' ${serviceCharge.toStringAsFixed(2)} ฿ ',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          )
                        : SizedBox.shrink(),
                    widget.openvat == true
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Vat 7%"),
                              Text(
                                textAlign: TextAlign.end,
                                ' ${vat.toStringAsFixed(2)} ฿ ',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          )
                        : SizedBox.shrink(),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("ชำระทั้งหมด"),
                        Builder(
                          builder: (context) {
                            return Text(
                              "${widget.orderDtoList[0].grandtotal.toStringAsFixed(2)} ฿",
                              style: TextStyle(color: kButtonColor, fontSize: 34),
                            );
                          },
                        ),
                        // Text(
                        //   "${widget.orderDtoList[0].grandtotal.toStringAsFixed(2)} ฿",
                        //   style: TextStyle(color: kButtonColor, fontSize: 34),
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                color: Colors.white,
                width: double.infinity,
                child: Column(
                  children: [
                    priceDiscount == 0.0
                        ? SizedBox.shrink()
                        : Container(
                            height: size.height * 0.05,
                            width: double.infinity,
                            padding: EdgeInsetsDirectional.symmetric(horizontal: 25),
                            decoration:
                                BoxDecoration(color: Colors.white, border: Border(bottom: BorderSide(color: Color.fromARGB(255, 228, 226, 226)))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "จำนวนเงิน",
                                  style: TextStyle(color: Color(0xff1264E3)),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      NumberFormat('#,##0.00', 'en_US').format(priceDiscount),
                                      style: TextStyle(color: Color(0xff1264E3)),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            priceDiscount = 0;
                                            priceDiscountPercen = 0;
                                            discount = '$priceDiscount ฿';
                                            discountedPrice == 0
                                                ? discountedPrice = widget.orderDtoList[0].grandtotal - priceDiscount
                                                : discountedPrice = widget.orderDtoList[0].grandtotal - priceDiscountPercen;
                                          });
                                        },
                                        child: Icon(Icons.highlight_remove_sharp, size: 25, color: Colors.red))
                                  ],
                                ),
                              ],
                            ),
                          ),
                    priceDiscountPercen == 0.0
                        ? SizedBox.shrink()
                        : Container(
                            height: size.height * 0.05,
                            width: double.infinity,
                            padding: EdgeInsetsDirectional.symmetric(horizontal: 25),
                            decoration:
                                BoxDecoration(color: Colors.white, border: Border(bottom: BorderSide(color: Color.fromARGB(255, 228, 226, 226)))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'เปอร์เซ็นต์ ${NumberFormat('#,##0', 'en_US').format(priceDiscountPercen)} %',
                                  style: TextStyle(color: Color(0xff1264E3)),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      // '${calculateSubtract(discount: discountedPrice, totalPrice: widget.orderDtoList[0].grandtotal).toStringAsFixed(2)} ฿',
                                      '${discountpercen.toStringAsFixed(2)} ฿',
                                      style: TextStyle(color: Color(0xff1264E3)),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            priceDiscount = 0;
                                            priceDiscountPercen = 0;
                                            discount = '$priceDiscount ฿';
                                            discountedPrice == 0
                                                ? discountedPrice = widget.orderDtoList[0].grandtotal - priceDiscount
                                                : discountedPrice = widget.orderDtoList[0].grandtotal - priceDiscountPercen;
                                          });
                                        },
                                        child: Icon(Icons.highlight_remove_sharp, size: 25, color: Colors.red))
                                  ],
                                ),
                              ],
                            ),
                          ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            isDismissible: false,
                            isScrollControlled: true,
                            context: context,
                            builder: (context) => DiscountPage(
                              from: (value) {
                                setState(() => from = value);
                              },
                              delete: (value) {
                                setState(() {
                                  priceDiscountPercen = 0;
                                  priceDiscount = 0;
                                  discount = '0.00 ฿';
                                  discountedPrice = 0.00;
                                });
                              },
                              discount: (value) {
                                setState(() {
                                  if (from == 'discount') {
                                    priceDiscountPercen = 0;
                                    priceDiscount = 0;
                                    priceDiscount = double.parse(value);
                                    discount = '$priceDiscount ฿';

                                    // sumDiscount = sumDiscount + priceDiscount;
                                    final sumPrice = widget.orderDtoList[0].grandtotal;
                                    if (priceDiscount > sumPrice) {
                                      priceDiscount = sumPrice;
                                    }

                                    vatcalculation();

                                    discountedPrice = sumPrice - priceDiscount;
                                    final discountOreder = OrderDiscount(
                                      "จำนวนเงิน",
                                      "",
                                      priceDiscount,
                                      "",
                                    );
                                    listdiscount.clear();
                                    listdiscount.add(discountOreder);
                                  } else {
                                    priceDiscountPercen = 0;
                                    priceDiscount = 0;
                                    final percen = double.parse(value);
                                    if (percen > 100) {
                                      priceDiscountPercen = 100;
                                    } else {
                                      priceDiscountPercen = double.parse(value);
                                    }

                                    priceDiscount = 0;
                                    discount = '$priceDiscountPercen %';
                                    vatcalculationDiscountPercen();
                                    //sumDiscount = sumDiscount + priceDiscountPercen;

                                    discountedPrice =
                                        calculateDiscount(originalPrice: widget.orderDtoList[0].grandtotal, discountPercentage: priceDiscountPercen);
                                    final discountOreder = OrderDiscount(
                                      "จำนวนเงิน",
                                      "",
                                      priceDiscountPercen,
                                      "",
                                    );
                                    listdiscount.clear();
                                    listdiscount.add(discountOreder);
                                    setState(() {});
                                  }
                                });
                              },
                            ),
                          );
                        },
                        child: Container(
                          height: size.height * 0.05,
                          width: double.infinity,
                          decoration:
                              BoxDecoration(color: Colors.white, border: Border(bottom: BorderSide(color: Color.fromARGB(255, 228, 226, 226)))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset(
                                        "assets/icons/Frame.png",
                                        scale: 20,
                                      )),
                                  Text(
                                    "ส่วนลด",
                                    style: TextStyle(color: Color(0xff1264E3)),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.arrow_forward_ios_outlined, size: 15, color: Color(0xff1264E3)),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Divider(),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: GestureDetector(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            if (widget.orderDtoList[0].orderItems?.isNotEmpty ?? false) {
                              LoadingDialog.open(context);
                              try {
                                setState(() {
                                  widget.orderDtoList[0].Hn = phone.text;
                                  widget.orderDtoList[0].customerName = name.text;
                                  widget.orderDtoList[0].roomNo = roomNO.text;
                                  widget.orderDtoList[0].remark = remark.text;
                                  widget.orderDtoList[0].vat = widget.openvat == true ? vat : 0;
                                  widget.orderDtoList[0].serviceCharge = widget.serviceChargePer == 00.0 ? 0.0 : serviceCharge;
                                });
                                final o = await Productservice.ceateOrders2(widget.orderDtoList[0]);
                                LoadingDialog.close(context);
                                if (!mounted) return;
                                Navigator.push(context, MaterialPageRoute(builder: (context) {
                                  return FirstPage();
                                  // SelectedPayment(
                                  //   sumPrice: widget.orderDtoList[0].grandtotal,
                                  //   order: o,
                                  //   serviceCharge: widget.serviceChargePer == 00.0 ? 0.0 : serviceCharge,
                                  //   discount: discountpercen != 0.0
                                  //       ? discountpercen
                                  //       : priceDiscount != 0.0
                                  //           ? priceDiscount
                                  //           : 0.0,
                                  //   showServiceChargeRate: widget.openservicecharge == true ? widget.serviceChargePer : 0.0,
                                  // );
                                }));
                              } on ClientException catch (e) {
                                if (!mounted) return;
                                LoadingDialog.close(context);
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialogYes(
                                    title: 'แจ้งเตือน',
                                    description: '$e',
                                    pressYes: () {
                                      Navigator.pop(context, true);
                                    },
                                  ),
                                );
                              } on ApiException catch (e) {
                                if (!mounted) return;
                                LoadingDialog.close(context);
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialogYes(
                                    title: 'แจ้งเตือน',
                                    description: '$e',
                                    pressYes: () {
                                      Navigator.pop(context, true);
                                    },
                                  ),
                                );
                              }
                            } else {
                              final out = await showDialog(
                                context: context,
                                builder: (context) => AlertDialogYes(
                                  title: 'แจ้งเตือน',
                                  description: 'กรุณาเลือกสิ้นค้า',
                                  pressYes: () {
                                    Navigator.pop(context, true);
                                  },
                                ),
                              );
                              if (out == true) {
                                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: ((context) => ProductPage())), (route) => false);
                              }
                            }
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.all(8),
                          width: double.infinity,
                          height: size.height * 0.07,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: size.width * 0.15,
                                height: size.height * 0.05,
                                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
                                child: Center(
                                    child: Text(
                                  "${widget.orderDtoList[0].sumQuantity()}",
                                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blue),
                                )),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'รายการ',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontFamily: 'IBMPlexSansThai',
                                ),
                              ),
                              SizedBox(
                                width: size.width * 0.35,
                              ),
                              Text(
                                "${widget.orderDtoList[0].grandtotal.toStringAsFixed(2)} ฿",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontFamily: 'IBMPlexSansThai',
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
