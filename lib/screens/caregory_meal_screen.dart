import 'package:flutter/material.dart';
import 'package:meal_app/models/dummy_data.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/widgets/meal_item.dart';

class CategoryMealScreen extends StatefulWidget {
  static const String routeName = '/category-meal';
  final List<Meal> availableMeal;

  CategoryMealScreen(this.availableMeal);

  @override
  State<CategoryMealScreen> createState() => _CategoryMealScreenState();
}

class _CategoryMealScreenState extends State<CategoryMealScreen> {
  String categoryTitle = '';
  List<Meal> displayedMeal = [];
  var _loadedInitialData = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_loadedInitialData) {
      final routArgs =
          ModalRoute.of(context)?.settings.arguments as Map<String, String>;

      categoryTitle = routArgs['title'] as String;
      final id = routArgs['id'];

      displayedMeal = widget.availableMeal
          .where(
            (category) => category.categories.contains(id),
          )
          .toList();
    }
    super.didChangeDependencies();
  }

  void _removedMeal(String mealId) {
    displayedMeal.removeWhere((meal) => meal.id == mealId);
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: Center(
        child: ListView.builder(
          itemBuilder: (ctx, index) {
            return MealItem(
              id: displayedMeal[index].id,
              affordability: displayedMeal[index].affordability,
              imageUrl: displayedMeal[index].imageUrl,
              complexity: displayedMeal[index].complexity,
              duration: displayedMeal[index].duration,
              title: displayedMeal[index].title,
              // removeMeal: _removedMeal,
            );
          },
          itemCount: displayedMeal.length,
        ),
      ),
    );
  }
}
