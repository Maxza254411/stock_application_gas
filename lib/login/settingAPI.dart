import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stock_application_gas/Product/ProductPage.dart';
import 'package:stock_application_gas/login/loginPage.dart';
import 'package:stock_application_gas/login/loginService.dart';
import 'package:stock_application_gas/widgets/LoadingDialog.dart';
import 'package:stock_application_gas/widgets/input.dart';

class SettingAPIPage extends StatefulWidget {
  const SettingAPIPage({super.key});

  @override
  State<SettingAPIPage> createState() => _SettingAPIPageState();
}

class _SettingAPIPageState extends State<SettingAPIPage> {
  TextEditingController api = TextEditingController();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String? apiTest;

  @override
  void initState() {
    super.initState();
    getDonain();
  }

  getDonain() async {
    final SharedPreferences prefs = await _prefs;
    final domain = prefs.getString('domain');
    setState(() {
      api.text = domain ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('ตั้งค่า API'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.08,
              ),
              Image.asset('assets/images/bannerLogin.png'),
              SizedBox(
                height: size.height * 0.1,
              ),
              Text(
                'ตั้งค่า API',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              InputTextFormField(
                width: size.width * 0.8,
                controller: api,
                hintText: 'ตั้งค่า API',
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () async {
                  LoadingDialog.open(context);
                  try {
                    final login = await LoginService.checkAPI(api: api.text);
                    setState(() {
                      apiTest = login;
                    });
                    LoadingDialog.close(context);
                  } catch (e) {
                    LoadingDialog.close(context);
                    setState(() {
                      apiTest = 'Failed';
                    });
                  }
                },
                child: Container(
                  width: size.width * 0.8,
                  height: size.height * 0.06,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                      child: Text(
                    'TEST API',
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  )),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              apiTest == null
                  ? SizedBox.shrink()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: size.width * 0.08,
                          height: size.height * 0.04,
                          decoration: BoxDecoration(
                            color: apiTest == 'ok' ? Colors.green : Colors.red,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(
                            apiTest == 'ok' ? Icons.check : Icons.cancel_outlined,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          apiTest == 'ok' ? 'Success' : 'Failed',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: apiTest != 'ok' || apiTest == null
          ? SizedBox.shrink()
          : BottomAppBar(
              color: Colors.white,
              child: Container(
                height: size.height * 0.05,
                decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(15)),
                child: Center(
                  child: TextButton(
                    onPressed: () async {
                      final SharedPreferences prefs = await _prefs;
                      final token = prefs.getString('token');
                      await prefs.setString('domain', api.text);
                      if (token != null) {
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => ProductPage()), (route) => true);
                      } else {
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginPage()), (route) => true);
                      }
                    },
                    child: Text(
                      'บันทึก',
                      style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
