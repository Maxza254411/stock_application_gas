import 'package:flutter/material.dart';

class CardReprt extends StatefulWidget {
  const CardReprt({super.key});

  @override
  State<CardReprt> createState() => _CardReprtState();
}

class _CardReprtState extends State<CardReprt> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: SizedBox(
          width: size.width * 0.90,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [],
          ),
        ),
      ),
    );
    ;
  }
}
