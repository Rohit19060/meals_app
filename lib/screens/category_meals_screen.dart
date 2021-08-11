import 'package:flutter/material.dart';
import 'package:meals_app/dummy_data.dart';
import 'package:meals_app/widgets/meal_item.dart';

class CategoryMealsScreen extends StatelessWidget {
  static const routeName = '/category-meals';
  // final String categoryId;
  // final String categoryTitle;

  // CategoryMealsScreen(this.categoryId, this.categoryTitle);

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    final categoryTitle = routeArgs['title'] ?? "";
    final categoryId = routeArgs['id'];
    final categroyMeals =
        DUMMY_MEALS.where((e) => e.categories.contains(categoryId)).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
              title: categroyMeals[index].title,
              imageUrl: categroyMeals[index].imageUrl,
              duration: categroyMeals[index].duration,
              complexity: categroyMeals[index].complexity,
              affordability: categroyMeals[index].affordability);
        },
        itemCount: categroyMeals.length,
      ),
    );
  }
}
