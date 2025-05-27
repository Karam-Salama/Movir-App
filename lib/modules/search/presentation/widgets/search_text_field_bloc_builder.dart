import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../cubit/search_cubit.dart';
import '../cubit/search_states.dart';

class SearchTextFieldBlocBuilder extends StatelessWidget {
  const SearchTextFieldBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    SearchCubit searchCubit = BlocProvider.of<SearchCubit>(context);
    return BlocConsumer<SearchCubit, SearchStates>(
      listener: (context, state) {
        if (state is SearchFailureState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage)),
          );
        } else if (state is SearchSuccessState) {}
      },
      builder: (context, state) {
        return CustomTextFormField(
          controller: searchCubit.searchController,
          hintText: AppStrings.search,
          keyboardType: TextInputType.text,
          prefixIcon: const Icon(Icons.search, color: Colors.white),
          suffixIcon: IconButton(
            icon: const Icon(Icons.clear, color: Colors.white),
            onPressed: () {
              searchCubit.clearSearch();
            },
          ),
          onChanged: (value) {
            searchCubit.searchMovies(movieQuery: value);
          },
        );
      },
    );
  }
}
