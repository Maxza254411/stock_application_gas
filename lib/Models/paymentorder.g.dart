// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paymentorder.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentOrder _$PaymentOrderFromJson(Map<String, dynamic> json) => PaymentOrder(
      (json['id'] as num).toInt(),
      json['orderStatus'] as String?,
      (json['total'] as num?)?.toDouble(),
      (json['discount'] as num?)?.toDouble(),
      (json['grandTotal'] as num?)?.toDouble(),
      (json['orderPayments'] as List<dynamic>?)
          ?.map((e) => OrderPayment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PaymentOrderToJson(PaymentOrder instance) =>
    <String, dynamic>{
      'id': instance.id,
      'orderStatus': instance.orderStatus,
      'total': instance.total,
      'discount': instance.discount,
      'grandTotal': instance.grandTotal,
      'orderPayments': instance.orderPayments,
    };
