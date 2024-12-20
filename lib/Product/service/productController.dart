import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stock_application_gas/Models/branch.dart';
import 'package:stock_application_gas/Models/device.dart';
import 'package:stock_application_gas/Models/modelpanel/panelItems.dart';
import 'package:stock_application_gas/Models/panel.dart';
import 'package:stock_application_gas/Product/service/productService.dart';

class ProductController extends ChangeNotifier {
  ProductController({this.productservice = const Productservice()});
  Productservice productservice;

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  List<Branch> branchs = [];

  List<Device> devices = [];

  List<Panel> panels = [];

  PanelItem? panelItem;

  Future<void> clearToken() async {
    SharedPreferences prefs = await _prefs;
    prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    // print(prefs);
    // await prefs.clear();

    // branchsid = prefs.getInt("branch");
    // deviceid = prefs.getInt('deviceid');
    // panelid = prefs.getInt('panelsid');
    // serviceChargeRate = prefs.getDouble("serviceChargeRate");
    // await prefs.clear();
    // // inspect(branchsid);
    // await prefs.setInt('branch', branchsid!);
    // await prefs.setInt('deviceid', deviceid!);
    // await prefs.setInt('panelid', panelid!);
    // await prefs.setDouble("serviceChargeRate", serviceChargeRate!);

    notifyListeners();
  }

  getListBranch() async {
    branchs.clear();
    branchs = await Productservice.getBranch();
    notifyListeners();
  }

  getListDevice({required String branchId}) async {
    devices.clear();
    devices = await Productservice.getdevice(branchId: branchId);
    notifyListeners();
  }

  getListPanel({required String branchId}) async {
    panels.clear();
    panels = await Productservice.getPanel(branchId: branchId);
    notifyListeners();
  }

  getItemPanel({required int panelID}) async {
    panelItem = null;
    panelItem = await Productservice.getItemPanel(panelID: panelID);
    notifyListeners();
  }
}
