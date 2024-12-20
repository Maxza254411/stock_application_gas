import 'package:json_annotation/json_annotation.dart';
import 'package:stock_application_gas/Models/metaPage.dart';
import 'package:stock_application_gas/models/reservedatas.dart';

part 'orderDate.g.dart';

@JsonSerializable()
class OrderDate {
  List<Reservedatas>? data;
  MetaPage? meta;

  OrderDate({
    this.data,
    this.meta,
  });

  factory OrderDate.fromJson(Map<String, dynamic> json) => _$OrderDateFromJson(json);

  Map<String, dynamic> toJson() => _$OrderDateToJson(this);
}
