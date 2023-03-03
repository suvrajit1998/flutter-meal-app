import 'package:flutter/material.dart';
import 'package:meal_app/widgets/main_drawer.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = '/filters';
  final Function(Map<String, bool>) saveFilters;
  final Map<String, bool> currentFilters;
  FilterScreen(this.currentFilters, this.saveFilters);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  var _glutenFree = false;
  var _vegetarian = false;
  var _vegan = false;
  var _lactoseFree = false;

  @override
  void initState() {
    _glutenFree = widget.currentFilters['gluten']!;
    _lactoseFree = widget.currentFilters['lactose']!;
    _vegan = widget.currentFilters['vegan']!;
    _vegetarian = widget.currentFilters['vegetarian']!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yours Filters'),
        actions: [
          IconButton(
            onPressed: () {
              final selectedfilter = {
                'gluten': _glutenFree,
                'lactose': _lactoseFree,
                "vegan": _vegan,
                "vegetarian": _vegetarian
              };
              widget.saveFilters(selectedfilter);
            },
            icon: Icon(Icons.save),
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection.',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildSwitchListTile(
                  'Gluten-free',
                  'Only includes gluten-free meal.',
                  _glutenFree,
                  (value) {
                    _glutenFree = value;
                    if (mounted) setState(() {});
                  },
                ),
                _buildSwitchListTile(
                  'Lactose-free',
                  'Only includes lactose-free meal.',
                  _lactoseFree,
                  (value) {
                    _lactoseFree = value;
                    if (mounted) setState(() {});
                  },
                ),
                _buildSwitchListTile(
                  'Vegetarian',
                  'Only includes vegetarian meal.',
                  _vegetarian,
                  (value) {
                    _vegetarian = value;
                    if (mounted) setState(() {});
                  },
                ),
                _buildSwitchListTile(
                  'Vegan',
                  'Only includes vegan meal.',
                  _vegan,
                  (value) {
                    _vegan = value;
                    if (mounted) setState(() {});
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchListTile(
    String title,
    String description,
    bool currentValue,
    Function(bool) update,
  ) {
    return SwitchListTile(
      value: currentValue,
      onChanged: update,
      title: Text(title),
      subtitle: Text(description),
    );
  }
}
