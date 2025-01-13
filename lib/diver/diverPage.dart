import 'package:flutter/material.dart';
import 'package:stock_application_gas/constants.dart';

class Diverpage extends StatefulWidget {
  const Diverpage({super.key});

  @override
  State<Diverpage> createState() => _DiverpageState();
}

class _DiverpageState extends State<Diverpage> {
  List<Widget> containers = [];
  Widget _buildContainer(String text, {Color color = Colors.blueAccent}) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
    );
  }

  void _addContainer() {
    setState(() {
      containers.add(_buildContainer('Container ${containers.length + 2}'));
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
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
        title: Center(
          child: Text(
            'หน้าการจัดการของคนขับ',
            style: TextStyle(color: kTextButtonColor, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  height: size.height * 0.8,
                  width: size.width * 0.9,
                  child: ListView.builder(
                    itemCount: containers.length,
                    itemBuilder: (context, index) {
                      return _buildContainer('Container 1', color: Colors.blueAccent);
                    },
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _addContainer();
                    });
                  },
                  child: Container(
                    width: size.width * 0.07,
                    height: size.width * 0.07,
                    decoration: BoxDecoration(
                      color: Color(0xFFCFD8DC),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Icon(
                      Icons.add,
                      size: 15,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
