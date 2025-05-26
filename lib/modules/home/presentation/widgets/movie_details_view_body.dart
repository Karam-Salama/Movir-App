import 'package:flutter/material.dart';
import '../../data/models/movie_details_model .dart';
import 'movie_details_header_section.dart';
import 'movie_details_middle_section.dart';

class MovieDetailsViewBody extends StatelessWidget {
  const MovieDetailsViewBody({super.key, required this.movieDetailsModel});
  final MovieDetailsModel movieDetailsModel;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MovieDetailsHeaderSection(movieDetailsModel: movieDetailsModel),
          MovieDetailsMiddleSection(movieDetailsModel: movieDetailsModel),
        ],
      ),
    );
  }
}
