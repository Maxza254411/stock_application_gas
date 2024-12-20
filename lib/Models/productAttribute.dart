import 'package:json_annotation/json_annotation.dart';
import 'package:stock_application_gas/Models/productAttributeValue.dart';

part 'productAttribute.g.dart';

enum ProductAttributeType { single, quantity, multiple }

@JsonSerializable()
class ProductAttribute {
  final int id;
  final String name;
  final ProductAttributeType type;
  final List<ProductAttributeValue> productAttributeValues;

  ProductAttribute(
    this.id,
    this.name,
    this.type,
    this.productAttributeValues,
  );

  factory ProductAttribute.fromJson(Map<String, dynamic> json) => _$ProductAttributeFromJson(json);

  Map<String, dynamic> toJson() => _$ProductAttributeToJson(this);
}
