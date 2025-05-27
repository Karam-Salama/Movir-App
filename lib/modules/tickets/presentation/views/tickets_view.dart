import 'package:flutter/material.dart';

import '../../../../../core/utils/app_assets.dart';
import '../widgets/tickets_view_body.dart';

class TicketsView extends StatelessWidget {
  const TicketsView({super.key});
  static const routeName = '/Tickets-view';
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
        child: TicketsViewBody(),
      ),
    );
  }
}
