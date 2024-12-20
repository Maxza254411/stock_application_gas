import 'package:flutter/material.dart';
import 'package:stock_application_gas/Models/payment.dart';
import 'package:stock_application_gas/payment/service/paymentService.dart';

class PaymentController extends ChangeNotifier {
  PaymentController({this.api = const Paymentservice()});
  Paymentservice api;

  List<Payment> payments = [];

  getListPayment() async {
    payments.clear();
    // final baranchid2 = prefs.getInt('branch');
    payments = await Paymentservice.getPayment();
    notifyListeners();
  }
}
