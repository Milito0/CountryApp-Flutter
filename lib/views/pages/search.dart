import 'package:country_app/constants/colors.dart';
import 'package:country_app/services/api/bloc/api_bloc.dart';
import 'package:country_app/services/api/bloc/api_event.dart';
import 'package:country_app/services/api/bloc/api_state.dart';
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
  late final TextEditingController _sbController;
  List<String> _selectedItems = [];
  late final Widget myList;

  @override
  void initState() {
    _sbController = TextEditingController();
    context.read<ApiBloc>().add(const ApiEventGetAllCountries());
    super.initState();
  }

  @override
  void dispose() {
    _sbController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ApiBloc, ApiState>(
      listener: (context, state) {
        if (state is ApiStateGetCountry) {
          context.read<ApiBloc>().add(searchCountries(_sbController.text));
        }
      },
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
        _selectedItems.contains('Subregion') &&
        _selectedItems.contains('Favorite') &&
        _selectedItems.contains('Name')) {
      return ApiEventGetCountriesByAll(name: value);
    } else if (_selectedItems.contains('Capital') &&
        _selectedItems.contains('Subregion') &&
        _selectedItems.contains('Favorite') &&
        _selectedItems.contains('Name')) {
      return ApiEventGetCountriesBySubregionCapitalFavoriteAndName(name: value);
    } else if (_selectedItems.contains('Region') &&
        _selectedItems.contains('Capital') &&
        _selectedItems.contains('Favorite') &&
        _selectedItems.contains('Name')) {
      return ApiEventGetCountriesByRegionCapitalFavoriteAndName(name: value);
    } else if (_selectedItems.contains('Region') &&
        _selectedItems.contains('Subregion') &&
        _selectedItems.contains('Favorite') &&
        _selectedItems.contains('Name')) {
      return ApiEventGetCountriesByRegionSubregionFavoriteAndName(name: value);
    } else if (_selectedItems.contains('Region') &&
        _selectedItems.contains('Subregion') &&
        _selectedItems.contains('Capital') &&
        _selectedItems.contains('Name')) {
      return ApiEventGetCountriesByRegionSubregionCapitalAndName(name: value);
    } else if (_selectedItems.contains('Region') &&
        _selectedItems.contains('Subregion') &&
        _selectedItems.contains('Capital') &&
        _selectedItems.contains('Favorite')) {
      return ApiEventGetCountriesByRegionSubregionCapitalAndFavorite(
          name: value);
    } else if (_selectedItems.contains('Capital') &&
        _selectedItems.contains('Favorite') &&
        _selectedItems.contains('Name')) {
      return ApiEventGetCountriesByCapitalFavoriteAndName(name: value);
    } else if (_selectedItems.contains('Subregion') &&
        _selectedItems.contains('Favorite') &&
        _selectedItems.contains('Name')) {
      return ApiEventGetCountriesBySubregionFavoriteAndName(name: value);
    } else if (_selectedItems.contains('Subregion') &&
        _selectedItems.contains('Capital') &&
        _selectedItems.contains('Name')) {
      return ApiEventGetCountriesBySubregionCapitalAndName(name: value);
    } else if (_selectedItems.contains('Subregion') &&
        _selectedItems.contains('Capital') &&
        _selectedItems.contains('Favorite')) {
      return ApiEventGetCountriesBySubregionCapitalAndFavorite(name: value);
    } else if (_selectedItems.contains('Region') &&
        _selectedItems.contains('Favorite') &&
        _selectedItems.contains('Name')) {
      return ApiEventGetCountriesByRegionFavoriteAndName(name: value);
    } else if (_selectedItems.contains('Region') &&
        _selectedItems.contains('Capital') &&
        _selectedItems.contains('Name')) {
      return ApiEventGetCountriesByRegionCapitalAndName(name: value);
    } else if (_selectedItems.contains('Region') &&
        _selectedItems.contains('Capital') &&
        _selectedItems.contains('Favorite')) {
      return ApiEventGetCountriesByRegionCapitalAndFavorite(name: value);
    } else if (_selectedItems.contains('Region') &&
        _selectedItems.contains('Subregion') &&
        _selectedItems.contains('Name')) {
      return ApiEventGetCountriesByRegionSubregionAndName(name: value);
    } else if (_selectedItems.contains('Region') &&
        _selectedItems.contains('Subregion') &&
        _selectedItems.contains('Favorite')) {
      return ApiEventGetCountriesByRegionSubregionAndFavorite(name: value);
    } else if (_selectedItems.contains('Region') &&
        _selectedItems.contains('Subregion') &&
        _selectedItems.contains('Capital')) {
      return ApiEventGetCountriesByRegionSubregionAndCapital(name: value);
    } else if (_selectedItems.contains('Favorite') &&
        _selectedItems.contains('Name')) {
      return ApiEventGetCountriesByFavoriteAndName(name: value);
    } else if (_selectedItems.contains('Capital') &&
        _selectedItems.contains('Name')) {
      return ApiEventGetCountriesByCapitalAndName(name: value);
    } else if (_selectedItems.contains('Capital') &&
        _selectedItems.contains('Favorite')) {
      return ApiEventGetCountriesByCapitalAndFavorite(name: value);
    } else if (_selectedItems.contains('Name') &&
        _selectedItems.contains('Subregion')) {
      return ApiEventGetCountriesBySubregionAndName(name: value);
    } else if (_selectedItems.contains('Favorite') &&
        _selectedItems.contains('Subregion')) {
      return ApiEventGetCountriesBySubregionAndFavorite(name: value);
    } else if (_selectedItems.contains('Capital') &&
        _selectedItems.contains('Subregion')) {
      return ApiEventGetCountriesBySubregionAndCapital(name: value);
    } else if (_selectedItems.contains('Region') &&
        _selectedItems.contains('Name')) {
      return ApiEventGetCountriesByRegionAndName(name: value);
    } else if (_selectedItems.contains('Region') &&
        _selectedItems.contains('Favorite')) {
      return ApiEventGetCountriesByRegionAndFavorite(name: value);
    } else if (_selectedItems.contains('Region') &&
        _selectedItems.contains('Capital')) {
      return ApiEventGetCountriesByRegionAndCapital(name: value);
    } else if (_selectedItems.contains('Region') &&
        _selectedItems.contains('Subregion')) {
      return ApiEventGetCountriesByRegionAndSubregion(name: value);
    } else if (_selectedItems.contains('Region')) {
      return ApiEventGetAllCountriesByRegion(name: value);
    } else if (_selectedItems.contains('Capital')) {
      return ApiEventGetAllCountriesByCapital(name: value);
    } else if (_selectedItems.contains('Subregion')) {
      return ApiEventGetAllCountriesBySubregion(name: value);
    } else if (_selectedItems.contains('Name')) {
      return ApiEventGetAllCountriesByName(name: value);
    } else if (_selectedItems.contains('Favorite')) {
      return const ApiEventGetFavorites();
    } else {
      return const ApiEventGetAllCountries();
    }
  }

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
    context.read<ApiBloc>().add(searchCountries(_sbController.text));
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
    } else if (state is ApiStateGetFavCountries) {
      return CountryList(countries: state.countries);
    } else if (state is ApiStateGetCountriesByNameAndRegion) {
      return CountryList(countries: state.countries);
    } else if (state is ApiStateGetCountriesByNameAndSubregion) {
      return CountryList(countries: state.countries);
    } else if (state is ApiStateGetCountriesByNameAndCapital) {
      return CountryList(countries: state.countries);
    } else if (state is ApiStateGetCountriesByNameAndFavorite) {
      return CountryList(countries: state.countries);
    } else if (state is ApiStateGetCountriesByRegionAndSubregion) {
      return CountryList(countries: state.countries);
    } else if (state is ApiStateGetCountriesByRegionAndCapital) {
      return CountryList(countries: state.countries);
    } else if (state is ApiStateGetCountriesByRegionAndFavorite) {
      return CountryList(countries: state.countries);
    } else if (state is ApiStateGetCountriesBySubregionAndCapital) {
      return CountryList(countries: state.countries);
    } else if (state is ApiStateGetCountriesBySubregionAndFavorite) {
      return CountryList(countries: state.countries);
    } else if (state is ApiStateGetCountriesByCapitalAndFavorite) {
      return CountryList(countries: state.countries);
    } else if (state is ApiStateGetCountriesByRegionSubregionAndCapital) {
      return CountryList(countries: state.countries);
    } else if (state is ApiStateGetCountriesByRegionSubregionAndFavorite) {
      return CountryList(countries: state.countries);
    } else if (state is ApiStateGetCountriesByRegionSubregionAndName) {
      return CountryList(countries: state.countries);
    } else if (state is ApiStateGetCountriesByRegionCapitalAndFavorite) {
      return CountryList(countries: state.countries);
    } else if (state is ApiStateGetCountriesByRegionCapitalAndName) {
      return CountryList(countries: state.countries);
    } else if (state is ApiStateGetCountriesByRegionFavoriteAndName) {
      return CountryList(countries: state.countries);
    } else if (state is ApiStateGetCountriesBySubregionCapitalAndFavorite) {
      return CountryList(countries: state.countries);
    } else if (state is ApiStateGetCountriesBySubregionCapitalAndName) {
      return CountryList(countries: state.countries);
    } else if (state is ApiStateGetCountriesBySubregionFavoriteAndName) {
      return CountryList(countries: state.countries);
    } else if (state is ApiStateGetCountriesByCapitalFavoriteAndName) {
      return CountryList(countries: state.countries);
    } else if (state
        is ApiStateGetCountriesByRegionSubregionCapitalAndFavorite) {
      return CountryList(countries: state.countries);
    } else if (state is ApiStateGetCountriesByRegionSubregionCapitalAndName) {
      return CountryList(countries: state.countries);
    } else if (state is ApiStateGetCountriesByRegionSubregionFavoriteAndName) {
      return CountryList(countries: state.countries);
    } else if (state is ApiStateGetCountriesByRegionCapitalFavoriteAndName) {
      return CountryList(countries: state.countries);
    } else if (state is ApiStateGetCountriesBySubregionCapitalFavoriteAndName) {
      return CountryList(countries: state.countries);
    } else if (state is ApiStateGetCountriesByAll) {
      return CountryList(countries: state.countries);
    } else {
      return Center(
        child: Image.asset(
          "assets/images/globe-2.gif",
          height: 200,
          width: 200,
        ),
      );
    }
  }
}
