import 'package:flutter/material.dart';

import '../../../../core/widgets/custom_shimmer_widget.dart';

class ShimmerCategoriesItem extends StatelessWidget {
  const ShimmerCategoriesItem({super.key});
  @override
  Widget build(BuildContext context) {
    return CustomShimmerWidget(
      height: 30,
      width: 120,
      borderRadius: 4,
    );
  }
}
