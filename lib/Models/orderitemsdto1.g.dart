// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orderitemsdto1.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderItemsDto1 _$OrderItemsDto1FromJson(Map<String, dynamic> json) =>
    OrderItemsDto1(
      (json['productId'] as num).toInt(),
      json['productName'] as String,
      (json['price'] as num).toDouble(),
      (json['total'] as num).toDouble(),
      (json['quantity'] as num).toInt(),
      (json['attributes'] as List<dynamic>?)
          ?.map((e) => AttributesDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['remark'] as String?,
    );

Map<String, dynamic> _$OrderItemsDto1ToJson(OrderItemsDto1 instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'productName': instance.productName,
      'price': instance.price,
      'quantity': instance.quantity,
      'total': instance.total,
      'attributes': instance.attributes,
      'remark': instance.remark,
    };
