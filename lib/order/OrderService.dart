import 'package:stock_application_gas/Models/nextpayment.dart';
import 'package:stock_application_gas/Models/orderpayment.dart';
import 'package:stock_application_gas/Models/payment.dart';
import 'package:stock_application_gas/Models/paymentorder.dart';
import 'package:stock_application_gas/constants.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:stock_application_gas/Models/branch.dart';
import 'package:stock_application_gas/Models/orderDate.dart';
import 'package:stock_application_gas/Models/orderpayments.dart';
import 'package:stock_application_gas/Models/profile.dart';
import 'package:stock_application_gas/models/reservedatas.dart';
import 'package:stock_application_gas/utils/ApiExeption.dart';

class OrderService {
  const OrderService();
  static Future<OrderDate> getreserve({
    int? page,
    int? limit,
    String? receivedStatus,
    String? roomNo,
    String? orderType,
    String? fillterDate,
    String? search,
    String? complete,
    String? void1,
    int? deviceid,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final domain = prefs.getString('domain');
    var headers = {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'};
    final url = Uri.https(domain!, 'api/order/datatables', {
      "page": "$page",
      "limit": "$limit",
      // if (orderType != null) "filter.orderType": orderType,
      if (fillterDate != null) "filter.orderDate": fillterDate,
      // if (search != null) "search": search,
      // "filter.orderStatus": '\$eqsending',
      // if (deviceid != null) "filter.device.id": "$deviceid",
      "filter.receivedStatus": receivedStatus,
      if (roomNo != null) "filter.roomNo": roomNo,
    });
    final response = await http.get(
      url,
      headers: headers,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = convert.jsonDecode(response.body);
      // final list = data["data"] as List;
      return OrderDate.fromJson(data);
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

////บัตรเคดิส
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

  static Future<List<Payment>> getPayment(
      // {required int baranchid}
      ) async {
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
        }));
    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = convert.jsonDecode(response.body);
      return PaymentOrder.fromJson(data);
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

  static Future updateStatus({required int orderId}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final domain = prefs.getString('domain');
    var headers = {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'};
    final url = Uri.https(domain!, '/api/order/$orderId/received-status');
    final response = await http.put(
      url,
      headers: headers,
      body: convert.jsonEncode({
        "receivedStatus": 'sending',
      }),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = convert.jsonDecode(response.body);
      return data;
    } else {
      final data = convert.jsonDecode(response.body);
      throw ApiException(data['message']);
    }
  }

  static Future<Reservedatas> getOrderID({required int id}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final domain = prefs.getString('domain');
    var headers = {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'};
    final url = Uri.https(domain!, '/api/order/$id');
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = convert.jsonDecode(response.body);

      return Reservedatas.fromJson(data);
    } else {
      final data = convert.jsonDecode(response.body);
      throw ApiException(data['message']);
    }
  }
}
