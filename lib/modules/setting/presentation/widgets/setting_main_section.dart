// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../tickets/presentation/views/tickets_view.dart';
import '../../../wishlist/presentation/view/wishlist_view.dart';
import '../views/profile_view.dart';
import 'custom_row_setting_item.dart';
import 'logout_bloc_consumer.dart';

class SettingMainSection extends StatelessWidget {
  const SettingMainSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomRowSettingItem(
          onTap: () {
            PersistentNavBarNavigator.pushNewScreen(
              context,
              screen: const ProfileView(),
              withNavBar: false,
              pageTransitionAnimation: PageTransitionAnimation.cupertino,
            );
          },
          icon: Icons.person,
          data: AppStrings.profile,
        ),
        const SizedBox(height: 12),
        CustomRowSettingItem(
          onTap: () {
            PersistentNavBarNavigator.pushNewScreen(
              context,
              screen: const WishlistView(),
              withNavBar: false,
              pageTransitionAnimation: PageTransitionAnimation.cupertino,
            );
          },
          icon: Icons.favorite,
          data: AppStrings.wishlist,
        ),
        const SizedBox(height: 12),
        CustomRowSettingItem(
          onTap: () {
            PersistentNavBarNavigator.pushNewScreen(
              context,
              screen: const TicketsView(),
              withNavBar: false,
              pageTransitionAnimation: PageTransitionAnimation.cupertino,
            );
          },
          leading: SvgPicture.asset(
            Assets.assetsIconsTicketIcon,
            width: 24,
            height: 24,
            color: AppColors.primaryColor,
          ),
          data: AppStrings.tickets,
        ),
        const SizedBox(height: 50),
        LogoutBlocConsumer(),
      ],
    );
  }
}
