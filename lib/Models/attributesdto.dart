import 'package:json_annotation/json_annotation.dart';
import 'package:stock_application_gas/Models/attributevaluesdto.dart';
import 'package:stock_application_gas/Models/productAttribute.dart';

part 'attributesdto.g.dart';

@JsonSerializable()
class AttributesDto {
  final String attributeName;
  final double total;
  final ProductAttributeType? type;
  final List<AttributeValuesDto> attributeValues;

  AttributesDto(this.attributeName, this.total, this.type, this.attributeValues);

  factory AttributesDto.fromJson(Map<String, dynamic> json) => _$AttributesDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AttributesDtoToJson(this);

  String equat() {
    return type == ProductAttributeType.quantity
        ? attributeValues.map((e) => '${e.attributeName}${e.quantity}').join('#')
        : attributeValues.map((e) => e.attributeName).join('#');
  }
}
