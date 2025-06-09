import 'package:flutter/material.dart';

import '../../modules/setting/presentation/cubit/sign_out_cubit.dart';
import '../utils/app_text_styles.dart';
import '../widgets/custom_btn.dart';

void buildLogoutDialog(BuildContext context, SignOutCubit signOutCubit) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: Text(
          "Logout",
          style: AppTextStyle.Kanit700style16Black,
        ),
        content: Text(
          "Are you sure you want to logout?",
          style: AppTextStyle.Kanit700style16Black,
        ),
        actions: [
          Row(
            children: [
              Expanded(
                  child: CustomButton(
                text: "Cancel",
                onPressed: () => Navigator.pop(context),
                style: AppTextStyle.Kanit700style16Black,
                mainAxisAlignment: MainAxisAlignment.center,
              )),
              SizedBox(
                width: 16,
              ),
              Expanded(
                child: CustomButton(
                  text: "ok",
                  onPressed: () {
                    signOutCubit.signOut();
                    Navigator.pop(context);
                  },
                  style: AppTextStyle.Kanit700style16Black,
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              )
            ],
          )
        ],
      );
    },
  );
}
