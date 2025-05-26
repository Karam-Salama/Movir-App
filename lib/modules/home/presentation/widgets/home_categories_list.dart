import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_states.dart';
import 'home_categories_tabs.dart';
import 'shimmer_categories_list_view.dart';

class HomeCategoriesList extends StatelessWidget {
  const HomeCategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();

    return BlocBuilder<HomeCubit, HomeStates>(
      buildWhen: (previous, current) =>
          current is CategoriesLoadingState ||
          current is CategoriesSuccessState ||
          current is CategoriesFailureState,
      builder: (context, state) {
        if (state is CategoriesLoadingState) {
          return const ShimmerCategoriesListView();
        }

        if (state is CategoriesFailureState) {
          return SizedBox(
            height: 30,
            child: Center(
              child: Text(
                state.errorMessage,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
        }

        if (state is CategoriesSuccessState) {
          return BlocBuilder<HomeCubit, HomeStates>(
            buildWhen: (previous, current) => current is MoviesListSuccessState,
            builder: (context, _) {
              return CategoriesTabs(
                categories: state.categories,
                selectedCategoryId: cubit.selectedCategoryId,
                onCategorySelected: (categoryId) {
                  cubit.getMoviesListByCategoryId(categoryId: categoryId);
                },
              );
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
