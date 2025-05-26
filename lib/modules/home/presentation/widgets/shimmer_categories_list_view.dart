import 'package:flutter/material.dart';

import 'shimmer_categories_item.dart';

class ShimmerCategoriesListView extends StatelessWidget {
  const ShimmerCategoriesListView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      width: double.infinity,
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        separatorBuilder: (context, index) {
          return const SizedBox(width: 12);
        },
        itemBuilder: (context, index) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: ShimmerCategoriesItem(),
          );
        },
      ),
    );
  }
}
