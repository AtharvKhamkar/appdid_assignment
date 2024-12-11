import 'dart:convert';

RecipeCategoryModel recipeCategoryModelFromJson(String str) =>
    RecipeCategoryModel.fromJson(json.decode(str));

String recipeCategoryModelToJson(RecipeCategoryModel data) =>
    json.encode(data.toJson());

class RecipeCategoryModel {
  String idCategory;
  String strCategory;
  String strCategoryThumb;
  String strCategoryDescription;

  RecipeCategoryModel({
    required this.idCategory,
    required this.strCategory,
    required this.strCategoryThumb,
    required this.strCategoryDescription,
  });

  factory RecipeCategoryModel.fromJson(Map<String, dynamic> json) =>
      RecipeCategoryModel(
        idCategory: json["idCategory"] ?? 'No category id found',
        strCategory: json["strCategory"] ?? 'No category name found',
        strCategoryThumb: json["strCategoryThumb"] ?? 'No category thumb found',
        strCategoryDescription:
            json["strCategoryDescription"] ?? 'No category description found',
      );

  Map<String, dynamic> toJson() => {
        "idCategory": idCategory,
        "strCategory": strCategory,
        "strCategoryThumb": strCategoryThumb,
        "strCategoryDescription": strCategoryDescription,
      };
}
