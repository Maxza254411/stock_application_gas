// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'metaPage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MetaPage _$MetaPageFromJson(Map<String, dynamic> json) => MetaPage(
      (json['itemsPerPage'] as num).toInt(),
      (json['totalItems'] as num).toInt(),
      (json['currentPage'] as num).toInt(),
      (json['totalPages'] as num).toInt(),
    );

Map<String, dynamic> _$MetaPageToJson(MetaPage instance) => <String, dynamic>{
      'itemsPerPage': instance.itemsPerPage,
      'totalItems': instance.totalItems,
      'currentPage': instance.currentPage,
      'totalPages': instance.totalPages,
    };
