import 'package:json_annotation/json_annotation.dart';
import 'package:stock_application_gas/Models/attributesdto.dart';

part 'orderitemsdto1.g.dart';

@JsonSerializable()
class OrderItemsDto1 {
  final int productId;
  final String productName;
  final double price;
  int quantity;
  double total;
  List<AttributesDto>? attributes;
  String? remark;

  OrderItemsDto1(
    this.productId,
    this.productName,
    this.price,
    this.total,
    this.quantity,
    this.attributes,
    this.remark,
  );

  factory OrderItemsDto1.fromJson(Map<String, dynamic> json) => _$OrderItemsDto1FromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemsDto1ToJson(this);

  String equat() {
    return attributes?.map((e) => "${e.attributeName}#${e.equat()}").join('#') ?? '';
  }

  double totalAttribute() {
    return attributes?.fold(0.0, (sum, a) => sum! + a.total) ?? 0.0;
  }
}
