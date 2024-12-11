import 'dart:convert';

SingleMealModel singleMealModelFromJson(String str) =>
    SingleMealModel.fromJson(json.decode(str));

String singleMealModelToJson(SingleMealModel data) =>
    json.encode(data.toJson());

class SingleMealModel {
  String strMeal;
  String strMealThumb;
  String idMeal;

  SingleMealModel({
    required this.strMeal,
    required this.strMealThumb,
    required this.idMeal,
  });

  factory SingleMealModel.fromJson(Map<String, dynamic> json) =>
      SingleMealModel(
        strMeal: json["strMeal"] ?? 'Meal not found',
        strMealThumb: json["strMealThumb"] ?? 'Meal thumbnail not found',
        idMeal: json["idMeal"] ?? 'Meal id not found',
      );

  Map<String, dynamic> toJson() => {
        "strMeal": strMeal,
        "strMealThumb": strMealThumb,
        "idMeal": idMeal,
      };
}
