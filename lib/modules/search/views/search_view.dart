import 'package:flutter/material.dart';

import '../../../core/utils/app_assets.dart';
import '../widgets/search_view_body.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});
  static const routeName = '/search-view';
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
        child: SearchViewBody(),
      ),
    );
  }
}
