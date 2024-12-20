import 'package:json_annotation/json_annotation.dart';
import 'package:stock_application_gas/Models/panelproduct.dart';

part 'panel.g.dart';

@JsonSerializable()
class Panel {
  final int id;
  final String name;
  final List<PanelProduct>? panelProducts;

  Panel(
    this.id,
    this.name,
    this.panelProducts,
  );

  factory Panel.fromJson(Map<String, dynamic> json) => _$PanelFromJson(json);

  Map<String, dynamic> toJson() => _$PanelToJson(this);
}
