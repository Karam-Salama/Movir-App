import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import '../../../../core/utils/app_strings.dart';
import '../../../booking/presentation/widgets/booking_view_app_bar.dart';
import '../../../home/presentation/views/home_view.dart';

class TicketsViewBody extends StatelessWidget {
  const TicketsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.fromLTRB(20, 16, 20, 40),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(
                text: AppStrings.tickets,
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
