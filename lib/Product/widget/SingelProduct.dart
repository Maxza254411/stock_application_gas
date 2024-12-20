import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:stock_application_gas/Models/productAttribute.dart';
import 'package:stock_application_gas/Models/productAttributeValue.dart';

class SingelProduct extends StatefulWidget {
  const SingelProduct({
    Key? key, // เพิ่ม Key เป็น parameter ของ constructor
    required this.productAttribute,
    required this.selectedValue,
  }) : super(key: key); // ส่ง Key ไปยัง super constructor
  final ProductAttribute productAttribute;
  final Function(ProductAttributeValue) selectedValue;
  @override
  State<SingelProduct> createState() => _SingelProductState();
}

class _SingelProductState extends State<SingelProduct> {
  ProductAttributeValue? selected;
  int? selectedIndexS;
  int? selectedIndexM;

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
                  selectedIndexS = index;
                });
                final selected = ProductAttributeValue(
                  productAttributeValue.id,
                  productAttributeValue.name,
                  productAttributeValue.price,
                  idAttribute: widget.productAttribute.id,
                );
                // }

                // // inspect(selected);
                // final out = {
                //   'productAttributeValue': productAttributeValue,
                //   'productID': widget.productAttribute.id
                // };
                widget.selectedValue(selected);
              },
              child: Container(
                padding: EdgeInsets.all(6),
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(8),
                  color: selectedIndexS == index ? Color(0xffE8EAF6) : Colors.white,
                ),
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
        // Wrap(
        //   children: List.generate(
        //     widget.productAttribute.productAttributeValues.length,
        //     (index) {
        //       final productAttributeValue = widget.productAttribute.productAttributeValues[index];
        //       return GestureDetector(
        //         onTap: () {
        //           setState(() {
        //             selectedIndexS = index;
        //           });
        //           final selected = ProductAttributeValue(
        //             productAttributeValue.id,
        //             productAttributeValue.name,
        //             productAttributeValue.price,
        //             idAttribute: widget.productAttribute.id,
        //           );
        //           // }
        //           // // inspect(selected);
        //           // final out = {
        //           //   'productAttributeValue': productAttributeValue,
        //           //   'productID': widget.productAttribute.id
        //           // };
        //           widget.selectedValue(selected);
        //         },
        //         child: Container(
        //           padding: EdgeInsets.all(16),
        //           margin: EdgeInsets.all(8),
        //           decoration: BoxDecoration(
        //             border: Border.all(color: Colors.blue),
        //             borderRadius: BorderRadius.circular(8),
        //             color: selectedIndexS == index ? Color(0xffE8EAF6) : Colors.white,
        //           ),
        //           height: size.height * 0.08,
        //           width: size.width * 0.25,
        //           child: Center(
        //             child: Text(
        //               productAttributeValue.name,
        //               style: TextStyle(fontSize: 15),
        //             ),
        //           ),
        //         ),
        //       );
        //     },
        //   ),
        // ),
      ],
    );
  }
}
