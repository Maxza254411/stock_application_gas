import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stock_application_gas/Models/branch.dart';
import 'package:stock_application_gas/Models/nextpayment.dart';
import 'package:stock_application_gas/Models/order.dart';
import 'package:stock_application_gas/Models/orderpayment.dart';
import 'package:stock_application_gas/Models/orderpayments.dart';
import 'package:stock_application_gas/Models/payment.dart';
import 'package:stock_application_gas/Models/paymentorder.dart';
import 'package:stock_application_gas/Models/profile.dart';
import 'package:stock_application_gas/constants.dart';
import 'package:stock_application_gas/utils/ApiExeption.dart';

class Paymentservice {
  const Paymentservice();

  static Future<List<Payment>> getPayment() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final domain = prefs.getString('domain');
    var headers = {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'};
    final url = Uri.https(domain!, '/api/payment-method', {
      // "branchId": "$baranchid",
    });
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      final data = convert.jsonDecode(response.body);
      final list = data as List;
      return list.map((e) => Payment.fromJson(e)).toList();
    } else {
      final data = convert.jsonDecode(response.body);
      throw ApiException(data['message']);
    }
  }

  static Future<PaymentOrder> paymentSelected({
    required int orderId,
    required List<OrderPayments> orderPayments,
    required double paid,
    required double change,
    required double discount,
    required double serviceCharge,
    required double serviceChargeRate,
    required double grandTotal,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final domain = prefs.getString('domain');
    var headers = {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'};
    final url = Uri.https(domain!, '/api/order/$orderId/payment');
    final response = await http.post(url,
        headers: headers,
        body: convert.jsonEncode({
          "paid": paid,
          "change": change,
          "discount": discount,
          "serviceCharge": serviceCharge,
          "serviceChargeRate": serviceChargeRate,
          "orderPayments": orderPayments,
          "grandTotal": grandTotal,
        }));
    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = convert.jsonDecode(response.body);
      return PaymentOrder.fromJson(data);
    } else {
      final data = convert.jsonDecode(response.body);
      throw ApiException(data['message']);
    }
  }

  static Future<NextPayment> nextPayment({required int orderId}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final domain = prefs.getString('domain');
    var headers = {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'};
    final url = Uri.https(domain!, '/api/order/$orderId/next-payment');
    final response = await http.post(url, headers: headers, body: convert.jsonEncode({}));
    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = convert.jsonDecode(response.body);
      return NextPayment.fromJson(data);
    } else {
      final data = convert.jsonDecode(response.body);
      throw ApiException(data['message']);
    }
  }

  static Future<Order> getOrderId({required int orderId}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final domain = prefs.getString('domain');
    var headers = {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'};
    final url = Uri.https(domain!, '/api/order/$orderId');
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      final data = convert.jsonDecode(response.body);
      return Order.fromJson(data);
    } else {
      final data = convert.jsonDecode(response.body);
      throw ApiException(data['message']);
    }
  }

  static Future<Profile> getprofileById() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final domain = prefs.getString('domain');
    var headers = {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'};
    final url = Uri.https(
      domain!,
      '/api/user/profile',
    );
    final response = await http.get(
      url,
      headers: headers,
    );
    if (response.statusCode == 200) {
      final data = convert.jsonDecode(response.body);

      return Profile.fromJson(data);
    } else {
      final data = convert.jsonDecode(response.body);
      throw ApiException(data['message']);
    }
  }

  static Future<Branch> getStore() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final domain = prefs.getString('domain');
    var headers = {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'};
    final url = Uri.https(
      domain!,
      '/api/store/1',
    );
    final response = await http.get(
      url,
      headers: headers,
    );
    if (response.statusCode == 200) {
      final data = convert.jsonDecode(response.body);

      return Branch.fromJson(data);
    } else {
      final data = convert.jsonDecode(response.body);
      throw ApiException(data['message']);
    }
  }

  static Future<OrderPayment> getOrderPayment({required int id}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final domain = prefs.getString('domain');
    var headers = {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'};
    final url = Uri.https(domain!, '/api/order-payment/$id');
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = convert.jsonDecode(response.body);

      return OrderPayment.fromJson(data);
    } else {
      final data = convert.jsonDecode(response.body);
      throw ApiException(data['message']);
    }
  }

  static Future payRoomService({required int orderId, required int orderPaymentId}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final domain = prefs.getString('domain');
    var headers = {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'};
    final url = Uri.https(domain!, '/api/order/$orderId/paid-roomservice/$orderPaymentId');
    final response = await http.post(
      url,
      headers: headers,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = convert.jsonDecode(response.body);
      return data;
    } else {
      final data = convert.jsonDecode(response.body);
      throw ApiException(data['message']);
    }
  }

  ///บัตรเคดิส
  static Future alternativePayment({required int orderId, required int orderPaymentId}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final domain = prefs.getString('domain');
    var headers = {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'};
    final url = Uri.https(domain!, '/api/order/$orderId/paid/$orderPaymentId');
    final response = await http.post(
      url,
      headers: headers,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = convert.jsonDecode(response.body);
      return data;
    } else {
      final data = convert.jsonDecode(response.body);
      throw ApiException(data['message']);
    }
  }
}
