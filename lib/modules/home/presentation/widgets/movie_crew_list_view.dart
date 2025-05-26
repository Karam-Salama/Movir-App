import 'package:flutter/material.dart';

import '../../../../core/utils/api_const.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../data/models/crew_model.dart';

class MoviewCrewListView extends StatelessWidget {
  const MoviewCrewListView({super.key, required this.crewList});
  final List<CrewModel> crewList;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: crewList.length,
        separatorBuilder: (context, index) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(
                  '${APIImageUrls.baseImageUrl}${crewList[index].profilePath}',
                ),
              ),
              const SizedBox(height: 8),
              Text(
                crewList[index].name!,
                style: AppTextStyle.Kanit500style32White.copyWith(
                  fontSize: 14,
                  color: AppColors.lighterGrey,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                crewList[index].character!,
                style: AppTextStyle.Kanit400style16White.copyWith(
                  fontSize: 12,
                  color: AppColors.lightGrey2,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
