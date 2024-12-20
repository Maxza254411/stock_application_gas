// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'panelproduct.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PanelProduct _$PanelProductFromJson(Map<String, dynamic> json) => PanelProduct(
      (json['id'] as num).toInt(),
      json['txtColor'] as String,
      json['bgColor'] as String,
      json['product'] == null
          ? null
          : Product.fromJson(json['product'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PanelProductToJson(PanelProduct instance) =>
    <String, dynamic>{
      'id': instance.id,
      'txtColor': instance.txtColor,
      'bgColor': instance.bgColor,
      'product': instance.product,
    };
