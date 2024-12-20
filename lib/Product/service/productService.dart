import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stock_application_gas/Models/branch.dart';
import 'package:stock_application_gas/Models/device.dart';
import 'package:stock_application_gas/Models/modelpanel/panelItems.dart';
import 'package:stock_application_gas/Models/order.dart';
import 'package:stock_application_gas/Models/order_dto.dart';
import 'package:stock_application_gas/Models/panel.dart';
import 'package:stock_application_gas/constants.dart';
import 'package:stock_application_gas/utils/ApiExeption.dart';

class Productservice {
  const Productservice();

  //เรียกดูข้อมูล Branch
  static Future<List<Branch>> getBranch() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final domain = prefs.getString('domain');
    var headers = {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'};
    final url = Uri.https(domain!, '/api/branch');
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      final data = convert.jsonDecode(response.body);
      final list = data as List;
      return list.map((e) => Branch.fromJson(e)).toList();
    } else {
      final data = convert.jsonDecode(response.body);
      throw ApiException(data['message']);
    }
  }

  //เรียกดูข้อมูล Device
  static Future<List<Device>> getdevice({required String branchId}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final domain = prefs.getString('domain');
    var headers = {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'};
    final url = Uri.https(domain!, '/api/device', {"branchId": branchId});
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = convert.jsonDecode(response.body);
      final list = data as List;
      return list.map((e) => Device.fromJson(e)).toList();
    } else {
      final data = convert.jsonDecode(response.body);
      throw Exception(data['message']);
    }
  }

  //เรียกดูข้อมูล Panel
  static Future<List<Panel>> getPanel({required String branchId}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final domain = prefs.getString('domain');
    var headers = {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'};
    final url = Uri.https(domain!, '/api/panel', {"branchId": branchId});
    final response = await http.get(
      headers: headers,
      url,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = convert.jsonDecode(response.body);
      final list = data as List;
      return list.map((e) => Panel.fromJson(e)).toList();
    } else {
      final data = convert.jsonDecode(response.body);
      throw Exception(data['message']);
    }
  }

  static Future<PanelItem> getItemPanel({required int panelID}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final domain = prefs.getString('domain');
    var headers = {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'};
    final url = Uri.https(domain!, '/api/panel/$panelID');
    final response = await http.get(
      headers: headers,
      url,
    );
    if (response.statusCode == 200) {
      final data = convert.jsonDecode(response.body);
      return PanelItem.fromJson(data);
    } else {
      final data = convert.jsonDecode(response.body);
      throw ApiException(data['message']);
    }
  }

  static Future<Order> ceateOrders2(OrderDto data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final domain = prefs.getString('domain');
    var headers = {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'};
    final url = Uri.https(domain!, '/api/order');
    final response = await http.post(
      url,
      headers: headers,
      body: convert.jsonEncode(data.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = convert.jsonDecode(response.body);
      return Order.fromJson(data);
    } else {
      final data = convert.jsonDecode(response.body);
      throw ApiException(data['message'].toString());
    }
  }
}
