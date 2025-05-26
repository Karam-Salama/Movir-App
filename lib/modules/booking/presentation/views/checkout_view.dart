import 'package:flutter/material.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../home/data/models/movie_details_model .dart';
import '../widgets/checkout_view_body.dart';

class CheckoutView extends StatelessWidget {
  const CheckoutView({super.key, required this.movieDetailsModel});

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
          child: CheckoutViewBody(movieDetailsModel: movieDetailsModel)),
    );
  }
}
