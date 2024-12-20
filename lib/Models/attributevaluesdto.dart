import 'package:json_annotation/json_annotation.dart';

part 'attributevaluesdto.g.dart';

@JsonSerializable()
class AttributeValuesDto {
  final String? attributeValueName;
  final String attributeName;
  final int quantity;
  final double price;
  final double total;

  AttributeValuesDto(this.attributeValueName, this.attributeName, this.quantity, this.price, this.total);

  factory AttributeValuesDto.fromJson(Map<String, dynamic> json) => _$AttributeValuesDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AttributeValuesDtoToJson(this);
}
