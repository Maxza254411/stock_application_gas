import 'package:flutter/material.dart';
import 'package:stock_application_gas/Models/productAttribute.dart';
import 'package:stock_application_gas/Models/productAttributeValue.dart';

class Multiplepeoduct extends StatefulWidget {
  const Multiplepeoduct({
    Key? key, // ปรับเปลี่ยนการรับ Key
    required this.productAttribute,
    required this.vicecall3,
  }) : super(key: key); // แก้ไขการส่ง key ให้กับ super constructor
  final ProductAttribute productAttribute;
  final Function(List<ProductAttributeValue>) vicecall3;
  @override
  State<Multiplepeoduct> createState() => _MultiplepeoductState();
}

class _MultiplepeoductState extends State<Multiplepeoduct> {
  List<bool> _isSelectedList = [];
  List<ProductAttributeValue> toppingproduct = [];
  List<ProductAttributeValue> _toppingproduct = [];
  @override
  void initState() {
    super.initState();
    _isSelectedList = List<bool>.filled(
      widget.productAttribute.productAttributeValues.length,
      false,
    );
    if (widget.productAttribute.productAttributeValues.isNotEmpty) {
      setState(() {
        _toppingproduct = widget.productAttribute.productAttributeValues;
      });
    }
  }

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
              children: [
                Text(
                  widget.productAttribute.name,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 5,
            mainAxisExtent: 80,
            mainAxisSpacing: 5,
          ),
          itemCount: widget.productAttribute.productAttributeValues.length,
          itemBuilder: (_, index) {
            final productAttributeValue = widget.productAttribute.productAttributeValues[index];
            return GestureDetector(
              onTap: () {
                setState(() {
                  // _isSelectedList[index] = !_isSelectedList[index];
                  // toppingproduct.add(widget.productAttribute.productAttributeValues[index]);
                  if (_isSelectedList[index] = !_isSelectedList[index]) {
                    _toppingproduct[index].checkSize = _isSelectedList[index];
                  } else {
                    _toppingproduct[index].checkSize = _isSelectedList[index];
                  }

                  if (_isSelectedList[index] == true) {
                    toppingproduct.add(_toppingproduct[index]);
                  } else {
                    toppingproduct.removeAt(index);
                  }
                  // toppingproduct = _toppingproduct
                  //     .where(((element) => element == widget.productAttribute.productAttributeValues[index]))
                  //     .toList();
                });
              },
              child: Container(
                padding: EdgeInsets.all(6),
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(8),
                  color: _isSelectedList[index] ? Color(0xffE8EAF6) : Colors.white,
                ),
                height: size.height * 0.08,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      productAttributeValue.name,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '+${productAttributeValue.price.toStringAsFixed(0)}',
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
