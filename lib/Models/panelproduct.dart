import 'package:json_annotation/json_annotation.dart';
import 'package:stock_application_gas/Models/product.dart';

part 'panelproduct.g.dart';

@JsonSerializable()
class PanelProduct {
  final int id;
  final String txtColor;
  final String bgColor;
  final Product? product;

  PanelProduct(
    this.id,
    this.txtColor,
    this.bgColor,
    this.product,
  );

  factory PanelProduct.fromJson(Map<String, dynamic> json) => _$PanelProductFromJson(json);

  Map<String, dynamic> toJson() => _$PanelProductToJson(this);
}
