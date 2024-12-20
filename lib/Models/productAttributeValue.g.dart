// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'productAttributeValue.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductAttributeValue _$ProductAttributeValueFromJson(
        Map<String, dynamic> json) =>
    ProductAttributeValue(
      (json['id'] as num).toInt(),
      json['name'] as String,
      (json['price'] as num).toDouble(),
      checkSize: json['checkSize'] as bool?,
      checkMix: json['checkMix'] as bool?,
      idAttribute: (json['idAttribute'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ProductAttributeValueToJson(
        ProductAttributeValue instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'checkSize': instance.checkSize,
      'checkMix': instance.checkMix,
      'idAttribute': instance.idAttribute,
    };
