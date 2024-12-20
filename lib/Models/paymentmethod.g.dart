// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paymentmethod.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentMethod _$PaymentMethodFromJson(Map<String, dynamic> json) =>
    PaymentMethod(
      (json['id'] as num).toInt(),
      json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      json['deletedAt'] == null
          ? null
          : DateTime.parse(json['deletedAt'] as String),
      json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      json['icon'] as String?,
      json['name'] as String?,
      json['orderPayments'] == null
          ? null
          : OrderPayment.fromJson(
              json['orderPayments'] as Map<String, dynamic>),
      json['type'] as String?,
      json['name_2'] as String?,
    );

Map<String, dynamic> _$PaymentMethodToJson(PaymentMethod instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'deletedAt': instance.deletedAt?.toIso8601String(),
      'name': instance.name,
      'name_2': instance.name_2,
      'icon': instance.icon,
      'type': instance.type,
      'orderPayments': instance.orderPayments,
    };
