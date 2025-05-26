import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerMoviesListView extends StatelessWidget {
  const ShimmerMoviesListView({super.key});

  @override
  Widget build(BuildContext context) {
    var itemHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      height: itemHeight * 0.35,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return const Padding(
            padding: EdgeInsets.only(right: 12),
            child: ShimmerMovieItem(),
          );
        },
      ),
    );
  }
}

class ShimmerMovieItem extends StatelessWidget {
  const ShimmerMovieItem({super.key});

  @override
  Widget build(BuildContext context) {
    var itemWidth = MediaQuery.of(context).size.width;
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade800,
      highlightColor: Colors.grey.shade600,
      child: Stack(
        children: [
          // Main movie backdrop
          Container(
            width: itemWidth * 0.85,
            height: itemWidth * 0.6,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(20),
            ),
          ),

          // Details card
          Positioned.fill(
            top: 150,
            child: Container(
              width: itemWidth * 0.65,
              height: itemWidth * 0.2,
              margin: const EdgeInsets.symmetric(horizontal: 12),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title placeholder
                  Container(
                    height: 16,
                    width: 120,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Genre placeholder
                  Container(
                    height: 12,
                    width: 180,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Rating row
                  Row(
                    children: [
                      Container(
                        height: 16,
                        width: 16,
                        color: Colors.grey[300],
                      ),
                      const SizedBox(width: 4),
                      // Rating placeholder
                      Container(
                        height: 12,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      const SizedBox(width: 4),
                      // Votes placeholder
                      Container(
                        height: 12,
                        width: 30,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
