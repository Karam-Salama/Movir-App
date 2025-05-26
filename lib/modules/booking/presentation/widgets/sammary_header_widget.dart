import 'package:flutter/material.dart';

import '../../../../core/functions/formate_runtime.dart';
import '../../../../core/utils/api_const.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../home/data/models/movie_details_model .dart';

class SammaryHeaderWidget extends StatelessWidget {
  const SammaryHeaderWidget({super.key, required this.movieDetailsModel});
  final MovieDetailsModel movieDetailsModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 80,
          height: 110,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                APIImageUrls.baseImageUrl + movieDetailsModel.backdropPath!,
              ),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                movieDetailsModel.title!,
                style: AppTextStyle.Kanit400style16White,
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 40,
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: movieDetailsModel.genres!.length,
                  separatorBuilder: (context, index) => const Text(", "),
                  itemBuilder: (context, index) {
                    return Text(
                      movieDetailsModel.genres![index].name,
                      style: AppTextStyle.Kanit400style16White.copyWith(
                        fontSize: 14,
                      ),
                    );
                  },
                ),
              ),
              Text(
                formattedRuntime(movieDetailsModel.runtime!),
                style: AppTextStyle.Kanit400style16White.copyWith(
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
