import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/home_cubit.dart';
import '../cubit/home_states.dart';
import 'movie_crew_list_view.dart';

class MovieCrewBlocBuilder extends StatelessWidget {
  const MovieCrewBlocBuilder({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeStates>(
      buildWhen: (previous, current) =>
          current is MovieCrewLoadingState ||
          current is MovieCrewSuccessState ||
          current is MovieCrewFailureState,
      builder: (context, state) {
        if (state is MovieCrewLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is MovieCrewFailureState) {
          return SizedBox(
            height: 200,
            child: Center(child: Text(state.errorMessage)),
          );
        }

        if (state is MovieCrewSuccessState) {
          return MoviewCrewListView(crewList: state.crew);
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
