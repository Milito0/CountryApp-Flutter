import 'package:country_app/constants/colors.dart';
import 'package:country_app/services/api/bloc/api_bloc.dart';
import 'package:country_app/services/api/bloc/api_event.dart';
import 'package:country_app/services/api/bloc/api_state.dart';
import 'package:country_app/widgets/home_country_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    context.read<ApiBloc>().add(const ApiEventGetRandomCountries());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ApiBloc, ApiState>(
      listener: (context, state) {},
      builder: (context, state) {
        return SafeArea(
            child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20, bottom: 10),
              child: const Text(
                "Paises destacado de cada continente",
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ),
            // Container Asia
            Expanded(child: getWidget(state))
          ],
        ));
      },
    );
  }

  Widget getWidget(ApiState state) {
    if (state is ApiStateGetRandomCountries) {
      return HomeCountryList(countries: state.countries);
    } else {
      context.read<ApiBloc>().add(const ApiEventGetRandomCountries());
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
