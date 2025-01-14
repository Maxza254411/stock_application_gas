import 'package:flutter/material.dart';
import 'package:stock_application_gas/Models/listProduct.dart';
import 'package:stock_application_gas/Models/orderitemsdto.dart';

const String publicUrl = 'sct.dev-asha.com:8443';
//BPH
// const String publicUrl = "upos-ews.okontek.com:10302";
//JTH
// const String publicUrl = "upos-ews.okontek.com:10303";
//BIH
// const String publicUrl = "upos-ews.okontek.com:10304";

const kButtonColor = Color(0xFF1264E3);
const kTabColor = Color(0xFF607D8B);
const ktextColr = Color(0xFF455A64);
const kTextButtonColor = Color.fromARGB(255, 255, 255, 255);
const kSecondaryColor = Color.fromARGB(255, 81, 120, 136);
const kButtoncolor = Color(0xFFFC7716);
const kTextDateColor = Color(0xffFA5A0E);
const kCancleButton = Color(0xFFFF5252);
const kSubtitleText = Color(0xFF424242);
const kbutton = Color(0xff2C4288);

//ฟังก์ชั่นคำนวน ราคา และ qty
double sum(List<ListProduct> orders) => orders.fold(0, (previous, o) => previous + (o.product.qty * o.product.priceAll));
double sumVat(List<ListProduct> orders) => sum(orders) + (sum(orders) * 7) / 100;
int newQty(List<ListProduct> orders) => orders.fold(0, (previousValue, e) => previousValue + e.product.qty);

double sumOrderItem(List<OrderItemsDto> attributesValue) => attributesValue.fold(0, (p, o) => p + o.total!);

// double sumOrder(List<Orderitems> orderitem) => orderitem.fold(0, (p, o) => p + (o.total + o.total));
// double sumOneRow(Orderitems value) => (value.quantity * value.product.price!);
// double sumOneColumn(List<Orderitems> value) => value.fold(0, (previousValue, element) => previousValue + (element.quantity * element.product.price!));

double calculateDiscount({required double originalPrice, required double discountPercentage}) {
  // คำนวณจำนวนเงินที่ต้องจ่ายหลังหักส่วนลด
  double discountedPrice = originalPrice - (originalPrice * discountPercentage / 100);
  return discountedPrice;
}

double calculateSubtract({required double totalPrice, required double discount}) {
  double discountedPrice = totalPrice - discount;
  double fraction = discountedPrice - discountedPrice.floor();

  if (fraction > 0.6) {
    // ถ้าเศษมากกว่า 0.6 ให้ปัดขึ้นเป็น 0.7
    return discountedPrice.floor() + 0.7;
  } else {
    // ถ้าเศษน้อยกว่าหรือเท่ากับ 0.6 ให้ปัดลงเป็น 0
    return discountedPrice.floor().toDouble();
  }
}

List<Map<String, String>> imagemog = [
  {
    'image': 'assets/images/w960.jpeg',
  },
  {
    'image': 'assets/images/w960 48 kg.jpeg',
  },
  {
    'image': 'assets/images/w960 15 kg.jpeg',
  },
];

List<Map<String, String>> cardItems = [
  {
    'nameStore': 'ร้านค้าที่ 1',
  },
  {
    'nameStore': 'ร้านค้าที่ 2',
  },
];
List<Map<String, String>> gastank = [
  {
    'nameTank': 'ถังหมุนเวียน',
  },
  {
    'nameTank': 'ถังใหม่ขาย',
  },
  {
    'nameTank': 'ถังฝากเติม',
  },
];
List<Map<String, String>> gastankDiver = [
  {
    'nameTank': 'ถังหมุนเวียน',
  },
  {
    'nameTank': 'ถังฝากเติม',
  },
];
List<Map<String, String>> gas_km = [
  {
    'km': '4 กก',
    'brand1': 'ปตท',
    'sum1': '9',
    'brand2': 'ส.ว.ย',
    'sum2': '4',
    'unit': 'ถัง',
    'originalSum1': '9',
    'originalSum2': '4',
  },
  {
    'km': '7 กก',
    'brand1': 'ปตท',
    'sum1': '5',
    'brand2': 'ส.ว.ย',
    'sum2': '1',
    'unit': 'ถัง',
    'originalSum1': '5',
    'originalSum2': '1',
  },
  {
    'km': '15 กก',
    'brand1': 'ปตท',
    'sum1': '2',
    'brand2': 'ส.ว.ย',
    'sum2': '10',
    'unit': 'ถัง',
    'originalSum1': '2',
    'originalSum2': '10',
  },
  {
    'km': '48 กก',
    'brand1': 'ปตท',
    'sum1': '9',
    'brand2': 'ส.ว.ย',
    'sum2': '16',
    'unit': 'ถัง',
    'originalSum1': '9',
    'originalSum2': '16',
  },
];
List<Map<String, String>> oneItem = [
  {
    'km': '4 กก',
    'brand1': 'ปตท',
    'sum1': '9',
    'brand2': 'ส.ว.ย',
    'sum2': '7',
    'unit': 'จำนวน',
  },
  {
    'km': '48 กก',
    'brand1': 'ปตท',
    'sum1': '5',
    'brand2': 'ส.ว.ย',
    'sum2': '16',
    'unit': 'ถัง',
  },
];
List<Map<String, String>> history = [
  {
    'name': 'ถังหมุนเวียน',
    'km': '4 กก',
    'brand1': 'ปตท',
    'sum1': '9',
    'sum2': '7',
    'brand2': 'ส.ว.ย',
    'km2': '48 กก',
    'sum3': '5',
    'sum4': '16',
    'time': '30/07/2025 14:30',
    'unit': 'ถัง',
  },
  {
    'name': 'ถังใหม่ขาย',
    'km': '4 กก',
    'km2': '7 กก',
    'km3': '48 กก',
    'sum1': '8',
    'sum2': '9',
    'sum3': '5',
    'sum4': '16',
    'sum5': '20',
    'sum6': '25',
    'brand1': 'ปตท',
    'brand2': 'ส.ว.ย',
    'time': '30/07/2025 18:40',
    'unit': 'ถัง',
  },
];
List<Map<String, String>> reportTank = [
  {'date': '20/11/24', 'km': '4 กก', 'brand': 'ปตท', 'unit': '2', 'remark': 'เจ้ดำ'},
  {'date': '01/12/22', 'km': '7 กก', 'brand': 'ส.ว.ย', 'unit': '10', 'remark': 'เจ้แดง'},
  {'date': '02/12/22', 'km': '15 กก', 'brand': 'ส.ว.ย', 'unit': '10', 'remark': 'นายเขียว'},
];

