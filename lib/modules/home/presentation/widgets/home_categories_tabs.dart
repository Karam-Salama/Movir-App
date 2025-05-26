import 'package:flutter/material.dart';
import 'package:movir_app/modules/home/data/models/category_model.dart';
import 'home_category_item.dart';

class CategoriesTabs extends StatelessWidget {
  final List<CategoryModel> categories;
  final String selectedCategoryId;
  final Function(String) onCategorySelected;

  const CategoriesTabs({
    super.key,
    required this.categories,
    required this.selectedCategoryId,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = category.id.toString() == selectedCategoryId;

          return GestureDetector(
            onTap: () => onCategorySelected(category.id.toString()),
            child: Padding(
              padding: const EdgeInsets.only(right: 12),
              child: HomeCategoryItem(
                categoryModel: category,
                isSelected: isSelected,
              ),
            ),
          );
        },
      ),
    );
  }
}
