import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/utils/app_assets.dart';

class NoResultsFoundView extends StatelessWidget {
  const NoResultsFoundView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.5,
        child: SvgPicture.asset(
          Assets.assetsSvgsNoResultFoundIcon,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
