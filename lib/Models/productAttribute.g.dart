// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'productAttribute.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductAttribute _$ProductAttributeFromJson(Map<String, dynamic> json) =>
    ProductAttribute(
      (json['id'] as num).toInt(),
      json['name'] as String,
      $enumDecode(_$ProductAttributeTypeEnumMap, json['type']),
      (json['productAttributeValues'] as List<dynamic>)
          .map((e) => ProductAttributeValue.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductAttributeToJson(ProductAttribute instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': _$ProductAttributeTypeEnumMap[instance.type]!,
      'productAttributeValues': instance.productAttributeValues,
    };

const _$ProductAttributeTypeEnumMap = {
  ProductAttributeType.single: 'single',
  ProductAttributeType.quantity: 'quantity',
  ProductAttributeType.multiple: 'multiple',
};
