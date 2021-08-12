import 'package:flutter/material.dart';
import './main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const String routeName = "/filters";

  final Function saveFilters;
  final Map<String, bool> currentFilter;

  const FiltersScreen(
      {Key? key, required this.saveFilters, required this.currentFilter})
      : super(key: key);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactosFree = false;

  @override
  initState() {
    super.initState();
    _glutenFree = widget.currentFilter["gluten"]!;
    _vegetarian = widget.currentFilter["lactose"]!;
    _vegan = widget.currentFilter["vegan"]!;
    _lactosFree = widget.currentFilter["vegetarian"]!;
  }

  Widget _buildSwtich(
      {required String title,
      required String description,
      required bool currentValue,
      required Function updateValue}) {
    return SwitchListTile(
      value: currentValue,
      subtitle: Text(description),
      onChanged: (value) {
        print(value);
        updateValue(value);
      },
      title: Text(title),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Filters'),
        actions: [
          IconButton(
              onPressed: () {
                widget.saveFilters({
                  "gluten": _glutenFree,
                  "lactose": _lactosFree,
                  "vegan": _vegan,
                  "vegetarian": _vegetarian
                });
              },
              icon: Icon(Icons.save))
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              "Adjust your meal selection",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              _buildSwtich(
                  title: "Gluten Free",
                  description: "Only Include Gluten free meals",
                  currentValue: _glutenFree,
                  updateValue: (newvalue) {
                    setState(() {
                      print(newvalue);
                      _glutenFree = newvalue;
                    });
                  }),
              _buildSwtich(
                  title: "Lactos Free",
                  description: "Only Include Lactos free meals",
                  currentValue: _lactosFree,
                  updateValue: (newvalue) {
                    setState(() {
                      _lactosFree = newvalue;
                    });
                  }),
              _buildSwtich(
                  title: "Vegeterian",
                  description: "Only Include Vegeterian meals",
                  currentValue: _vegetarian,
                  updateValue: (newvalue) {
                    setState(() {
                      _vegetarian = newvalue;
                    });
                  }),
              _buildSwtich(
                  title: "Vegan",
                  description: "Only Include Vegan meals",
                  currentValue: _vegan,
                  updateValue: (newvalue) {
                    setState(() {
                      _vegan = newvalue;
                    });
                  }),
            ],
          ))
        ],
      ),
    );
  }
}
