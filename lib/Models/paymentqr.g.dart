// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paymentqr.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentQr _$PaymentQrFromJson(Map<String, dynamic> json) => PaymentQr(
      (json['total'] as num?)?.toDouble(),
      json['expiredate'] == null
          ? null
          : DateTime.parse(json['expiredate'] as String),
      json['image'] as String?,
    );

Map<String, dynamic> _$PaymentQrToJson(PaymentQr instance) => <String, dynamic>{
      'total': instance.total,
      'expiredate': instance.expiredate?.toIso8601String(),
      'image': instance.image,
    };
