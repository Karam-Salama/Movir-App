import 'package:flutter/material.dart';

import '../../../../core/utils/app_strings.dart';
import '../../../booking/presentation/widgets/booking_view_app_bar.dart';
import 'filtered_moviesl_list_view_bloc_builder.dart';
import 'search_text_field_bloc_builder.dart';

class SearchViewBody extends StatelessWidget {
  SearchViewBody({super.key});

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
              CustomAppBar(
                text: AppStrings.discover,
                onTap: () {},
              ),
              const SizedBox(height: 20),
              const SearchTextFieldBlocBuilder(),
              const SizedBox(height: 20),
              FilteredMoviesListviewBlocBuilder(),
            ],
          ),
        ),
      ),
    );
  }
}
