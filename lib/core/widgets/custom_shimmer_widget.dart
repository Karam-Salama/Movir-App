import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmerWidget extends StatelessWidget {
  const CustomShimmerWidget({
    super.key,
    required this.height,
    required this.width,
    required this.borderRadius,
    this.child,
  });

  final double height;
  final double width;
  final double borderRadius;
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade800,
      highlightColor: Colors.grey.shade600,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: Colors.grey[300],
        ),
        child: child,
      ),
    );
  }
}
