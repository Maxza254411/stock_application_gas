// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orderitemsdto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderItemsDto _$OrderItemsDtoFromJson(Map<String, dynamic> json) => OrderItemsDto(
      (json['productId'] as num?)?.toInt(),
      (json['price'] as num?)?.toDouble(),
      (json['total'] as num?)?.toDouble(),
      (json['quantity'] as num?)?.toInt(),
      json['remark'] as String?,
    );

Map<String, dynamic> _$OrderItemsDtoToJson(OrderItemsDto instance) => <String, dynamic>{
      'productId': instance.productId,
      'price': instance.price,
      'quantity': instance.quantity,
      'total': instance.total,
      'remark': instance.remark,
    };
