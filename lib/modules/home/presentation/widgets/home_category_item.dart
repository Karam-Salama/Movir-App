// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../data/models/category_model.dart';

class HomeCategoryItem extends StatelessWidget {
  const HomeCategoryItem({
    super.key,
    required this.categoryModel,
    required this.isSelected,
  });

  final CategoryModel categoryModel;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsetsDirectional.only(end: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: isSelected ? AppColors.primaryColor : const Color(0xff3A3A3A),
          width: 1.5,
        ),
        color: isSelected ? const Color(0xff1F1F1F) : AppColors.transparent,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Center(
          child: Text(
            categoryModel.name,
            style: AppTextStyle.Kanit400style16White.copyWith(
              fontSize: 14,
              color: isSelected ? AppColors.primaryColor : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
