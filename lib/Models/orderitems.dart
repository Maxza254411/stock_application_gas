import 'package:json_annotation/json_annotation.dart';
import 'package:stock_application_gas/Models/attributesdto.dart';
import 'package:stock_application_gas/Models/product.dart';

part 'orderitems.g.dart';

@JsonSerializable()
class Orderitems {
  final int id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  final int quantity;
  final double price;
  final double total;
  final Product product;
  // final List<AttributesDto>? attributes;
  final String? remark;
  Orderitems(
    this.price,
    this.total,
    this.quantity,
    // this.attributes,
    this.createdAt,
    this.deletedAt,
    this.id,
    this.updatedAt,
    this.product,
    this.remark,
  );

  factory Orderitems.fromJson(Map<String, dynamic> json) => _$OrderitemsFromJson(json);

  Map<String, dynamic> toJson() => _$OrderitemsToJson(this);

  // String equat() {
  //   return attributes!.map((e) => "${e.attributeName}#${e.equat()}").join('#');
  // }
}
