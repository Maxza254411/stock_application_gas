// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'createdBy.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreatedBy _$CreatedByFromJson(Map<String, dynamic> json) => CreatedBy(
      (json['id'] as num?)?.toInt(),
      json['firstName'] as String?,
      json['lastName'] as String?,
    );

Map<String, dynamic> _$CreatedByToJson(CreatedBy instance) => <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
    };
