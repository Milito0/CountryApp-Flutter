import 'package:country_app/constants/colors.dart';
import 'package:country_app/services/api/bloc/api_bloc.dart';
import 'package:country_app/services/api/bloc/api_event.dart';
import 'package:country_app/services/api/bloc/api_state.dart';
import 'package:country_app/services/api/repository.dart';
import 'package:country_app/views/detail.dart';
import 'package:country_app/widgets/country_list.dart';
import 'package:country_app/widgets/filter_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final Repository repository = Repository();
  late final TextEditingController _sbController;
  List<String> _selectedItems = [];
  late final Widget myList;

  @override
  void initState() {
    _sbController = TextEditingController();
    super.initState();
    repository.getAllCountries();
  }

  @override
  void dispose() {
    _sbController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.read<ApiBloc>().add(const ApiEventGetAllCountries());
    return BlocConsumer<ApiBloc, ApiState>(
      listener: (context, state) {},
      builder: (context, state) {
        return SafeArea(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                child: TextField(
                  onChanged: (value) {
                    context.read<ApiBloc>().add(searchCountries(value));
                  },
                  controller: _sbController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: 'Search..',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: secondaryAppColor),
                    ),
                    suffixIcon: IconButton(
                      iconSize: 20,
                      onPressed: () {
                        _showMultiSelect();
                      },
                      icon: const Icon(Icons.tune),
                    ),
                  ),
                ),
              ),
              Wrap(
                spacing: 10,
                children: _selectedItems
                    .map(
                      (e) => Chip(
                        label: Text(e),
                        backgroundColor: secondaryAppColor,
                        deleteIcon: const Icon(Icons.cancel),
                        onDeleted: () {
                          setState(() {
                            _selectedItems.remove(e);
                          });
                        },
                      ),
                    )
                    .toList(),
              ),
              Expanded(
                child: getWidget(state),
              )
            ],
          ),
        );
      },
    );
  }

  ApiEvent searchCountries(String value) {
    if (_selectedItems.contains('Region') &&
        _selectedItems.contains('Capital') &&
        _selectedItems.contains('subregion') &&
        _selectedItems.contains('Favorite') &&
        _selectedItems.contains('Name')) {
      return const ApiEventGetAllCountries();
    } else if (_selectedItems.contains('Region')) {
      return ApiEventGetAllCountriesByRegion(name: _sbController.text);
    } else if (_selectedItems.contains('Capital')) {
      return ApiEventGetAllCountriesByCapital(name: _sbController.text);
    } else if (_selectedItems.contains('Subregion')) {
      return ApiEventGetAllCountriesBySubregion(name: _sbController.text);
    } else if (_selectedItems.contains('Name')) {
      return ApiEventGetAllCountriesByName(name: _sbController.text);
    } else {
      return const ApiEventGetAllCountries();
    }
  }
  //   } else if (_selectedItems.contains('Region'))
  // }

  void _showMultiSelect() async {
    final List<String> items = [
      'Region',
      'Subregion',
      'Capital',
      'Favorite',
      'Name'
    ];

    final List<String>? results = await showDialog(
      context: context,
      builder: (context) => MultiSelect(items: items),
    );

    if (results != null) {
      setState(() {
        _selectedItems = results;
      });
    }
  }

  Widget getWidget(ApiState state) {
    if (state is ApiStateGetAllCountries) {
      return CountryList(countries: state.countries);
    } else if (state is ApiStateGetAllCountriesByCapital) {
      return CountryList(countries: state.countries);
    } else if (state is ApiStateGetAllCountriesByName) {
      return CountryList(countries: state.countries);
    } else if (state is ApiStateGetAllCountriesByRegion) {
      return CountryList(countries: state.countries);
    } else if (state is ApiStateGetAllCountriesBySubregion) {
      return CountryList(countries: state.countries);
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
