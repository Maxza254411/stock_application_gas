// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderDto _$OrderDtoFromJson(Map<String, dynamic> json) => OrderDto(
      (json['total'] as num).toDouble(),
      (json['deviceId'] as num?)?.toInt(),
      (json['branchId'] as num?)?.toInt(),
      json['remark'] as String?,
      (json['grandtotal'] as num).toDouble(),
      (json['serviceCharge'] as num).toDouble(),
      (json['serviceChargeRate'] as num).toDouble(),
      (json['vat'] as num).toDouble(),
      json['Hn'] as String?,
      json['customerName'] as String?,
      json['roomNo'] as String?,
      (json['orderItems'] as List<dynamic>?)
          ?.map((e) => OrderItemsDto1.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderDtoToJson(OrderDto instance) => <String, dynamic>{
      'total': instance.total,
      'deviceId': instance.deviceId,
      'branchId': instance.branchId,
      'grandtotal': instance.grandtotal,
      'serviceCharge': instance.serviceCharge,
      'serviceChargeRate': instance.serviceChargeRate,
      'vat': instance.vat,
      'Hn': instance.Hn,
      'customerName': instance.customerName,
      'roomNo': instance.roomNo,
      'remark': instance.remark,
      'orderItems': instance.orderItems,
    };
