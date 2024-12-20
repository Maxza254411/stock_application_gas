import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stock_application_gas/Models/branch.dart';
import 'package:stock_application_gas/Models/device.dart';
import 'package:stock_application_gas/Models/panel.dart';
import 'package:stock_application_gas/Product/ProductPage.dart';
import 'package:stock_application_gas/Product/service/productController.dart';
import 'package:stock_application_gas/login/loginPage.dart';
import 'package:stock_application_gas/widgets/Dialog.dart';
import 'package:stock_application_gas/widgets/Switch.dart';
import 'package:stock_application_gas/widgets/input.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final TextEditingController serviceChargeRate = TextEditingController();
  Branch? selectBranch;
  Device? selectDevice;
  Panel? selectPanel;
  int? branchID;
  int? deviceID;
  int? panelID;

  bool openservicecharge = false;
  bool? openvat = false;
  bool opennumroom = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () async => {
        getSharedPreferences(),
        // await getstatustogle(),
        // await profile(),
        // await getDevice(),
        // await getBranch(),
        // await getPanel(),
        // await getserviceChargeRate(),
        await getlistBranch(),
        if (branchID != null)
          {
            await getListDevice(branch: branchID.toString()),
            await getlistPanel(branch: branchID.toString()),
          }
      },
    );
  }

  Future<void> getSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    branchID = prefs.getInt('branch');
    deviceID = prefs.getInt('deviceid');
    panelID = prefs.getInt('panelid');
    openservicecharge = prefs.getBool('statusservicecharge') ?? false;
    openvat = prefs.getBool('statusvat');
    serviceChargeRate.text = prefs.getDouble('serviceChargeRate').toString();
    opennumroom = prefs.getBool('statusnumroom') ?? false;
  }

  Future<void> getlistBranch() async {
    try {
      await context.read<ProductController>().getListBranch();
      final listBranchs = context.read<ProductController>().branchs;
      if (branchID != null) {
        for (var i = 0; i < listBranchs.length; i++) {
          if (listBranchs[i].id == branchID) {
            selectBranch = listBranchs[i];
          }
        }
      }
    } on Exception catch (e) {
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (context) => AlertDialogYes(
          title: 'แจ้งเตือน',
          description: '$e',
          pressYes: () {
            if (e.toString() != 'Exception: Unauthorized') {
              Navigator.pop(context, true);
            } else {
              context.read<ProductController>().clearToken().then((value) {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
              });
            }
          },
        ),
      );
    }
  }

  Future<void> getListDevice({required String branch}) async {
    try {
      await context.read<ProductController>().getListDevice(branchId: branch);
      final getListDevices = context.read<ProductController>().devices;
      if (deviceID != null) {
        for (var i = 0; i < getListDevices.length; i++) {
          if (getListDevices[i].id == deviceID) {
            selectDevice = getListDevices[i];
          }
        }
      }
    } on Exception catch (e) {
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (context) => AlertDialogYes(
          title: 'แจ้งเตือน',
          description: '$e',
          pressYes: () {
            if (e.toString() != 'Exception: Unauthorized') {
              Navigator.pop(context, true);
            } else {
              context.read<ProductController>().clearToken().then((value) {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
              });
            }
          },
        ),
      );
    }
  }

  Future<void> getlistPanel({required String branch}) async {
    try {
      await context.read<ProductController>().getListPanel(branchId: branch);
      final getListPanels = context.read<ProductController>().panels;
      if (panelID != null) {
        for (var i = 0; i < getListPanels.length; i++) {
          if (getListPanels[i].id == panelID) {
            selectPanel = getListPanels[i];
          }
        }
      }
    } on Exception catch (e) {
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (context) => AlertDialogYes(
          title: 'แจ้งเตือน',
          description: '$e',
          pressYes: () {
            if (e.toString() != 'Exception: Unauthorized') {
              Navigator.pop(context, true);
            } else {
              context.read<ProductController>().clearToken().then((value) {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
              });
            }
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Ver. 1.0.3b1'),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Consumer<ProductController>(
        builder: (context, controller, child) => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    width: size.width * 0.7,
                    child: Card(
                      surfaceTintColor: Colors.white,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      elevation: 2,
                      child: DropdownSearch<Branch>(
                        selectedItem: selectBranch,
                        // items: listProvinec,
                        items: controller.branchs,
                        itemAsString: (item) => item.name ?? '',
                        popupProps: PopupProps.menu(
                          // showSearchBox: true,
                          fit: FlexFit.loose,
                          constraints: BoxConstraints(),
                          // menuProps: MenuProps(
                          //   backgroundColor: Color.fromARGB(243, 158, 158, 158),
                          // ),
                          // containerBuilder: (context, popupWidget) => Container(
                          //   decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(25),
                          //     border: Border.all(color: Colors.grey, width: 3),
                          //   ),
                          //   child: popupWidget,
                          // ),
                          itemBuilder: (context, item, isSelected) => Container(
                            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.name ?? '',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // searchFieldProps: TextFieldProps(
                          //   cursorColor: Colors.black,
                          //   style: TextStyle(color: Colors.black, fontSize: 16),
                          //   decoration: InputDecoration(
                          //     hintText: 'เลือกพาเนล',
                          //     hintStyle: TextStyle(color: Color.fromARGB(255, 73, 73, 73)),
                          //     prefixIcon: Icon(Icons.search),
                          //     prefixIconColor: Colors.black,
                          //     enabledBorder: underlineInputBorder,
                          //     focusedBorder: underlineInputBorder,
                          //   ),
                          // ),
                        ),
                        dropdownDecoratorProps: DropDownDecoratorProps(
                          textAlignVertical: TextAlignVertical.center,
                          baseStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            fontFamily: 'Prompt',
                          ),
                          dropdownSearchDecoration: InputDecoration(
                            prefix: SizedBox(
                              width: 15,
                            ),
                            hintText: 'SelectBranch',
                            hintStyle: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Prompt',
                            ),
                            border: InputBorder.none,
                            suffixIconColor: Colors.grey,
                          ),
                        ),
                        onChanged: (va) {
                          setState(() {
                            selectBranch = null;
                            selectDevice = null;
                            selectPanel = null;
                            selectBranch = va;
                            getListDevice(branch: va!.id.toString());
                            getlistPanel(branch: va.id.toString());
                          });
                        },
                      ),
                    ),
                  ),

                  // SizedBox(
                  //   width: size.width * 0.7,
                  //   child: Card(
                  //     surfaceTintColor: Colors.white,
                  //     color: Colors.white,
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(8.0),
                  //     ),
                  //     elevation: 2,
                  //     child: DropdownButtonHideUnderline(
                  //       child: DropdownButton2<Branch>(
                  //         isExpanded: true,
                  //         hint: Text(
                  //           'SelectBranch ',
                  //           style: TextStyle(
                  //             fontSize: 14,
                  //             fontFamily: 'IBMPlexSansThai',
                  //             color: Theme.of(context).hintColor,
                  //           ),
                  //         ),
                  //         items: controller.branchs
                  //             .map((Branch item) => DropdownMenuItem<Branch>(
                  //                   value: item,
                  //                   child: Text(
                  //                     item.name!,
                  //                     style: TextStyle(
                  //                       fontSize: 14,
                  //                       fontFamily: 'IBMPlexSansThai',
                  //                     ),
                  //                   ),
                  //                 ))
                  //             .toList(),
                  //         value: selectBranch,
                  //         onChanged: (va) {
                  //           setState(() {
                  //             selectBranch = null;
                  //             selectDevice = null;
                  //             selectPanel = null;
                  //             selectBranch = va;
                  //             getListDevice(branch: va!.id.toString());
                  //             getlistPanel(branch: va.id.toString());
                  //           });
                  //         },
                  //       ),
                  //     ),
                  //   ),
                  // ),

                  SizedBox(
                    height: 30,
                  ),
                  controller.devices.isEmpty || selectBranch == null
                      ? SizedBox.shrink()
                      : SizedBox(
                          width: size.width * 0.7,
                          child: Card(
                            surfaceTintColor: Colors.white,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            elevation: 2,
                            child: DropdownSearch<Device>(
                              selectedItem: selectDevice,
                              // items: listProvinec,
                              items: controller.devices,
                              itemAsString: (item) => item.name ?? '',
                              popupProps: PopupProps.menu(
                                // showSearchBox: true,
                                fit: FlexFit.loose,
                                constraints: BoxConstraints(),
                                // menuProps: MenuProps(
                                //   backgroundColor: Color.fromARGB(243, 158, 158, 158),
                                // ),
                                // containerBuilder: (context, popupWidget) => Container(
                                //   decoration: BoxDecoration(
                                //     borderRadius: BorderRadius.circular(25),
                                //     border: Border.all(color: Colors.grey, width: 3),
                                //   ),
                                //   child: popupWidget,
                                // ),
                                itemBuilder: (context, item, isSelected) => Container(
                                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.name ?? '',
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // searchFieldProps: TextFieldProps(
                                //   cursorColor: Colors.black,
                                //   style: TextStyle(color: Colors.black, fontSize: 16),
                                //   decoration: InputDecoration(
                                //     hintText: 'เลือกพาเนล',
                                //     hintStyle: TextStyle(color: Color.fromARGB(255, 73, 73, 73)),
                                //     prefixIcon: Icon(Icons.search),
                                //     prefixIconColor: Colors.black,
                                //     enabledBorder: underlineInputBorder,
                                //     focusedBorder: underlineInputBorder,
                                //   ),
                                // ),
                              ),
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                textAlignVertical: TextAlignVertical.center,
                                baseStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  fontFamily: 'Prompt',
                                ),
                                dropdownSearchDecoration: InputDecoration(
                                  prefix: SizedBox(
                                    width: 15,
                                  ),
                                  hintText: 'SelectDevice',
                                  hintStyle: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Prompt',
                                  ),
                                  border: InputBorder.none,
                                  suffixIconColor: Colors.grey,
                                ),
                              ),
                              onChanged: (dv) {
                                setState(() {
                                  selectDevice = dv;
                                  selectPanel = null;
                                });
                              },
                            ),
                          ),
                        ),

                  // SizedBox(
                  //     width: size.width * 0.7,
                  //     child: Card(
                  //       surfaceTintColor: Colors.white,
                  //       color: Colors.white,
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(8.0),
                  //       ),
                  //       elevation: 2,
                  //       child: DropdownButtonHideUnderline(
                  //         child: DropdownButton2<Device>(
                  //           isExpanded: true,
                  //           hint: Text(
                  //             'SelectDevice',
                  //             style: TextStyle(
                  //               fontSize: 14,
                  //               fontFamily: 'IBMPlexSansThai',
                  //               color: Theme.of(context).hintColor,
                  //             ),
                  //           ),
                  //           items: controller.devices
                  //               .map((Device item) => DropdownMenuItem<Device>(
                  //                     value: item,
                  //                     child: Text(
                  //                       item.name ?? '',
                  //                       style: TextStyle(
                  //                         fontSize: 14,
                  //                         fontFamily: 'IBMPlexSansThai',
                  //                       ),
                  //                     ),
                  //                   ))
                  //               .toList(),
                  //           value: selectDevice,
                  //           onChanged: (dv) {
                  //             setState(() {
                  //               selectDevice = dv;
                  //               selectPanel = null;
                  //             });
                  //           },
                  //         ),
                  //       ),
                  //     ),
                  //   ),

                  SizedBox(
                    height: 30,
                  ),
                  controller.panels.isEmpty || selectBranch == null
                      ? SizedBox.shrink()
                      : SizedBox(
                          width: size.width * 0.7,
                          child: Card(
                            surfaceTintColor: Colors.white,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            elevation: 2,
                            child: DropdownSearch<Panel>(
                              selectedItem: selectPanel,
                              // items: listProvinec,
                              items: controller.panels,
                              itemAsString: (item) => item.name,
                              popupProps: PopupProps.menu(
                                // showSearchBox: true,
                                fit: FlexFit.loose,
                                constraints: BoxConstraints(),
                                // menuProps: MenuProps(
                                //   backgroundColor: Color.fromARGB(243, 158, 158, 158),
                                // ),
                                // containerBuilder: (context, popupWidget) => Container(
                                //   decoration: BoxDecoration(
                                //     borderRadius: BorderRadius.circular(25),
                                //     border: Border.all(color: Colors.grey, width: 3),
                                //   ),
                                //   child: popupWidget,
                                // ),
                                itemBuilder: (context, item, isSelected) => Container(
                                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.name,
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // searchFieldProps: TextFieldProps(
                                //   cursorColor: Colors.black,
                                //   style: TextStyle(color: Colors.black, fontSize: 16),
                                //   decoration: InputDecoration(
                                //     hintText: 'เลือกพาเนล',
                                //     hintStyle: TextStyle(color: Color.fromARGB(255, 73, 73, 73)),
                                //     prefixIcon: Icon(Icons.search),
                                //     prefixIconColor: Colors.black,
                                //     enabledBorder: underlineInputBorder,
                                //     focusedBorder: underlineInputBorder,
                                //   ),
                                // ),
                              ),
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                textAlignVertical: TextAlignVertical.center,
                                baseStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  fontFamily: 'Prompt',
                                ),
                                dropdownSearchDecoration: InputDecoration(
                                  prefix: SizedBox(
                                    width: 15,
                                  ),
                                  hintText: 'SelectPanel',
                                  hintStyle: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Prompt',
                                  ),
                                  border: InputBorder.none,
                                  suffixIconColor: Colors.grey,
                                ),
                              ),
                              onChanged: (pn) {
                                setState(() {
                                  selectPanel = pn;
                                });
                              },
                            ),
                          ),
                        ),
                  Row(
                    children: [
                      OpenAndCloseSwitch(
                        size: size,
                        open: opennumroom,
                        showTextOpen: 'เปิดเลขห้อง',
                        showTextClose: 'ปิดเลขห้อง',
                        onChanged: (value) async {
                          final SharedPreferences prefs = await SharedPreferences.getInstance();
                          if (opennumroom == false) {
                            final numroom = await showDialog(
                                context: context,
                                builder: (context) => AlertDialogYesNo2(
                                      title: 'แจ้งเตือน',
                                      description: 'ต้องการเปิดเลขห้องหรือไม่',
                                      pressYes: () {
                                        Navigator.pop(context, true);
                                      },
                                      pressNo: () {
                                        Navigator.pop(context, false);
                                      },
                                      orderNo: '',
                                    ));
                            if (numroom == true) {
                              setState(() {
                                opennumroom = value;
                                prefs.setBool('statusnumroom', value);
                              });
                              //Navigator.push(context, MaterialPageRoute(builder: (context) => Printter()));
                            }
                          } else {
                            final numroom = await showDialog(
                              context: context,
                              builder: (context) => AlertDialogYesNo2(
                                title: 'แจ้งเตือน',
                                description: 'ต้องการปิดเลขห้องหรือไม่',
                                pressYes: () {
                                  Navigator.pop(context, true);
                                },
                                pressNo: () {
                                  Navigator.pop(context, false);
                                },
                                orderNo: '',
                              ),
                            );
                            if (numroom == true) {
                              setState(() {
                                opennumroom = value;
                                prefs.setBool('statusnumroom', value);
                              });
                            }
                          }
                        },
                        // onChanged: (value) {
                        //   setState(() {
                        //     opennumroom = value;
                        //   });
                        // },
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      OpenAndCloseSwitch(
                        size: size,
                        open: openvat ?? false,
                        showTextOpen: 'เปิด Vat 7 %',
                        showTextClose: 'ปิด Vat 7 %',
                        onChanged: (value) async {
                          final SharedPreferences prefs = await SharedPreferences.getInstance();
                          if (openvat == false) {
                            final vat = await showDialog(
                                context: context,
                                builder: (context) => AlertDialogYesNo2(
                                      title: 'แจ้งเตือน',
                                      description: 'เปิดใช้งาน Vat7% ',
                                      pressYes: () {
                                        Navigator.pop(context, true);
                                      },
                                      pressNo: () {
                                        Navigator.pop(context, false);
                                      },
                                      orderNo: '',
                                    ));
                            if (vat == true) {
                              setState(() {
                                openvat = value;
                                prefs.setBool('statusvat', value);
                              });
                              //Navigator.push(context, MaterialPageRoute(builder: (context) => Printter()));
                            }
                          } else {
                            final vat = await showDialog(
                              context: context,
                              builder: (context) => AlertDialogYesNo2(
                                title: 'แจ้งเตือน',
                                description: 'ปิดใช้งาน Vat7% ',
                                pressYes: () {
                                  Navigator.pop(context, true);
                                },
                                pressNo: () {
                                  Navigator.pop(context, false);
                                },
                                orderNo: '',
                              ),
                            );
                            if (vat == true) {
                              setState(() {
                                openvat = value;
                                prefs.setBool('statusvat', value);
                              });
                            }
                          }
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      OpenAndCloseSwitch(
                        size: size,
                        open: openservicecharge,
                        showTextOpen: 'เปิด Service Charge %',
                        showTextClose: 'ปิด Service Charge %',
                        onChanged: (value) async {
                          final SharedPreferences prefs = await SharedPreferences.getInstance();
                          if (openservicecharge == false) {
                            final servicecharge = await showDialog(
                                context: context,
                                builder: (context) => AlertDialogYesNo2(
                                      title: 'แจ้งเตือน',
                                      description: 'เปิดใช้งาน Service Charge ',
                                      pressYes: () {
                                        Navigator.pop(context, true);
                                      },
                                      pressNo: () {
                                        Navigator.pop(context, false);
                                      },
                                      orderNo: '',
                                    ));
                            if (servicecharge == true) {
                              setState(() {
                                openservicecharge = value;
                                prefs.setBool('statusservicecharge', value);
                              });
                              //Navigator.push(context, MaterialPageRoute(builder: (context) => Printter()));
                            }
                          } else {
                            final servicecharge = await showDialog(
                              context: context,
                              builder: (context) => AlertDialogYesNo2(
                                title: 'แจ้งเตือน',
                                description: 'ปิดใช้งาน Service Charge ',
                                pressYes: () {
                                  Navigator.pop(context, true);
                                },
                                pressNo: () {
                                  Navigator.pop(context, false);
                                },
                                orderNo: '',
                              ),
                            );
                            if (servicecharge == true) {
                              setState(() {
                                openservicecharge = value;
                                prefs.setBool('statusservicecharge', value);
                              });
                            }
                          }
                        },
                      ),
                    ],
                  ),
                  openservicecharge == true
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Service charge",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            InputTextFormField(
                              width: size.width * 0.9,
                              controller: serviceChargeRate,
                              keyboardType: TextInputType.number,
                              label: Text("กรุณากรอกเลข ServiceCharge %"),
                            ),
                          ],
                        )
                      : SizedBox.shrink(),

                  SizedBox(
                    height: size.height * 0.15,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: GestureDetector(
          onTap: () async {
            if (selectBranch != null && selectDevice != null && selectPanel != null) {
              final prefs = await _prefs;
              await prefs.setInt('branch', selectBranch!.id);
              await prefs.setString("branchname", selectBranch!.name ?? "");
              await prefs.setInt("deviceid", selectDevice!.id);
              await prefs.setInt("panelid", selectPanel!.id);
              await prefs.setDouble("serviceChargeRate", openservicecharge == true ? double.parse(serviceChargeRate.text) : 0.00);
              if (!mounted) return;
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialogYes(
                    description: 'บันทึกสำเร็จ',
                    pressYes: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ProductPage()));
                    },
                    title: 'แจ้งเตือน',
                  );
                },
              );
            } else {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialogYes(
                    title: 'การแจ้งเตือน',
                    description: 'กรุณาเลือกสาขา,ดีไวร์เเละ ค่าserviceCharge',
                    pressYes: () {
                      Navigator.pop(context);
                    },
                  );
                },
              );
            }
          },
          child: Card(
            color: Colors.blue,
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: SizedBox(
              width: size.width * 0.9,
              height: size.height * 0.06,
              child: Center(
                  child: Text(
                'บันทึก',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'IBMPlexSansThai',
                ),
              )),
            ),
          ),
        ),
      ),
    );
  }
}
