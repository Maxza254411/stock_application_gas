import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
// import 'package:imin_printer/imin_printer.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stock_application_gas/Models/attributesdto.dart';
import 'package:stock_application_gas/Models/attributevaluesdto.dart';
import 'package:stock_application_gas/Models/listProduct.dart';
import 'package:stock_application_gas/Models/order_dto.dart';
import 'package:stock_application_gas/Models/orderitemsdto.dart';
import 'package:stock_application_gas/Models/orderitemsdto1.dart';
import 'package:stock_application_gas/Models/panel.dart';
import 'package:stock_application_gas/Models/productAttributeValue.dart';
import 'package:stock_application_gas/Product/SelectedItem/selectedItem.dart';
import 'package:stock_application_gas/Product/SettingPage.dart';
import 'package:stock_application_gas/Product/service/productController.dart';
import 'package:stock_application_gas/Product/widget/ListItemProduct.dart';
import 'package:stock_application_gas/Product/widget/OpenDialogProduct.dart';
import 'package:stock_application_gas/constants.dart';
import 'package:stock_application_gas/login/loginPage.dart';
import 'package:stock_application_gas/widgets/Dialog.dart';
import 'package:stock_application_gas/widgets/LoadingDialog.dart';
import 'package:stock_application_gas/widgets/viewPhoto.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late SharedPreferences prefs;
  // final iminPrinter = IminPrinter();
  int? branch;
  int? device;
  Panel? selectPanel;
  int? panelID;

  double? sumprice;
  int point = 0;
  double totalprice = 0.00;
  int totalqty = 0;
  List<ListProduct> selectedItem = [];
  List<OrderItemsDto> orderItemsDto = [];
  List<List<ListProduct>> showSelectedItem = [];
  ProductAttributeValue? selected;
  List<List<OrderItemsDto>> orderItemsDtos = [];

  ProductAttributeValue? selectedSize;
  int? selectedPrice = 0;
  OrderItemsDto? orderitemsdto;
  double? priceAll = 0.0;
  List<AttributesDto> attributes = [];
  List<AttributeValuesDto> singelProduct0 = [];
  List<ProductAttributeValue> singelProduct1 = [];
  int? quantityProduct1;
  List<AttributeValuesDto> quantityProduct = [];
  List<ProductAttributeValue>? multiplepeoduct2;
  List<AttributeValuesDto> multiplepeoduct = [];

  late OrderItemsDto1? orderItem;

  List<OrderDto> orderDtoList = [];

  bool openservicecharge = false;
  bool openvat = false;
  double serviceChargePer = 0.0;
  bool opennumroom = false;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();
    orderDtoList.add(OrderDto(0, 0, 0, null, 0, 0, 0, 0, null, null, null, []));
    // initPrinter();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getBranch();
      if (panelID != null) {
        getItemPanel(panel: panelID!);
      }
      if (branch != null) {
        await getlistPanel();
      }
    });
    setState(() {
      showSelectedItem.insert(point, selectedItem);
      orderItemsDtos.insert(point, orderItemsDto);
    });
  }

  // Future<void> initPrinter() async {
  //   await iminPrinter.initPrinter();
  //   final status = await iminPrinter.getPrinterStatus();
  //   if (status == 'Failed to initialize the printer!') {
  //     await iminPrinter.resetDevice();
  //     initPrinter();
  //   }
  // }

  Future<void> getBranch() async {
    SharedPreferences.getInstance();
    prefs = await SharedPreferences.getInstance();
    branch = prefs.getInt('branch');
    device = prefs.getInt('deviceid');
    panelID = prefs.getInt('panelid');
    openservicecharge = prefs.getBool('statusservicecharge') ?? false;
    openvat = prefs.getBool('statusvat') ?? false;
    serviceChargePer = prefs.getDouble('serviceChargeRate') ?? 0.0;
    opennumroom = prefs.getBool('statusnumroom') ?? false;
  }

  Future<void> getlistPanel() async {
    try {
      await context.read<ProductController>().getListPanel(branchId: branch.toString());
      final getListPanels = context.read<ProductController>().panels;
      for (var i = 0; i < getListPanels.length; i++) {
        if (getListPanels[i].id == panelID) {
          setState(() {
            selectPanel = getListPanels[i];
          });
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

  Future<void> getItemPanel({required int panel}) async {
    try {
      LoadingDialog.open(context);
      await context.read<ProductController>().getItemPanel(panelID: panel);
      if (!mounted) return;
      LoadingDialog.close(context);
    } on Exception catch (e) {
      if (!mounted) return;
      LoadingDialog.close(context);
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
    // }
  }

  // Map ที่ใช้เก็บ productId และ quantity รวม
  Map<int, int> productQuantities = {};

  void combineQuantities(List<OrderItemsDto1> orderItems) {
    for (var item in orderItems) {
      if (productQuantities.containsKey(item.productId)) {
        productQuantities[item.productId] = productQuantities[item.productId]! + item.quantity;
      } else {
        productQuantities[item.productId] = item.quantity;
      }
    }
  }

  Future<void> clearToken() async {
    SharedPreferences prefs = await _prefs;
    prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // final underlineInputBorder = UnderlineInputBorder(
    //   borderRadius: BorderRadius.circular(30),
    //   borderSide: BorderSide(color: Colors.black, width: 1),
    // );

    for (var orderDto in orderDtoList) {
      orderDto.total = orderDto.orderItems!.fold(0.0, (sum, curr) => sum + curr.total);
      orderDto.grandtotal = orderDto.orderItems!.fold(0.0, (sum, curr) => sum + curr.total);
    }
    return Scaffold(
      backgroundColor: kTextButtonColor,
      appBar: AppBar(
        backgroundColor: Colors.black,
        // leading: GestureDetector(
        //   onTap: () {
        //     Navigator.push(context, MaterialPageRoute(builder: (context) {
        //       return SettingPage();
        //     }));
        //   },
        //   child: Icon(
        //     Icons.list,
        //     color: Colors.white,
        //   ),
        // ),
        centerTitle: true,
        title: Text(
          "รายการ",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 25),
        ),
        actions: [
          GestureDetector(
            onTap: () async {
              final out = await showDialog(
                context: context,
                builder: (context) => AlertDialogLockOut(
                  title: 'แจ้งเตือน',
                  description: 'ยืนยันที่จะออกจากระบบ',
                  pressYes: () {
                    Navigator.pop(context, true);
                  },
                  pressNo: () {
                    Navigator.pop(context, false);
                  },
                ),
              );
              if (out == true) {
                await clearToken();
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginPage()), (route) => true);
              }
            },
            child: Container(
              width: 35,
              height: 35,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Image.asset(
                "assets/images/Vector-2.png",
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Consumer<ProductController>(
        builder: (context, controller, child) => SingleChildScrollView(
          child: Column(
            children: [
              controller.panels.isEmpty || selectPanel == null
                  ? SizedBox.shrink()
                  : Column(children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        height: size.height * 0.09,
                        width: double.infinity,
                        color: kTabColor,
                        child: Row(
                          children: [
                            SizedBox(
                              height: size.height * 0.1,
                              width: size.width * 0.9,
                              child: DropdownSearch<Panel>(
                                selectedItem: selectPanel,
                                // items: listProvinec,
                                items: controller.panels,
                                itemAsString: (item) => item.name,
                                popupProps: PopupProps.menu(
                                  constraints: BoxConstraints(maxHeight: 450),
                                  // showSearchBox: true,
                                  fit: FlexFit.loose,
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
                                        // Divider()
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
                                  baseStyle: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    fontFamily: 'Prompt',
                                  ),
                                  dropdownSearchDecoration: InputDecoration(
                                    hintText: 'SelectPanel',
                                    hintStyle: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Prompt',
                                    ),
                                    border: InputBorder.none,
                                    suffixIconColor: Colors.grey,
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    selectPanel = value;
                                    if (value != null) {
                                      getItemPanel(panel: value.id);
                                    }
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
              SizedBox(
                height: 10,
              ),
              controller.panelItem?.panelProducts?.isEmpty ?? true
                  ? SizedBox.shrink()
                  : Column(
                      children: List.generate(
                        controller.panelItem?.panelProducts?.length ?? 0,
                        (index) {
                          return GestureDetector(
                            onTap: () async {
                              final product = controller.panelItem?.panelProducts?[index].product;
                              if (product!.productAttributes!.isEmpty) {
                                final OrderItemsDto1 orderItem =
                                    OrderItemsDto1(product.id, product.name ?? '', product.price ?? 0, product.price ?? 0, 1, [], null);
                                setState(() {
                                  for (var orderItem in orderDtoList[point].orderItems!) {
                                    if (orderItem.productId == product.id) {
                                      if (orderItem.equat() == orderItem.equat()) {
                                        orderItem.quantity += 1;
                                        orderItem.total = (orderItem.price + orderItem.totalAttribute()) * orderItem.quantity;
                                        return;
                                      }
                                    }
                                  }
                                  orderDtoList[point].orderItems?.add(orderItem);
                                });
                              } else {
                                final item = await showModalBottomSheet<OrderItemsDto1>(
                                  isDismissible: false,
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (context) => DraggableScrollableSheet(
                                    expand: false,
                                    builder: (context, scrollController) => OpenDialogProduct(
                                      product: product,
                                      controller: scrollController,
                                    ),
                                  ),
                                );

                                if (item != null) {
                                  // widget.onChange(item);
                                  setState(() {
                                    for (var orderItem in orderDtoList[point].orderItems!) {
                                      if (item.equat() == orderItem.equat()) {
                                        orderItem.quantity += 1;
                                        orderItem.total = (orderItem.price + orderItem.totalAttribute()) * orderItem.quantity;
                                        return;
                                      }
                                    }
                                    orderDtoList[point].orderItems?.add(item);
                                  });
                                }
                              }
                            },
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.94,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0.0),
                                ),
                                color: Colors.white70,
                                elevation: 10,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: ConstrainedBox(
                                        constraints: BoxConstraints(
                                          maxWidth: MediaQuery.of(context).size.width * 0.28,
                                          maxHeight: MediaQuery.of(context).size.width * 0.28,
                                        ),
                                        child: GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).push(MaterialPageRoute(
                                                  builder: (_) => ImagePhotoview(
                                                        // image1: bgImg.length < 255 ? baseUrl + bgImg : bgImg,
                                                        image1: '',
                                                      )));
                                            },
                                            // child: Image.asset('assets/images/bannerLogin.png', fit: BoxFit.fill)),
                                            child: Image.asset(imagemog[index]['image'] ?? 'assets/images/bannerLogin.png', fit: BoxFit.fill)),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            SizedBox(
                                              width: MediaQuery.of(context).size.width * 0.45,
                                              child: Padding(
                                                padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
                                                child: Text(
                                                  controller.panelItem?.panelProducts?[index].product?.name ?? '',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
                                                  ),
                                                  maxLines: 3,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context).size.width * 0.45,
                                              child: Padding(
                                                padding: const EdgeInsets.fromLTRB(5, 5, 0, 0),
                                                child: Text(
                                                  '฿ ${controller.panelItem?.panelProducts?[index].product?.price ?? ''}',
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        orderDtoList[0].orderItems?.isEmpty ?? true
                                            ? SizedBox.shrink()
                                            : Builder(
                                                builder: (context) {
                                                  int currentProductId = controller.panelItem!.panelProducts![index].product!.id;
                                                  int totalQuantity = orderDtoList[0]
                                                      .orderItems!
                                                      .where((item) => item.productId == currentProductId)
                                                      .fold(0, (sum, item) => sum + item.quantity);

                                                  return totalQuantity > 0
                                                      ? Container(
                                                          width: size.width * 0.12,
                                                          height: size.height * 0.05,
                                                          decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(15)),
                                                          child: Center(
                                                              child: Text(
                                                            '$totalQuantity',
                                                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                                                          )),
                                                        )
                                                      : SizedBox.shrink();
                                                },
                                              ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

              //  ListItemProduct(
              //     listItem: controller.panelItem!.panelProducts!,
              //     size: size,
              //     onChange: (value) {
              //       setState(() {
              //         for (var orderItem in orderDtoList[point].orderItems!) {
              //           if (value.equat() == orderItem.equat()) {
              //             orderItem.quantity += 1;
              //             orderItem.total = (orderItem.price + orderItem.totalAttribute()) * orderItem.quantity;
              //             return;
              //           }
              //         }

              //         orderDtoList[point].orderItems?.add(value);
              //       });
              //     },
              //     orderDtoList: orderDtoList,
              //   ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: orderDtoList.isEmpty
          ? SizedBox.shrink()
          : orderDtoList[0].orderItems?.isEmpty ?? true
              ? SizedBox.shrink()
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: GestureDetector(
                    onTap: () async {
                      if (orderDtoList[point].orderItems!.isNotEmpty) {
                        orderDtoList[point].deviceId = device;
                        orderDtoList[point].branchId = branch;
                        orderDtoList[point].grandtotal = orderDtoList[point].total;
                        final callback = await Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return Selecteditem(
                            orderDtoList: orderDtoList,
                            serviceChargePer: serviceChargePer,
                            openservicecharge: openservicecharge,
                            openvat: openvat,
                            opennumroom: opennumroom,
                          );
                        }));
                        if (callback != null) {
                          setState(() {
                            orderDtoList = callback;
                            // orderDtoList.clear();
                            // orderDtoList.add(OrderDto(0, 0, 0, null, 0, 0, 0, 0, null, null, null, []));
                          });
                        }
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialogYes(
                            title: 'แจ้งเตือน',
                            description: 'กรุณาเลือกสินค้า',
                            pressYes: () {
                              Navigator.pop(context, true);
                            },
                          ),
                        );
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      width: double.infinity,
                      height: size.height * 0.08,
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
                              '${orderDtoList[point].sumQuantity()}',
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
                            '${orderDtoList[point].grandtotal.toStringAsFixed(2)} ฿',
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
    );
  }
}
