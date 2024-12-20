// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orderitems.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Orderitems _$OrderitemsFromJson(Map<String, dynamic> json) => Orderitems(
      (json['price'] as num).toDouble(),
      (json['total'] as num).toDouble(),
      (json['quantity'] as num).toInt(),
      json['createdAt'] == null ? null : DateTime.parse(json['createdAt'] as String),
      json['deletedAt'] == null ? null : DateTime.parse(json['deletedAt'] as String),
      (json['id'] as num).toInt(),
      json['updatedAt'] == null ? null : DateTime.parse(json['updatedAt'] as String),
      Product.fromJson(json['product'] as Map<String, dynamic>),
      json['remark'] as String?,
    );

Map<String, dynamic> _$OrderitemsToJson(Orderitems instance) => <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'deletedAt': instance.deletedAt?.toIso8601String(),
      'quantity': instance.quantity,
      'price': instance.price,
      'total': instance.total,
      'product': instance.product,
      'remark': instance.remark,
    };
