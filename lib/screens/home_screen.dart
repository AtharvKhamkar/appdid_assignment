import 'package:appdid_assignment/controllers/recipe_controller.dart';
import 'package:appdid_assignment/models/recipe_category_model.dart';
import 'package:appdid_assignment/screens/single_category_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  RecipeController recipeController = Get.put(RecipeController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Durations.medium4, () {
      recipeController.getRecipeCategory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body:
          // Center(
          //   child: ElevatedButton(
          //       onPressed: () {
          //         recipeController.getRecipeCategory();
          //       },
          //       child: const Text('Get Category')),
          // ),
          Column(
        children: [
          Obx(() {
            if (recipeController.isLoading.value) {
              return const Center(
                child: CircularProgressIndicator.adaptive(
                  backgroundColor: Colors.black,
                ),
              );
            }

            if (recipeController.categoryList.isEmpty) {
              return const Center(
                child: Text('No category found'),
              );
            }

            if (recipeController.isLoading.value != true &&
                recipeController.categoryList.isNotEmpty) {
              return Expanded(
                child: ListView.builder(
                  itemCount: recipeController.categoryList.length,
                  itemBuilder: (context, index) {
                    RecipeCategoryModel category =
                        recipeController.categoryList[index];
                    return GestureDetector(
                      onTap: () {
                        recipeController
                            .getSingleCategory(category.strCategory);
                        Get.to(() => SingleCategoryInfoScreen(
                            categoryName: category.strCategory));
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        child: ListTile(
                          title: Text(category.strCategory),
                          subtitle: Text(category.strCategoryDescription),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
            return const SizedBox.shrink();
          })
        ],
      ),
    );
  }
}
