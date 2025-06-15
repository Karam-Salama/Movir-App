import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_assets.dart';
import '../cubit/favorite_cubit.dart';
import '../widget/wishlist_view_body.dart';

class WishlistView extends StatelessWidget {
  const WishlistView({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<FavoriteCubit>().loadFavoriteMovies();

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
        child: WishlistViewBody(),
      ),
    );
  }
}
