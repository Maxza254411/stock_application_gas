import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:stock_application_gas/Models/attributesdto.dart';
import 'package:stock_application_gas/Models/attributevaluesdto.dart';
import 'package:stock_application_gas/Models/orderitemsdto1.dart';
import 'package:stock_application_gas/Models/product.dart';
import 'package:stock_application_gas/Models/productAttribute.dart';
import 'package:stock_application_gas/Product/widget/Multiplepeoduct.dart';
import 'package:stock_application_gas/Product/widget/QuantityProduct.dart';
import 'package:stock_application_gas/Product/widget/SingelProduct.dart';
import 'package:stock_application_gas/widgets/Dialog.dart';

class OpenDialogProduct extends StatelessWidget {
  OpenDialogProduct({
    super.key,
    required this.product,
    required this.controller,
  });
  final ScrollController controller;

  final Product product;

  late OrderItemsDto1 orderItem = OrderItemsDto1(product.id, product.name ?? '', product.price ?? 0, product.price ?? 0, 1, [], null);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      controller: controller,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  product.name ?? '',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'IBMPlexSansThai',
                    fontSize: 25,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.close,
                  ),
                )
              ],
            ),
            Divider(
              color: Colors.black,
              thickness: 1.5,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                    children: List.generate(
                  product.productAttributes?.length ?? 0,
                  (index) => product.productAttributes![index].type == ProductAttributeType.single
                      ? SingelProduct(
                          productAttribute: product.productAttributes![index],
                          selectedValue: (value) {
                            final productAttribute = product.productAttributes![index];

                            final AttributeValuesDto attributeValuesDto = AttributeValuesDto(value.name, value.name, 1, value.price, value.price * 1);

                            final AttributesDto attributesDto =
                                AttributesDto(productAttribute.name, attributeValuesDto.total, ProductAttributeType.single, [attributeValuesDto]);

                            checkDuplicate(productAttribute, attributesDto);
                          },
                        )
                      : product.productAttributes![index].type == ProductAttributeType.quantity
                          ? QuantityProduct(
                              vicecall2: (value) {
                                final productAttribute = product.productAttributes![index];

                                final price = productAttribute.productAttributeValues[0].price;

                                final AttributeValuesDto attributeValuesDto =
                                    AttributeValuesDto(productAttribute.name, productAttribute.name, value, price, price * value);

                                final AttributesDto attributesDto = AttributesDto(
                                    productAttribute.name, attributeValuesDto.total, ProductAttributeType.quantity, [attributeValuesDto]);

                                checkDuplicate(productAttribute, attributesDto);
                              },
                              productAttribute: product.productAttributes![index],
                            )
                          : product.productAttributes![index].type == ProductAttributeType.multiple
                              ? Multiplepeoduct(
                                  vicecall3: (multiple) {
                                    final productAttribute = product.productAttributes![index];

                                    final List<AttributeValuesDto> att = [];
                                    for (var item in multiple) {
                                      final AttributeValuesDto attributeValuesDto =
                                          AttributeValuesDto(item.name, item.name, 1, item.price, item.price * 1);
                                      att.add(attributeValuesDto);
                                    }

                                    final total = att.fold(0.0, (total, e) => total + e.total);
                                    final AttributesDto attributesDto =
                                        AttributesDto(productAttribute.name, total, ProductAttributeType.multiple, att);

                                    checkDuplicate(productAttribute, attributesDto);
                                  },
                                  productAttribute: product.productAttributes![index],
                                )
                              : SizedBox(),
                )),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              children: [
                InkWell(
                  onTap: () async {
                    orderItem.total = orderItem.price + orderItem.totalAttribute();
                    if (orderItem.attributes?.isEmpty ?? true) {
                      return showDialog(
                        context: context,
                        builder: (context) => AlertDialogYes(
                          title: 'แจ้งเตือน',
                          description: 'ยังไม่ได้เลือกรายการ',
                          pressYes: () {
                            Navigator.pop(context);
                          },
                        ),
                      );
                    }

                    orderItem.attributes!.sortBy((a) => a.attributeName);

                    Navigator.pop(context, orderItem);
                  },
                  child: Container(
                      width: double.infinity,
                      height: size.height * 0.05,
                      decoration: BoxDecoration(
                          border: Border.all(color: const Color.fromARGB(255, 103, 106, 108)),
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(6)),
                      child: Center(
                        child: Text(
                          'ตกลง',
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                      width: double.infinity,
                      height: size.height * 0.05,
                      decoration: BoxDecoration(border: Border.all(color: Colors.red), borderRadius: BorderRadius.circular(6)),
                      child: Center(
                          child: Text(
                        'ยกเลิก',
                        style: TextStyle(color: Colors.red),
                      ))),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void checkDuplicate(ProductAttribute productAttribute, AttributesDto attributesDto) {
    int ii = 0;
    final attributeName = orderItem.attributes?.firstWhereIndexedOrNull((i, e) {
      ii = i;
      return e.attributeName == productAttribute.name;
    });

    if (attributeName == null) {
      orderItem.attributes?.add(attributesDto);
    } else {
      orderItem.attributes?[ii] = attributesDto;
    }
  }
}
