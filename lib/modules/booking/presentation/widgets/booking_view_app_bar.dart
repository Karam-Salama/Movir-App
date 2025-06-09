// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../../../core/utils/app_text_styles.dart';

class CustomAppBar extends StatelessWidget {
  CustomAppBar({super.key, required this.text, this.onTap, this.isBack});
  final String text;
  void Function()? onTap;
  bool? isBack = true;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Stack(
        alignment: Alignment.center,
        children: [
          isBack ?? true
              ? const SizedBox()
              : Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    onTap: onTap ?? () => Navigator.pop(context),
                    child: Container(
                      width: 40,
                      height: 40,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
          Center(
            child: Text(
              text,
              style: AppTextStyle.Kanit500style32White.copyWith(
                fontSize: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
