import 'package:json_annotation/json_annotation.dart';

part 'metaPage.g.dart';

@JsonSerializable()
class MetaPage {
  final int itemsPerPage;
  final int totalItems;
  final int currentPage;
  final int totalPages;

  MetaPage(
    this.itemsPerPage,
    this.totalItems,
    this.currentPage,
    this.totalPages,
  );

  factory MetaPage.fromJson(Map<String, dynamic> json) => _$MetaPageFromJson(json);

  Map<String, dynamic> toJson() => _$MetaPageToJson(this);
}
