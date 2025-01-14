import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:stock_application_gas/constants.dart';
import 'package:stock_application_gas/diver/diverMenu/diverMenuPage.dart';
import 'package:stock_application_gas/login/loginPage.dart';
import 'package:stock_application_gas/widgets/Dialog.dart';

class DiverPage extends StatefulWidget {
  const DiverPage({super.key});

  @override
  State<DiverPage> createState() => _DiverPageState();
}

class _DiverPageState extends State<DiverPage> {
  List<String> containers = [];

  List<String?> selectedItemtank = [];
  List<String?> selectedStore = [];

  void _addContainer() {
    setState(() {
      containers.add('${containers.length + 1}');
    });
  }

  void _removeContainer(int index) {
    setState(() {
      containers.removeAt(index);
    });
  }

  @override
  void initState() {
    super.initState();
    // เพิ่ม Container เริ่มต้นหลังจากหน้าโหลดเสร็จ
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _addContainer();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: size.height * 0.1,
        automaticallyImplyLeading: false,
        backgroundColor: kbutton,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(''),
            Text(
              'หน้าการจัดการคนขับ',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            Image.asset(
              'assets/icons/backgroundAsset_LoGo_24x 2.png',
              scale: 10,
            ),
          ],
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () {
                Scaffold.of(context).openDrawer(); // เปิด Drawer
              },
              child: Icon(
                Icons.menu,
                color: Colors.white,
              ),
            );
          },
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: kbutton,
              ),
              child: Row(
                children: [
                  Image.asset(
                    'assets/icons/backgroundAsset_LoGo_24x 2.png',
                    scale: 10,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'NEW PETRO',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.output_outlined),
              title: Text('LogOut'),
              onTap: () async {
                final ok = await showDialog(
                  context: context,
                  builder: (context) => AlertDialogYesNo(
                    title: 'แจ้งเตือน',
                    description: 'คุณต้องการออกจากระบบหรือไม่',
                    pressYes: () {
                      Navigator.pop(context, true);
                    },
                    pressNo: () {
                      Navigator.pop(context, false);
                    },
                  ),
                );
                if (ok == true) {
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
                }
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: size.width * 0.85,
                  height: size.height * 0.7,
                  child: ListView.builder(
                    itemCount: containers.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: size.width * 0.05,
                        margin: EdgeInsets.all(8),
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: size.width * 0.7,
                                  height: size.height * 0.08,
                                  child: Card(
                                    surfaceTintColor: Colors.white,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    elevation: 2,
                                    child: DropdownSearch<String>(
                                      selectedItem: index < selectedItemtank.length ? selectedItemtank[index] : null,
                                      items: tanktype,
                                      popupProps: PopupProps.menu(
                                        menuProps: MenuProps(
                                          backgroundColor: Colors.white,
                                        ),
                                        fit: FlexFit.loose,
                                        constraints: BoxConstraints(),
                                        itemBuilder: (context, item, isSelected) => Container(
                                          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                item,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
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
                                          hintText: 'เลือกประเภทถัง',
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
                                          if (index < selectedItemtank.length) {
                                            selectedItemtank[index] = value;
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    index != 0
                                        ? GestureDetector(
                                            onTap: () async {
                                              final ok = await showDialog(
                                                context: context,
                                                builder: (context) => AlertDialogYesNo(
                                                  title: 'แจ้งเตือน',
                                                  description: 'คุณต้องการจะลบรายการนี้ใช่หรือไม่',
                                                  pressYes: () {
                                                    Navigator.pop(context, true);
                                                  },
                                                  pressNo: () {
                                                    Navigator.pop(context, false);
                                                  },
                                                ),
                                              );
                                              if (ok == true) {
                                                _removeContainer(index);
                                              }
                                            },
                                            child: Icon(Icons.highlight_remove_outlined),
                                          )
                                        : SizedBox.shrink()
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: size.width * 0.7,
                                  height: size.height * 0.08,
                                  child: Card(
                                    surfaceTintColor: Colors.white,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    elevation: 2,
                                    child: DropdownSearch<String>(
                                      selectedItem: index < selectedStore.length ? selectedStore[index] : null,
                                      items: numberStore,
                                      popupProps: PopupProps.menu(
                                        menuProps: MenuProps(
                                          backgroundColor: Colors.white,
                                        ),
                                        fit: FlexFit.loose,
                                        constraints: BoxConstraints(),
                                        itemBuilder: (context, item, isSelected) => Container(
                                          width: 10,
                                          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                item,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
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
                                          hintText: 'ร้านค้า',
                                          hintStyle: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Prompt',
                                          ),
                                          border: InputBorder.none,
                                          suffixIconColor: Colors.grey,
                                        ),
                                      ),
                                      onChanged: (value) {
                                        setState(
                                          () {
                                            if (index < selectedStore.length) {
                                              selectedStore[index] = value;
                                            }
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _addContainer();
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Container(
                      width: size.width * 0.1,
                      height: size.height * 0.05,
                      decoration: BoxDecoration(
                        color: Color(0xFFCFD8DC),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.add,
                        size: 15,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(8),
        child: SizedBox(
          height: size.height * 0.07,
          width: size.width * 0.4,
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: kbutton,
                // side: BorderSide(color: textColor),
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onPressed: () async {
                final ok = await showDialog(
                  context: context,
                  builder: (context) => AlertDialogYesNo(
                    title: 'แจ้งเตือน',
                    description: 'คุณต้องการเลือกรายการต่อไปนี้ใช่หรือไม่',
                    pressYes: () {
                      Navigator.pop(context, true);
                    },
                    pressNo: () {
                      Navigator.pop(context, false);
                    },
                  ),
                );
                if (ok == true) {
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Divermenupage()), (route) => false);
                }
              },
              child: Text(
                'เลือก',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
