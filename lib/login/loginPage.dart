import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stock_application_gas/Product/ProductPage.dart';
import 'package:stock_application_gas/adminPage.dart';
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
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Stack(
          children: [
            Center(
              child: SizedBox(
                width: double.infinity,
                child: Image.asset(
                  "assets/images/Sign Up.jpg",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Center(
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.1,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: height(context) / 7.5),
                    child: Image.asset('assets/images/Gas Logo.png', scale: 3),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: size.height * 0.4,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 20,
                            color: Colors.black.withOpacity(.1),
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          // Text(
                          //   'ระบบจัดการสต็อก',
                          //   style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
                          // ),
                          Text(
                            'login',
                            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          InputTextFormField(
                            width: size.width * 0.8,
                            hintText: 'ชื่อผู้ใช้งาน',
                            fillcolor: Colors.white,
                            controller: username,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          InputTextFormField(
                            width: size.width * 0.8,
                            controller: password,
                            hintText: 'รหัสผ่าน',
                            obscureText: _obscureText,
                            fillcolor: Colors.white,
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
                          Container(
                            color: Colors.transparent, // ทำให้พื้นหลังเป็นโปร่งใส
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: InkWell(
                                onTap: () async {
                                  if (username.text != '' && password.text != '') {
                                    // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Adminpage()), (route) => true);
                                    try {
                                      LoadingDialog.open(context);
                                      // final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
                                      // final SharedPreferences prefs = await _prefs;
                                      // await prefs.setString('domain', publicUrl);
                                      // final login = await LoginService.login(username.text, password.text);
                                      // await prefs.setString('token', login);
                                      // if (!mounted) return;
                                      // LoadingDialog.close(context);
                                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Adminpage()), (route) => true);
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
                                child: BottomNavigator(
                                  size: size,
                                  title: 'เข้าสู่ระบบ',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  // Text(
                  //   'ระบบจัดการสต็อก',
                  //   style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
                  // ),
                  // SizedBox(
                  //   height: size.height * 0.05,
                  // ),
                  // Text(
                  //   'login',
                  //   style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
                  // ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  // InputTextFormField(
                  //   width: size.width * 0.8,
                  //   controller: username,
                  //   hintText: 'ชื่อผู้ใช้งาน',
                  // ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  // InputTextFormField(
                  //   width: size.width * 0.8,
                  //   controller: password,
                  //   hintText: 'รหัสผ่าน',
                  //   obscureText: _obscureText,
                  //   suffixIcon: IconButton(
                  //     onPressed: () {
                  //       setState(() {
                  //         _obscureText = !_obscureText;
                  //       });
                  //     },
                  //     icon: Icon(
                  //       _obscureText ? Icons.visibility : Icons.visibility_off,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: Container(
      //   color: Colors.transparent, // ทำให้พื้นหลังเป็นโปร่งใส
      //   child: Padding(
      //     padding: EdgeInsets.all(8),
      //     child: InkWell(
      //       onTap: () async {
      //         if (username.text != '' && password.text != '') {
      //           try {
      //             LoadingDialog.open(context);
      //             final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
      //             final SharedPreferences prefs = await _prefs;
      //             // await prefs.setString('domain', publicUrl);
      //             // final login = await LoginService.login(username.text, password.text);
      //             // await prefs.setString('token', login);
      //             if (!mounted) return;
      //             LoadingDialog.close(context);
      //             Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => FirstPage()), (route) => true);
      //           } on Exception catch (e) {
      //             if (!mounted) return;
      //             LoadingDialog.close(context);
      //             showDialog(
      //               context: context,
      //               builder: (context) => AlertDialogYes(
      //                 title: 'แจ้งเตือน',
      //                 description: '$e',
      //                 pressYes: () {
      //                   Navigator.pop(context);
      //                 },
      //               ),
      //             );
      //           }
      //         } else {
      //           showDialog(
      //             context: context,
      //             builder: (context) => AlertDialogYes(
      //               title: 'แจ้งเตือน',
      //               description: 'กรุณากรอกชื่อผู้ใช้งานและรหัสผ่าน',
      //               pressYes: () {
      //                 Navigator.pop(context);
      //               },
      //             ),
      //           );
      //         }
      //       },
      //       child: Container(
      //         width: size.width * 0.8,
      //         height: size.height * 0.06,
      //         decoration: BoxDecoration(
      //           color: kbutton,
      //           borderRadius: BorderRadius.circular(10),
      //         ),
      //         child: Center(
      //           child: Text(
      //             'เข้าสู่ระบบ',
      //             style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
      //           ),
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}

class BottomNavigator extends StatelessWidget {
  const BottomNavigator({
    super.key,
    required this.size,
    required this.title,
  });

  final Size size;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.8,
      height: size.height * 0.06,
      decoration: BoxDecoration(
        color: kbutton,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
