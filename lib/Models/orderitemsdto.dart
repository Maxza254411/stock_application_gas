import 'package:json_annotation/json_annotation.dart';
import 'package:stock_application_gas/Models/attributesdto.dart';

part 'orderitemsdto.g.dart';

@JsonSerializable()
class OrderItemsDto {
  final int? productId;
  final double? price;
  int? quantity;
  double? total;
  // List<AttributesDto>? attributes;
  final String? remark;

  OrderItemsDto(
    this.productId,
    this.price,
    this.total,
    this.quantity,
    // this.attributes,
    this.remark,
  );

  factory OrderItemsDto.fromJson(Map<String, dynamic> json) => _$OrderItemsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemsDtoToJson(this);
}
