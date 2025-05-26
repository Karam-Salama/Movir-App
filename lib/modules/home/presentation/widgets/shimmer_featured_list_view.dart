import 'package:flutter/material.dart';

import '../../../../core/widgets/custom_shimmer_widget.dart';

class ShimmerFeaturedListView extends StatelessWidget {
  const ShimmerFeaturedListView({super.key});

  @override
  Widget build(BuildContext context) {
    var itemHeight = MediaQuery.of(context).size.height;
    var itemWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      height: itemHeight * 0.35,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: CustomShimmerWidget(
              height: 200,
              width: itemWidth * 0.5,
              borderRadius: 20,
            ),
          );
        },
      ),
    );
  }
}
