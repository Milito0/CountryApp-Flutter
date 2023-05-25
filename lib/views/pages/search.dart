import 'package:country_app/services/api/bloc/api_bloc.dart';
import 'package:country_app/services/api/bloc/api_event.dart';
import 'package:country_app/services/api/bloc/api_state.dart';
import 'package:country_app/services/api/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final Repository repository = Repository();
  @override
  void initState() {
    super.initState();
    repository.getCountries();
  }

  @override
  Widget build(BuildContext context) {
    context.read<ApiBloc>().add(const ApiEventGetAllCountries());
    return BlocConsumer<ApiBloc, ApiState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: getWidget(state),
        );
      },
    );
  }

  Widget getWidget(ApiState state) {
    if (state is ApiStateGetAllCountries) {
      return Center(
        child: Text(state.countries[1].name!.common!),
      );
    } else {
      return const Scaffold(
        body: CircularProgressIndicator(),
      );
    }
  }
}
