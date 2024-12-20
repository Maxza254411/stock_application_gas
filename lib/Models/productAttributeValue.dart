import 'package:json_annotation/json_annotation.dart';

part 'productAttributeValue.g.dart';

@JsonSerializable()
class ProductAttributeValue {
  final int id;
  final String name;
  final double price;
  bool? checkSize;
  bool? checkMix;
  int? idAttribute;

  ProductAttributeValue(
    this.id,
    this.name,
    this.price, {
    this.checkSize,
    this.checkMix,
    this.idAttribute,
  });

  factory ProductAttributeValue.fromJson(Map<String, dynamic> json) => _$ProductAttributeValueFromJson(json);

  Map<String, dynamic> toJson() => _$ProductAttributeValueToJson(this);
}
