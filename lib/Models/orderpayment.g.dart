// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orderpayment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderPayment _$OrderPaymentFromJson(Map<String, dynamic> json) => OrderPayment(
      (json['id'] as num).toInt(),
      (json['amount'] as num?)?.toDouble(),
      json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      json['deletedAt'] == null
          ? null
          : DateTime.parse(json['deletedAt'] as String),
      json['order'] == null
          ? null
          : Order.fromJson(json['order'] as Map<String, dynamic>),
      json['remark'] as String?,
      json['status'] as String?,
      json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      json['paymentMethod'] == null
          ? null
          : PaymentMethod.fromJson(
              json['paymentMethod'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrderPaymentToJson(OrderPayment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'deletedAt': instance.deletedAt?.toIso8601String(),
      'amount': instance.amount,
      'remark': instance.remark,
      'status': instance.status,
      'order': instance.order,
      'paymentMethod': instance.paymentMethod,
    };
