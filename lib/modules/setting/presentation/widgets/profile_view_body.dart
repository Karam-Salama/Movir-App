import 'package:flutter/material.dart';

import '../../../../core/utils/app_strings.dart';
import '../../../booking/presentation/widgets/booking_view_app_bar.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

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
                text: AppStrings.profile,
                isBack: true,
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
