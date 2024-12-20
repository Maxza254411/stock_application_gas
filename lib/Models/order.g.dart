// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      json['deletedAt'] == null
          ? null
          : DateTime.parse(json['deletedAt'] as String),
      (json['discount'] as num?)?.toDouble(),
      (json['grandTotal'] as num?)?.toDouble(),
      (json['id'] as num?)?.toInt(),
      json['orderDate'] == null
          ? null
          : DateTime.parse(json['orderDate'] as String),
      json['orderNo'] as String?,
      json['orderStatus'] as String?,
      (json['total'] as num?)?.toDouble(),
      json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      (json['orderPayments'] as List<dynamic>?)
          ?.map((e) => OrderPayment.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['orderItems'] as List<dynamic>?)
          ?.map((e) => Orderitems.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['change'] as num?)?.toDouble(),
      (json['paid'] as num?)?.toDouble(),
      json['remark'] as String?,
      (json['serviceChargeRate'] as num?)?.toDouble(),
      (json['serviceCharge'] as num?)?.toDouble(),
      (json['vat'] as num?)?.toDouble(),
      json['branch'] == null
          ? null
          : Branch.fromJson(json['branch'] as Map<String, dynamic>),
      json['device'] == null
          ? null
          : Device.fromJson(json['device'] as Map<String, dynamic>),
      json['createdBy'] == null
          ? null
          : CreatedBy.fromJson(json['createdBy'] as Map<String, dynamic>),
    )
      ..roomNo = json['roomNo'] as String?
      ..customerName = json['customerName'] as String?
      ..Hn = json['Hn'] as String?;

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'deletedAt': instance.deletedAt?.toIso8601String(),
      'orderNo': instance.orderNo,
      'orderDate': instance.orderDate?.toIso8601String(),
      'orderStatus': instance.orderStatus,
      'vat': instance.vat,
      'total': instance.total,
      'discount': instance.discount,
      'serviceChargeRate': instance.serviceChargeRate,
      'grandTotal': instance.grandTotal,
      'serviceCharge': instance.serviceCharge,
      'change': instance.change,
      'paid': instance.paid,
      'remark': instance.remark,
      'branch': instance.branch,
      'device': instance.device,
      'createdBy': instance.createdBy,
      'roomNo': instance.roomNo,
      'customerName': instance.customerName,
      'Hn': instance.Hn,
      'orderItems': instance.orderItems,
      'orderPayments': instance.orderPayments,
    };
