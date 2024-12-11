import 'package:appdid_assignment/models/single_meal_model.dart';
import 'package:appdid_assignment/screens/single_meal_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/recipe_controller.dart';

class SingleCategoryInfoScreen extends StatefulWidget {
  final String categoryName;
  const SingleCategoryInfoScreen({super.key, required this.categoryName});

  @override
  State<SingleCategoryInfoScreen> createState() =>
      _SingleCategoryInfoScreenState();
}

class _SingleCategoryInfoScreenState extends State<SingleCategoryInfoScreen> {
  RecipeController recipeController = Get.put(RecipeController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    recipeController.getSingleCategory(widget.categoryName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Obx(() {
              if (recipeController.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(
                    backgroundColor: Colors.black,
                  ),
                );
              }

              if (recipeController.isLoading.value != true &&
                  recipeController.mealsList.isEmpty) {
                return const Center(
                  child: Text('No meal found!!'),
                );
              }

              if (recipeController.isLoading.value != true &&
                  recipeController.mealsList.isNotEmpty) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: recipeController.mealsList.length,
                    itemBuilder: (context, index) {
                      SingleMealModel singleMeal =
                          recipeController.mealsList[index];
                      return SingleMealInfo(singleMeal: singleMeal);
                    },
                  ),
                );
              }

              return const SizedBox.shrink();
            })
          ],
        ),
      ),
    );
  }
}

class SingleMealInfo extends StatelessWidget {
  const SingleMealInfo({
    super.key,
    required this.singleMeal,
  });

  final SingleMealModel singleMeal;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => SingleMealInfoScreen(
              mealId: singleMeal.idMeal,
              mealTitle: singleMeal.strMeal,
            ));
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: const BorderRadius.all(
            Radius.circular(24),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              singleMeal.strMeal,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Image.network(singleMeal.strMealThumb)
          ],
        ),
      ),
    );
  }
}
