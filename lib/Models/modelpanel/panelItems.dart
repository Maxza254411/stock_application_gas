import 'package:json_annotation/json_annotation.dart';
import 'package:stock_application_gas/Models/panelproduct.dart';

part 'panelItems.g.dart';

@JsonSerializable()
class PanelItem {
  int? id;
  String? name;
  bool? active;
  int? sequence;
  List<PanelProduct>? panelProducts;

  PanelItem(
    this.id,
    this.name,
    this.panelProducts,
  );

  factory PanelItem.fromJson(Map<String, dynamic> json) => _$PanelItemFromJson(json);

  Map<String, dynamic> toJson() => _$PanelItemToJson(this);
}
