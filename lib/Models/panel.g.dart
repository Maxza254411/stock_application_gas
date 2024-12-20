// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'panel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Panel _$PanelFromJson(Map<String, dynamic> json) => Panel(
      (json['id'] as num).toInt(),
      json['name'] as String,
      (json['panelProducts'] as List<dynamic>?)
          ?.map((e) => PanelProduct.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PanelToJson(Panel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'panelProducts': instance.panelProducts,
    };
