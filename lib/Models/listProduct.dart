import 'package:json_annotation/json_annotation.dart';
import 'package:stock_application_gas/Models/attributevaluesdto.dart';
import 'package:stock_application_gas/Models/orderitemsdto.dart';
import 'package:stock_application_gas/Models/product.dart';
import 'package:stock_application_gas/Models/productAttributeValue.dart';

part 'listProduct.g.dart';

@JsonSerializable()
class ListProduct {
  Product product;
  ProductAttributeValue? attributeValues;
  List<ProductAttributeValue>? p0;
  List<AttributeValuesDto>? p1;
  List<ProductAttributeValue>? p2;
  OrderItemsDto? orderitemsdto;
  // TextEditingController? remarkfilde;

  ListProduct(
    this.product,
    this.attributeValues,
    this.p0,
    this.p1,
    this.p2,
    this.orderitemsdto,
    // this.remarkfilde
  );

  factory ListProduct.fromJson(Map<String, dynamic> json) => _$ListProductFromJson(json);

  Map<String, dynamic> toJson() => _$ListProductToJson(this);
}
