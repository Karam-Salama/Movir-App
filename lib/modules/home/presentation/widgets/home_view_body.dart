import 'package:flutter/material.dart';
import 'package:movir_app/core/utils/app_strings.dart';
import 'package:movir_app/core/utils/app_text_styles.dart';
import 'home_categories_list.dart';
import 'home_movies_section.dart';
import 'home_now_playing_list_view_blok_builder.dart';
import 'home_popular_list_view_bloc_builder.dart';
import 'home_top_bar_widget.dart';
import 'home_top_rated_list_view_bloc_builder.dart';
import 'home_trending_list_view_bloc_builder.dart';
import 'home_upcoming_list_view_bloc_builder.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.fromLTRB(20, 16, 20, 80),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HomeTopBar(),
              const SizedBox(height: 20),
              Text(
                AppStrings.breakSubtitle,
                style: AppTextStyle.Kanit500style32White.copyWith(fontSize: 16),
              ),
              const SizedBox(height: 20),
              const HomeCategoriesList(),
              const SizedBox(height: 12),
              HomeMoviesSection(),
              const SizedBox(height: 24),
              Text(
                AppStrings.topRatedSubtitle,
                style: AppTextStyle.Kanit500style32White.copyWith(fontSize: 16),
              ),
              const SizedBox(height: 20),
              const HomeTopRatedListViewBlocBuilder(),
              const SizedBox(height: 24),
              Text(
                AppStrings.popularSubtitle,
                style: AppTextStyle.Kanit500style32White.copyWith(fontSize: 16),
              ),
              const SizedBox(height: 20),
              const HomePopularListViewBlocBuilder(),
              const SizedBox(height: 24),
              Text(
                AppStrings.upcomingSubtitle,
                style: AppTextStyle.Kanit500style32White.copyWith(fontSize: 16),
              ),
              const SizedBox(height: 20),
              const HomeUpcomingListViewBlocBuilder(),
              const SizedBox(height: 24),
              Text(
                AppStrings.nowPlayingSubtitle,
                style: AppTextStyle.Kanit500style32White.copyWith(fontSize: 16),
              ),
              const SizedBox(height: 20),
              const HomeNowPlayingListViewBlocBuilder(),
              const SizedBox(height: 24),
              Text(
                AppStrings.trendingSubtitle,
                style: AppTextStyle.Kanit500style32White.copyWith(fontSize: 16),
              ),
              const SizedBox(height: 20),
              const HomeTrendingListViewBlocBuilder(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
