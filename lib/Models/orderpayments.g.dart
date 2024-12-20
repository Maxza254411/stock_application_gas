// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orderpayments.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderPayments _$OrderPaymentsFromJson(Map<String, dynamic> json) =>
    OrderPayments(
      (json['paymentMethodId'] as num).toInt(),
      (json['amount'] as num).toDouble(),
      json['remark'] as String?,
    );

Map<String, dynamic> _$OrderPaymentsToJson(OrderPayments instance) =>
    <String, dynamic>{
      'paymentMethodId': instance.paymentMethodId,
      'amount': instance.amount,
      'remark': instance.remark,
    };
