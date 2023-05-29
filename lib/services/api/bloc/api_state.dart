import 'package:country_app/models/country_model.dart';

abstract class ApiState {
  final bool isLoading;
  final String loadingText;

  const ApiState({required this.isLoading, required this.loadingText});
}

class ApiStateGetAllCountries extends ApiState {
  final List<CountryModel> countries;
  const ApiStateGetAllCountries(
      {required bool isLoading, required this.countries})
      : super(isLoading: isLoading, loadingText: 'Loading countries..');
}

class ApiStateGetAllCountriesByCapital extends ApiState {
  final List<CountryModel> countries;
  const ApiStateGetAllCountriesByCapital(
      {required bool isLoading, required this.countries})
      : super(isLoading: isLoading, loadingText: 'Loading countries..');
}

class ApiStateGetAllCountriesByRegion extends ApiState {
  final List<CountryModel> countries;
  const ApiStateGetAllCountriesByRegion(
      {required bool isLoading, required this.countries})
      : super(isLoading: isLoading, loadingText: 'Loading countries..');
}

class ApiStateGetAllCountriesBySubregion extends ApiState {
  final List<CountryModel> countries;
  const ApiStateGetAllCountriesBySubregion(
      {required bool isLoading, required this.countries})
      : super(isLoading: isLoading, loadingText: 'Loading countries..');
}

class ApiStateGetAllCountriesByName extends ApiState {
  final List<CountryModel> countries;
  const ApiStateGetAllCountriesByName(
      {required bool isLoading, required this.countries})
      : super(isLoading: isLoading, loadingText: 'Loading countries..');
}

class ApiStateUninitialized extends ApiState {
  const ApiStateUninitialized({required bool isLoading})
      : super(isLoading: isLoading, loadingText: 'Loading..');
}

class ApiStateGetCountry extends ApiState {
  final CountryModel country;
  const ApiStateGetCountry({required this.country, required bool isLoading})
      : super(isLoading: isLoading, loadingText: 'Loading..');
}
