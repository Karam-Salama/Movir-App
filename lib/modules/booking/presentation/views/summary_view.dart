import 'package:flutter/material.dart';

import '../../../../core/utils/app_assets.dart';
import '../../../home/data/models/movie_details_model .dart';
import '../widgets/summary_view_body.dart';

class SummaryView extends StatelessWidget {
  const SummaryView({super.key, required this.movieDetailsModel});
  final MovieDetailsModel movieDetailsModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Assets.assetsImagesHomeBg),
              fit: BoxFit.cover,
            ),
          ),
          child: SummaryViewBody(movieDetailsModel: movieDetailsModel)),
    );
  }
}
