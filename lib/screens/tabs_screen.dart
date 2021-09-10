import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/main_drawer.dart';
import 'favorites_screen.dart';
import 'categories_screen.dart';

class TabScreen extends StatefulWidget {
  final List<Meal> favoritesMeals;
  const TabScreen({required this.favoritesMeals, Key? key}) : super(key: key);

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  List<Map<String, Object>> _pages = [];

  int _selectedPageIndex = 0;

  void _selectedPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();

    _pages = [
      {"page": const CategoriesScreen(), "title": "Categories"},
      {
        "page": FavoritesScreen(favoriteMeals: widget.favoritesMeals),
        "title": "Your Favorite"
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]["title"] as String),
      ),
      drawer: const MainDrawer(),
      body: _pages[_selectedPageIndex]["page"] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        onTap: _selectedPage,
        unselectedItemColor: Colors.white,
        currentIndex: _selectedPageIndex,
        unselectedIconTheme: const IconThemeData(color: Colors.white),
        unselectedLabelStyle: const TextStyle(color: Colors.white),
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: const Icon(Icons.category),
            label: "Categories",
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: const Icon(Icons.star),
            label: "Favorites",
          ),
        ],
      ),
    );
  }
}
