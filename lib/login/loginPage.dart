import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stock_application_gas/Product/ProductPage.dart';
import 'package:stock_application_gas/constants.dart';
import 'package:stock_application_gas/fristpage.dart';
import 'package:stock_application_gas/login/loginService.dart';
import 'package:stock_application_gas/login/settingAPI.dart';
import 'package:stock_application_gas/widgets/Dialog.dart';
import 'package:stock_application_gas/widgets/LoadingDialog.dart';
import 'package:stock_application_gas/widgets/input.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  bool _obscureText = true;
  String? domain;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.immersiveSticky,
      );
    });
    getDonain();
  }

  getDonain() async {
    final SharedPreferences prefs = await _prefs;
    final domain2 = prefs.getString('domain');
    setState(() {
      domain = domain2 ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Container(
        height: size.height * 1,
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue,
              Colors.white,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     GestureDetector(
                //       onTap: () {
                //         Navigator.push(context, MaterialPageRoute(builder: (context) {
                //           return SettingAPIPage();
                //         }));
                //       },
                //       child: Container(
                //         margin: EdgeInsets.all(8),
                //         width: size.width * 0.25,
                //         height: size.height * 0.06,
                //         decoration: BoxDecoration(
                //           color: Colors.blue,
                //           borderRadius: BorderRadius.circular(10),
                //         ),
                //         child: Center(
                //             child: Text(
                //           'แก้ไข API',
                //           style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                //         )),
                //       ),
                //     ),
                //     Padding(
                //       padding: const EdgeInsets.all(8.0),
                //       child: Text(
                //         domain ?? '',
                //         style: TextStyle(
                //           fontSize: 15,
                //           fontWeight: FontWeight.bold,
                //           color: Colors.grey,
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                SizedBox(
                  height: size.height * 0.1,
                ),
                // Image.asset('assets/images/bannerLogin.png'),
                Text(
                  'ระบบจัดการสต็อก',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                SizedBox(
                  height: size.height * 0.1,
                ),
                Text(
                  'login',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                SizedBox(
                  height: 20,
                ),
                InputTextFormField(
                  width: size.width * 0.8,
                  controller: username,
                  hintText: 'ชื่อผู้ใช้งาน',
                ),
                SizedBox(
                  height: 20,
                ),
                InputTextFormField(
                  width: size.width * 0.8,
                  controller: password,
                  hintText: 'รหัสผ่าน',
                  obscureText: _obscureText,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: InkWell(
          onTap: () async {
            if (username.text != '' && password.text != '') {
              try {
                LoadingDialog.open(context);
                final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
                final SharedPreferences prefs = await _prefs;
                await prefs.setString('domain', publicUrl);
                final login = await LoginService.login(username.text, password.text);
                await prefs.setString('token', login);
                if (!mounted) return;
                LoadingDialog.close(context);
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => FirstPage()), (route) => true);
              } on Exception catch (e) {
                if (!mounted) return;
                LoadingDialog.close(context);
                showDialog(
                  context: context,
                  builder: (context) => AlertDialogYes(
                    title: 'แจ้งเตือน',
                    description: '$e',
                    pressYes: () {
                      Navigator.pop(context);
                    },
                  ),
                );
              }
            } else {
              showDialog(
                context: context,
                builder: (context) => AlertDialogYes(
                  title: 'แจ้งเตือน',
                  description: 'กรุณากรอกชื่อผู้ใช้งานและรหัสผ่าน',
                  pressYes: () {
                    Navigator.pop(context);
                  },
                ),
              );
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
              'เข้าสู่ระบบ',
              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            )),
          ),
        ),
      ),
    );
  }
}
