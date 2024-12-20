// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      (json['id'] as num).toInt(),
      json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      json['deletedAt'] == null
          ? null
          : DateTime.parse(json['deletedAt'] as String),
      json['code'] as String?,
      json['name'] as String?,
      json['unit'] == null
          ? null
          : Unit.fromJson(json['unit'] as Map<String, dynamic>),
      json['image'] as String?,
      (json['price'] as num?)?.toDouble(),
      json['category'] == null
          ? null
          : Category.fromJson(json['category'] as Map<String, dynamic>),
      (json['productAttributes'] as List<dynamic>?)
          ?.map((e) => ProductAttribute.fromJson(e as Map<String, dynamic>))
          .toList(),
      qty: (json['qty'] as num?)?.toInt() ?? 1,
      priceQTY: (json['priceQTY'] as num?)?.toDouble() ?? 0,
      priceAll: (json['priceAll'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'deletedAt': instance.deletedAt?.toIso8601String(),
      'code': instance.code,
      'name': instance.name,
      'image': instance.image,
      'price': instance.price,
      'category': instance.category,
      'unit': instance.unit,
      'productAttributes': instance.productAttributes,
      'priceAll': instance.priceAll,
      'priceQTY': instance.priceQTY,
      'qty': instance.qty,
    };
