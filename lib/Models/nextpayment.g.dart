// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nextpayment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NextPayment _$NextPaymentFromJson(Map<String, dynamic> json) => NextPayment(
      json['next'] as bool,
      json['orderPayment'] == null
          ? null
          : OrderPayment.fromJson(json['orderPayment'] as Map<String, dynamic>),
      json['payment'] == null
          ? null
          : PaymentQr.fromJson(json['payment'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NextPaymentToJson(NextPayment instance) =>
    <String, dynamic>{
      'next': instance.next,
      'orderPayment': instance.orderPayment,
      'payment': instance.payment,
    };
