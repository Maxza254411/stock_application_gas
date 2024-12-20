// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orderDate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderDate _$OrderDateFromJson(Map<String, dynamic> json) => OrderDate(
      data: (json['data'] as List<dynamic>?)?.map((e) => Reservedatas.fromJson(e as Map<String, dynamic>)).toList(),
      meta: json['meta'] == null ? null : MetaPage.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrderDateToJson(OrderDate instance) => <String, dynamic>{
      'data': instance.data?.map((e) => e.toJson()).toList(),
      'meta': instance.meta?.toJson(),
    };
