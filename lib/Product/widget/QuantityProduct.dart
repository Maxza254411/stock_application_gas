import 'package:flutter/material.dart';
import 'package:stock_application_gas/Models/productAttribute.dart';

class QuantityProduct extends StatefulWidget {
  const QuantityProduct({Key? key, required this.productAttribute, required this.vicecall2}) : super(key: key);

  final ProductAttribute productAttribute;
  final Function(int) vicecall2;
  @override
  State<QuantityProduct> createState() => _QuantityProductState();
}

class _QuantityProductState extends State<QuantityProduct> {
  int qty2 = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  widget.productAttribute.name,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  '(+${widget.productAttribute.productAttributeValues[0].price.toStringAsFixed(0)})',
                  style: TextStyle(fontSize: 22),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    if (qty2 > 0) {
                      qty2--;
                    }
                  });
                  widget.vicecall2(qty2);
                },
                child: Container(
                  width: size.width * 0.1,
                  height: size.width * 0.1,
                  decoration: BoxDecoration(color: Color(0xFFCFD8DC), borderRadius: BorderRadius.circular(6)),
                  child: Icon(
                    Icons.remove,
                    size: 15,
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "$qty2",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    qty2++;
                  });
                  widget.vicecall2(qty2);
                },
                child: Container(
                  width: size.width * 0.1,
                  height: size.width * 0.1,
                  decoration: BoxDecoration(color: Color(0xFFCFD8DC), borderRadius: BorderRadius.circular(6)),
                  child: Icon(
                    Icons.add,
                    size: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
