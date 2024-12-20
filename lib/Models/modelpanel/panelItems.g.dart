// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'panelItems.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PanelItem _$PanelItemFromJson(Map<String, dynamic> json) => PanelItem(
      (json['id'] as num?)?.toInt(),
      json['name'] as String?,
      (json['panelProducts'] as List<dynamic>?)
          ?.map((e) => PanelProduct.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..active = json['active'] as bool?
      ..sequence = (json['sequence'] as num?)?.toInt();

Map<String, dynamic> _$PanelItemToJson(PanelItem instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'active': instance.active,
      'sequence': instance.sequence,
      'panelProducts': instance.panelProducts,
    };
