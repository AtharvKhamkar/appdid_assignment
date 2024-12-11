import 'package:appdid_assignment/models/recipe_category_model.dart';
import 'package:appdid_assignment/models/single_meal_details_model.dart';
import 'package:appdid_assignment/models/single_meal_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RecipeRepository {
  RecipeRepository();

  final dio = Dio();

  Future<List<RecipeCategoryModel>> getCategory() async {
    Response response;

    response =
        await dio.get('https://www.themealdb.com/api/json/v1/1/categories.php');

    debugPrint(
        'Response in the RecipeRepository : ${response.data['categories']}');

    final categoryList = (response.data['categories'] as List)
        .map((ele) => RecipeCategoryModel.fromJson(ele))
        .toList();

    return categoryList;
  }

  Future<List<SingleMealModel>> getSingleCategory(String categoryName) async {
    Response response;
    response = await dio.get(
        'https://www.themealdb.com/api/json/v1/1/filter.php?c=$categoryName');

    final mealsList = (response.data['meals'] as List)
        .map((ele) => SingleMealModel.fromJson(ele))
        .toList();
    return mealsList;
  }

  Future<List<SingleMealDetailsModel>> getSingleMealInfo(String id) async {
    Response response;
    response = await dio
        .get('https://www.themealdb.com/api/json/v1/1/lookup.php?i=$id');

    final mealInfo = (response.data['meals'] as List)
        .map((ele) => SingleMealDetailsModel.fromJson(ele))
        .toList();
    debugPrint('Response from the getSingleMealInfo is ${mealInfo}');
    return mealInfo;
  }
}
