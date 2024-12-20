// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservedatas.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Reservedatas _$ReservedatasFromJson(Map<String, dynamic> json) => Reservedatas(
      (json['id'] as num?)?.toInt(),
      json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      json['deletedAt'] == null
          ? null
          : DateTime.parse(json['deletedAt'] as String),
      json['orderNo'] as String?,
      json['orderDate'] == null
          ? null
          : DateTime.parse(json['orderDate'] as String),
      json['orderStatus'] as String?,
      (json['total'] as num?)?.toDouble(),
      (json['discount'] as num?)?.toDouble(),
      (json['grandTotal'] as num?)?.toDouble(),
      (json['change'] as num?)?.toDouble(),
      (json['paid'] as num?)?.toDouble(),
      (json['deviceId'] as num?)?.toInt(),
      json['receivedStatus'] as String?,
      (json['serviceChargeRate'] as num?)?.toInt(),
      (json['serviceCharge'] as num?)?.toInt(),
      (json['vat'] as num?)?.toDouble(),
      json['Hn'] as String?,
      json['customerName'] as String?,
      json['remark'] as String?,
      json['voidReason'] as String?,
      json['roomNo'] as String?,
      json['member'] == null
          ? null
          : Members.fromJson(json['member'] as Map<String, dynamic>),
      (json['orderItems'] as List<dynamic>?)
          ?.map((e) => Orderitems.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['orderPayments'] as List<dynamic>?)
          ?.map((e) => OrderPayment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReservedatasToJson(Reservedatas instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'deletedAt': instance.deletedAt?.toIso8601String(),
      'orderNo': instance.orderNo,
      'orderDate': instance.orderDate?.toIso8601String(),
      'orderStatus': instance.orderStatus,
      'total': instance.total,
      'discount': instance.discount,
      'grandTotal': instance.grandTotal,
      'change': instance.change,
      'paid': instance.paid,
      'deviceId': instance.deviceId,
      'receivedStatus': instance.receivedStatus,
      'serviceChargeRate': instance.serviceChargeRate,
      'serviceCharge': instance.serviceCharge,
      'vat': instance.vat,
      'Hn': instance.Hn,
      'customerName': instance.customerName,
      'remark': instance.remark,
      'voidReason': instance.voidReason,
      'roomNo': instance.roomNo,
      'member': instance.member,
      'orderItems': instance.orderItems,
      'orderPayments': instance.orderPayments,
    };
