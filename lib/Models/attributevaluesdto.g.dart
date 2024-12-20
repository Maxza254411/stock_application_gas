// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attributevaluesdto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttributeValuesDto _$AttributeValuesDtoFromJson(Map<String, dynamic> json) =>
    AttributeValuesDto(
      json['attributeValueName'] as String?,
      json['attributeName'] as String,
      (json['quantity'] as num).toInt(),
      (json['price'] as num).toDouble(),
      (json['total'] as num).toDouble(),
    );

Map<String, dynamic> _$AttributeValuesDtoToJson(AttributeValuesDto instance) =>
    <String, dynamic>{
      'attributeValueName': instance.attributeValueName,
      'attributeName': instance.attributeName,
      'quantity': instance.quantity,
      'price': instance.price,
      'total': instance.total,
    };
