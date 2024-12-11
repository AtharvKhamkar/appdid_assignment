import 'package:appdid_assignment/constants/app_utils.dart';
import 'package:appdid_assignment/controllers/recipe_controller.dart';
import 'package:appdid_assignment/models/single_meal_details_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class SingleMealInfoScreen extends StatefulWidget {
  final String mealId;
  final String mealTitle;
  const SingleMealInfoScreen(
      {super.key, required this.mealId, required this.mealTitle});

  @override
  State<SingleMealInfoScreen> createState() => _SingleMealInfoScreenState();
}

class _SingleMealInfoScreenState extends State<SingleMealInfoScreen> {
  RecipeController recipeController = RecipeController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    recipeController.getSingleMealInfo(widget.mealId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.mealTitle),
      ),
      body: SafeArea(
          child: Column(
        children: [
          // ElevatedButton(
          //     onPressed: () {
          //       recipeController.getSingleMealInfo('52959');
          //     },
          //     child: const Text('Fetch single meal info'))

          Obx(() {
            if (recipeController.isLoading.value == true) {
              return const Center(
                child: CircularProgressIndicator.adaptive(
                  backgroundColor: Colors.black,
                ),
              );
            }

            if (recipeController.isLoading.value != true &&
                recipeController.mealDetailsList.isEmpty) {
              return const Center(
                child: Text('No Meal details found'),
              );
            }

            if (recipeController.isLoading.value != true &&
                recipeController.mealDetailsList.isNotEmpty) {
              return Expanded(
                  child: ListView.builder(
                      itemCount: recipeController.mealDetailsList.length,
                      itemBuilder: (context, index) {
                        SingleMealDetailsModel mealDetail =
                            recipeController.mealDetailsList[index];
                        return SingleMealDetailsContainer(
                            mealDetail: mealDetail);
                      }));
            }

            return SizedBox.shrink();
          })
        ],
      )),
    );
  }
}

class SingleMealDetailsContainer extends StatelessWidget {
  const SingleMealDetailsContainer({
    super.key,
    required this.mealDetail,
  });

  final SingleMealDetailsModel mealDetail;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                'Category : ${mealDetail.strCategory ?? 'No category available'}'),
            Text('Category : ${mealDetail.strArea ?? 'No area available'}'),
            const Text(
              'Instructions :',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(mealDetail.strInstructions ?? 'No Instructions'),
            Image.network(mealDetail.strMealThumb ?? "No thumbnail found"),
            TextButton(
                onPressed: () {
                  AppUtils().launchURL(mealDetail.strSource ?? 'Invalid Url',
                      mode: LaunchMode.inAppWebView);
                },
                child: const Text('Click here for more info'))
          ],
        ),
      ),
    );
  }
}
