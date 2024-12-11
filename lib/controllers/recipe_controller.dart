import 'package:appdid_assignment/models/recipe_category_model.dart';
import 'package:appdid_assignment/models/single_meal_details_model.dart';
import 'package:appdid_assignment/models/single_meal_model.dart';
import 'package:appdid_assignment/repository/recipe_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecipeController extends GetxController {
  RxList<RecipeCategoryModel> categoryList = <RecipeCategoryModel>[].obs;
  RxList<SingleMealModel> mealsList = <SingleMealModel>[].obs;
  RxList<SingleMealDetailsModel> mealDetailsList =
      <SingleMealDetailsModel>[].obs;

  Rx<bool> isLoading = false.obs;

  RecipeRepository recipeRepository = RecipeRepository();

  void getRecipeCategory() async {
    categoryList.clear();
    isLoading(true);

    try {
      List<RecipeCategoryModel> categoryInfo =
          await recipeRepository.getCategory();

      categoryList.addAll(categoryInfo);
      isLoading(false);
    } catch (e) {
      debugPrint('Error while fetchin recipe category :: $e');
    }
  }

  void getSingleCategory(String categoryName) async {
    mealsList.clear();
    isLoading(true);
    try {
      List<SingleMealModel> singleCategory =
          await recipeRepository.getSingleCategory(categoryName);

      mealsList.addAll(singleCategory);
      isLoading(false);
    } catch (e) {
      debugPrint('Error while fetchin getSingleCategory :: $e');
    }
  }

  void getSingleMealInfo(String id) async {
    isLoading(true);
    try {
      final singleMeal = await recipeRepository.getSingleMealInfo(id);
      List<SingleMealDetailsModel> singleMealDetail =
          await recipeRepository.getSingleMealInfo(id);

      mealDetailsList.addAll(singleMealDetail);

      isLoading(false);
    } catch (e) {
      debugPrint('Error while fetchin single meal info :: $e');
    }
  }
}
