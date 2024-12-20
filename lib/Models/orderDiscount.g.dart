// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orderDiscount.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderDiscount _$OrderDiscountFromJson(Map<String, dynamic> json) =>
    OrderDiscount(
      json['name'] as String,
      json['description'] as String?,
      (json['amount'] as num?)?.toDouble(),
      json['code'] as String?,
    );

Map<String, dynamic> _$OrderDiscountToJson(OrderDiscount instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'amount': instance.amount,
      'code': instance.code,
    };
