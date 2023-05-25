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

class ApiStateUninitialized extends ApiState {
  const ApiStateUninitialized({required bool isLoading})
      : super(isLoading: isLoading, loadingText: 'Loading..');
}