const List<Map<String, dynamic>> store = [
  {'store': 'ร้านที่1'},
  {'store': 'ร้านที่1'},
  {'store': 'ร้านที่1'}
];
const List<Map<String, dynamic>> dataTable = [
  {
    'date': 'วันที่',
    'productcode': 'รหัสสินค้า',
    'type': 'ประเภท',
    'weight': 'น้ำหนัก',
    'brand': 'ยี่ห้อ',
    'pice': 'ราคา',
    'unit': 'จำนวน',
    'claimtank': 'ถังเคลม',
    'paymenttype': 'ประเภทการจ่าย',
    'totalamount': 'จำวนรวม'
  },
  {
    'date': 'วันที่',
    'productcode': 'รหัสสินค้า',
    'type': 'ประเภท',
    'weight': 'น้ำหนัก',
    'brand': 'ยี่ห้อ',
    'pice': 'ราคา',
    'unit': 'จำนวน',
    'claimtank': 'ถังเคลม',
    'paymenttype': 'ประเภทการจ่าย',
    'totalamount': 'จำวนรวม'
  },
  {
    'date': 'วันที่',
    'productcode': 'รหัสสินค้า',
    'type': 'ประเภท',
    'weight': 'น้ำหนัก',
    'brand': 'ยี่ห้อ',
    'pice': 'ราคา',
    'unit': 'จำนวน',
    'claimtank': 'ถังเคลม',
    'paymenttype': 'ประเภทการจ่าย',
    'totalamount': 'จำวนรวม'
  },
];
const List<Map<String, dynamic>> dataTablerow = [
  {
    'date': '1-12-2025',
    'productcode': '0734',
    'type': 'ถังใหม่',
    'weight': '15',
    'brand': 'ปตท',
    'pice': '425',
    'unit': '2',
    'claimtank': 'ปกติ',
    'paymenttype': 'เงินสด',
    'totalamount': '160',
    'capital': '1',
  },
  {
    'date': '1-12-2025',
    'productcode': '0742',
    'type': 'ประเภท',
    'weight': 'น้ำหนัก',
    'brand': 'ยี่ห้อ',
    'pice': 'ราคา',
    'unit': 'จำนวน',
    'claimtank': 'ถังเคลม',
    'paymenttype': 'ประเภทการจ่าย',
    'totalamount': 'จำวนรวม',
    'capital': '1',
  },
  {
    'date': 'วันที่',
    'productcode': 'รหัสสินค้า',
    'type': 'ประเภท',
    'weight': 'น้ำหนัก',
    'brand': 'ยี่ห้อ',
    'pice': 'ราคา',
    'unit': 'จำนวน',
    'claimtank': 'ถังเคลม',
    'paymenttype': 'ประเภทการจ่าย',
    'totalamount': 'จำวนรวม',
    'capital': '1',
  },
];

List<Map<String, String>> sellreport = [
  {
    'nameTank': 'ถังหมุนเวียน',
  },
  {
    'nameTank': 'ถังฝากอัด',
  },
  {
    'nameTank': 'ถังไม่ได้อัด',
  },
  {
    'nameTank': 'เชื้อเพลิง',
  },
];

List<String> tanktype = [
  'ถังหมุนเวียน',
  'ถังฝากอัด',
  'ถังไม่ได้อัด',
  'เชื้อเพลิง',
];
List<String> numberStore = [
  'ร้านที่ 1',
  'ร้านที่ 2',
  'ร้านที่ 3',
  'ร้านที่ 4',
];

double width(BuildContext context) => MediaQuery.of(context).size.width;
double height(BuildContext context) => MediaQuery.of(context).size.height;
