import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stock_application_gas/constants.dart';
import 'package:stock_application_gas/store/%20dailysales/profit.dart';
import 'package:stock_application_gas/store/storePage.dart';
import 'package:stock_application_gas/widgets/Dialog.dart';
import 'package:stock_application_gas/widgets/LoadingDialog.dart';
import 'package:stock_application_gas/widgets/input.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart' as picker;

class DailySalesPage extends StatefulWidget {
  const DailySalesPage({super.key});

  @override
  State<DailySalesPage> createState() => _DailySalesPageState();
}

class _DailySalesPageState extends State<DailySalesPage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  TextEditingController money = TextEditingController();
  String headtitle = '';
  String pickerDate = DateFormat('dd/MM/y').format(DateTime.now());
  String? stringTime;
  getprefs() async {
    final SharedPreferences prefs = await _prefs;
    final title = prefs.getString('title');
    setState(() {
      headtitle = title ?? '';
    });
  }

  List<String> mockItems = ['ค่าจ้างพนักงาน', 'ค่าเช่าร้าน', 'ค่ายานพาหนะ', 'ค่าน้ำมัน', 'ค่าใช้จ่ายจิปาถะ'];
  String? selectedItem; // รายการที่เลือก
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getprefs();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        toolbarHeight: size.height * 0.1,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: kbutton,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => Storepage(
                    store: headtitle,
                  ),
                ),
                (route) => false);
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(''),
            Text(
              'รายงานการขายประจำวัน',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            Image.asset(
              'assets/icons/backgroundAsset_LoGo_24x 2.png',
              scale: 10,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  picker.DatePicker.showDatePicker(
                    context,
                    showTitleActions: true,
                    currentTime: DateTime.now(),
                    locale: picker.LocaleType.th,
                    minTime: DateTime(1900, 1, 1),
                    maxTime: DateTime(2200, 1, 1),
                    theme: picker.DatePickerTheme(
                      containerHeight: size.height * 0.5,
                      itemHeight: size.height * 0.075,
                      titleHeight: size.height * 0.08,
                      headerColor: kbutton,
                      backgroundColor: Colors.white,
                      itemStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
                      doneStyle: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
                      cancelStyle: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    // onChanged: (date) {
                    //   print('change $date in time zone ' + date.timeZoneOffset.inHours.toString());
                    // },
                    onConfirm: (date) async {
                      print('confirm $date');
                      setState(
                        () {
                          pickerDate = DateFormat('dd/MM/y').format(date);
                          stringTime = "\$btw:${DateFormat('yyyy-MM-dd').format(date)} 00:00:00,${DateFormat('yyyy-MM-dd').format(date)} 23:59:59";
                        },
                      );
                      LoadingDialog.open(context);
                      // await getOrder(status: status, roomNo: roomNo.text == '' ? null : roomNo.text, date: stringTime);
                      if (!mounted) return;
                      LoadingDialog.close(context);
                    },
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  width: double.infinity,
                  height: size.height * 0.06,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 198, 196, 196),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        pickerDate == '' ? 'เลือกวันที่' : pickerDate,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(Icons.search)
                    ],
                  ),
                ),
              ),
            ),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  reportTank.length,
                  (index) {
                    return Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Container(
                        width: size.width * 0.8,
                        height: size.height * 0.25,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey[300],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        'ขนาด${reportTank[index]['km'] ?? ''}',
                                        style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        reportTank[index]['date'] ?? '',
                                        style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(reportTank[index]['brand'] ?? '',
                                          style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text('จำนวน ${reportTank[index]['unit']}',
                                          style: TextStyle(color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                      flex: 2,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: Text('หมายเหตุ',
                                            style: TextStyle(
                                              color: Color(0xff5C5C5C),
                                              fontSize: 20,
                                            )),
                                      )),
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(reportTank[index]['remark'] ?? '',
                                          style: TextStyle(
                                            color: Color(0xff5C5C5C),
                                            fontSize: 20,
                                          )),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: size.height * 0.06,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  final ok = await showDialog(
                                    context: context,
                                    builder: (context) => AlertDialogYesNo(
                                      title: 'แจ้งเตือน',
                                      description: 'ถังจะส่งในยอดถังปล่าวต้องการเก็บคืนถังหรือไม่',
                                      pressYes: () {
                                        Navigator.pop(context, true);
                                      },
                                      pressNo: () {
                                        Navigator.pop(context, false);
                                      },
                                    ),
                                  );
                                  if (ok == true) {
                                    Navigator.pop(context);
                                    // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.red,
                                  ),
                                  width: size.width * 0.4,
                                  height: size.height * 0.06,
                                  child: Center(
                                    child: Text(
                                      'เรียกเก็บคืนเเล้ว',
                                      style: TextStyle(fontSize: 20, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            // SingleChildScrollView(
            //   scrollDirection: Axis.vertical,
            //   child: SingleChildScrollView(
            //     scrollDirection: Axis.horizontal,
            //     child: Column(
            //       children: [
            //         DataTable(
            //           columns: <DataColumn>[
            //             DataColumn(label: Text('วันที่')),
            //             DataColumn(label: Text('รหัสสินค้า')),
            //             DataColumn(label: Text('ประเภท')),
            //             DataColumn(label: Text('น้ำหนัก')),
            //             DataColumn(label: Text('ยี่ห้อ')),
            //             DataColumn(label: Text('ราคา')),
            //             DataColumn(label: Text('จำนวน')),
            //             DataColumn(label: Text('ถังเคลม')),
            //             DataColumn(label: Text('ประเภทการจ่าย')),
            //             DataColumn(label: Text('จำวนรวม')),
            //           ],
            //           rows: <DataRow>[
            //             DataRow(
            //               color: WidgetStateProperty.resolveWith<Color?>(
            //                 (Set<WidgetState> states) {
            //                   return Colors.grey[200];
            //                 },
            //               ),
            //               cells: <DataCell>[
            //                 DataCell(Text('11-12-2025')),
            //                 DataCell(Text('0734')),
            //                 DataCell(Text('ถังใหม่')),
            //                 DataCell(Text('15')),
            //                 DataCell(Text('ปตท')),
            //                 DataCell(Text('425')),
            //                 DataCell(Text('2')),
            //                 DataCell(Text('ปกติ')),
            //                 DataCell(Text('เงินสด')),
            //                 DataCell(Text('160')),
            //               ],
            //             ),
            //             DataRow(
            //               color: WidgetStateProperty.resolveWith<Color?>(
            //                 (Set<WidgetState> states) {
            //                   return Colors.white;
            //                 },
            //               ),
            //               cells: <DataCell>[
            //                 DataCell(Text('11-12-2025')),
            //                 DataCell(Text('0742')),
            //                 DataCell(Text('น้ำแก็ส')),
            //                 DataCell(Text('04')),
            //                 DataCell(Text('ส.ว.ย')),
            //                 DataCell(Text('500')),
            //                 DataCell(Text('2')),
            //                 DataCell(Text('ปกติ')),
            //                 DataCell(Text('โอน')),
            //                 DataCell(Text('160')),
            //               ],
            //             ),
            //             DataRow(
            //               color: WidgetStateProperty.resolveWith<Color?>(
            //                 (Set<WidgetState> states) {
            //                   return Colors.grey[200];
            //                 },
            //               ),
            //               cells: <DataCell>[
            //                 DataCell(Text('11-12-2025')),
            //                 DataCell(Text('0734')),
            //                 DataCell(Text('ถังใหม่')),
            //                 DataCell(Text('15')),
            //                 DataCell(Text('ปตท')),
            //                 DataCell(Text('425')),
            //                 DataCell(Text('2')),
            //                 DataCell(Text('ปกติ')),
            //                 DataCell(Text('เงินสด')),
            //                 DataCell(Text('160')),
            //               ],
            //             ),
            //           ],
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(8),
        child: SizedBox(
          height: size.height * 0.07,
          width: size.width * 0.4,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: size.width * 0.45,
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
                    // padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: () async {
                    final item = await showModalBottomSheet(
                      backgroundColor: Colors.white,
                      context: context,
                      isScrollControlled: true, // ทำให้แผงเลื่อนขึ้นได้เต็มจอ
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      builder: (BuildContext context) {
                        return Container(
                          width: size.width * 0.95,
                          height: size.height * 0.45,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
                          child: Column(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: Card(
                                  surfaceTintColor: Colors.white,
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  elevation: 2,
                                  child: DropdownSearch<String>(
                                    selectedItem: selectedItem,
                                    items: mockItems,
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
                                        hintText: 'เลือกประเภทค่าใช้จ่าย',
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
                                        selectedItem = value;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      'ยอดเงิน',
                                      style: TextStyle(color: Colors.black, fontSize: 20),
                                    ),
                                    InputTextFormField(
                                      width: size.width * 0.4,
                                      controller: money,
                                      hintText: 'กรอกยอดเงิน',
                                      fillcolor: Colors.white,
                                      keyboardType: TextInputType.number,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: size.width * 0.45,
                                decoration: BoxDecoration(),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: kbutton,
                                    // side: BorderSide(color: textColor),
                                    // padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                  onPressed: () async {
                                    Navigator.pop(context);
                                    money.clear();
                                  },
                                  child: Text(
                                    'up Date',
                                    style: TextStyle(color: Colors.white, fontSize: 20),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Text(
                    'ค่าใช้จ่ายอื่นๆ',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              Container(
                width: size.width * 0.45,
                decoration: BoxDecoration(),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kbutton,
                    // side: BorderSide(color: textColor),
                    // padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: () async {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Profit(),
                        ),
                        (route) => false);
                  },
                  child: Text(
                    'ดูผลกำไร',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
