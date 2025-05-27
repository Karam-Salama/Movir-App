import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movir_app/modules/home/presentation/views/home_view.dart';
import 'package:movir_app/modules/search/presentation/views/search_view.dart';
import 'package:movir_app/modules/tickets/presentation/views/tickets_view.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import '../core/utils/app_assets.dart';
import '../core/utils/app_colors.dart';
import 'setting/presentation/views/setting_view.dart';

PersistentTabController _controller = PersistentTabController();

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});
  static const String routeName = '/bottom_Nav_Bar';

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      margin: EdgeInsets.all(8),
      context,
      screens: _buildScreens(),
      items: _navBarsItems(),
      controller: _controller,
      navBarStyle: NavBarStyle.style12,
      backgroundColor: AppColors.darkColor,
      decoration: const NavBarDecoration(
        colorBehindNavBar: AppColors.transparent,
        borderRadius: BorderRadius.all(
          Radius.circular(100.0),
        ),
      ),
    );
  }

  List<Widget> _buildScreens() {
    return [
      const HomeView(),
      const TicketsView(),
      const SearchView(),
      const SettingView(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(Assets.assetsSvgsHomeActiveIcon),
        inactiveIcon: SvgPicture.asset(Assets.assetsIconsHomeIcon),
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(Assets.assetsSvgsTicketActiveIcon),
        inactiveIcon: SvgPicture.asset(Assets.assetsIconsTicketIcon),
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(Assets.assetsSvgsSearchActiveIcon),
        inactiveIcon: SvgPicture.asset(Assets.assetsIconsSearchIcon),
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(Assets.assetsSvgsSettingsActiveIcon),
        inactiveIcon: SvgPicture.asset(Assets.assetsIconsSettingsIcon),
      ),
    ];
  }
}
