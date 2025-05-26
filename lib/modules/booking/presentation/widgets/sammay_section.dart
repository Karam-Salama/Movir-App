import 'package:flutter/material.dart';

import '../../../../core/utils/app_assets.dart';
import '../../../home/data/models/movie_details_model .dart';
import 'sammary_header_widget.dart';
import 'sammary_middle_widget.dart';

class SammaySection extends StatelessWidget {
  const SammaySection({super.key, required this.movieDetailsModel});
  final MovieDetailsModel movieDetailsModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 380,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Assets.assetsImagesReviewCard),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SammaryHeaderWidget(movieDetailsModel: movieDetailsModel),
          const SizedBox(height: 20),
          SammaryMiddleWidget(),
        ],
      ),
    );
  }
}
