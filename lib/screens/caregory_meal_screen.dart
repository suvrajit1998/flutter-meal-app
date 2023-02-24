import 'package:flutter/material.dart';
import 'package:meal_app/models/dummy_data.dart';
import 'package:meal_app/widgets/meal_item.dart';

class CategoryMealScreen extends StatefulWidget {
  static const String routeName = '/category-meal';

  @override
  State<CategoryMealScreen> createState() => _CategoryMealScreenState();
}

class _CategoryMealScreenState extends State<CategoryMealScreen> {
  @override
  Widget build(BuildContext context) {
    final routArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;

    final title = routArgs['title'];
    final id = routArgs['id'];

    final categoryMeal = DUMMY_MEALS
        .where(
          (category) => category.categories.contains(id),
        )
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(title as String),
      ),
      body: Center(
        child: ListView.builder(
          itemBuilder: (ctx, index) {
            return MealItem(
              id: categoryMeal[index].id,
              affordability: categoryMeal[index].affordability,
              imageUrl: categoryMeal[index].imageUrl,
              complexity: categoryMeal[index].complexity,
              duration: categoryMeal[index].duration,
              title: categoryMeal[index].title,
            );
          },
          itemCount: categoryMeal.length,
        ),
      ),
    );
  }
}
