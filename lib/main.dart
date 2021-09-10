import 'package:flutter/material.dart';

import './dummy_data.dart';
import './models/meal.dart';
import './screens/categories_screen.dart';
import './screens/category_meals_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/tabs_screen.dart';
import './widgets/filters_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    "gluten": false,
    "lactose": false,
    "vegan": false,
    "vegetarian": false
  };

  List<Meal> _availableMeals = dummyMeals;
  final List<Meal> _favoritesMeals = [];

  void _setFilters(Map<String, bool> filters) {
    setState(() {
      _filters = filters;

      _availableMeals = dummyMeals.where((e) {
        if (_filters["gluten"]! && !e.isGlutenFree) {
          return false;
        }
        if (_filters["lactose"]! && !e.isLactoseFree) {
          return false;
        }
        if (_filters["vegan"]! && !e.isVegan) {
          return false;
        }
        if (_filters["vegetarian"]! && !e.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    final existingIndex =
        _favoritesMeals.indexWhere((meal) => mealId == meal.id);
    setState(() {
      if (existingIndex >= 0) {
        _favoritesMeals.removeAt(existingIndex);
      } else {
        _favoritesMeals
            .add(dummyMeals.firstWhere((element) => mealId == element.id));
      }
    });
  }

  bool _isMealFavorite(String mealId) {
    return _favoritesMeals.any((element) => mealId == element.id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "DeliMeals",
      theme: ThemeData(
        primarySwatch: Colors.pink,
        canvasColor: const Color.fromRGBO(255, 254, 227, 1),
        fontFamily: "Raleway",
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: const TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyText2: const TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              headline1: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      initialRoute: '/',
      routes: {
        '/': (ctx) => TabScreen(
              favoritesMeals: _favoritesMeals,
            ),
        CategoryMealsScreen.routeName: (ctx) =>
            CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(
              isFavorite: _isMealFavorite,
              toggleFavorite: _toggleFavorite,
            ),
        FiltersScreen.routeName: (ctx) => FiltersScreen(
              saveFilters: _setFilters,
              currentFilter: _filters,
            ),
      },
      // onGenerateRoute: (settings) {
      //   print(settings.arguments);
      //   return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      // },
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (ctx) => const CategoriesScreen(),
      ),
    );
  }
}
