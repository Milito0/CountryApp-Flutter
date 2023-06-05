import 'package:flutter/cupertino.dart';

@immutable
abstract class ApiEvent {
  const ApiEvent();
}

class ApiEventGetAllCountries extends ApiEvent {
  const ApiEventGetAllCountries();
}

class ApiEventGetAllCountriesByName extends ApiEvent {
  final String name;
  const ApiEventGetAllCountriesByName({required this.name});
}

class ApiEventGetAllCountriesByCapital extends ApiEvent {
  final String name;
  const ApiEventGetAllCountriesByCapital({required this.name});
}

class ApiEventGetAllCountriesByRegion extends ApiEvent {
  final String name;
  const ApiEventGetAllCountriesByRegion({required this.name});
}

class ApiEventGetAllCountriesBySubregion extends ApiEvent {
  final String name;
  const ApiEventGetAllCountriesBySubregion({required this.name});
}

class ApiEventGetCountry extends ApiEvent {
  final String code;
  const ApiEventGetCountry({required this.code});
}

class ApiEventGetFavorites extends ApiEvent {
  const ApiEventGetFavorites();
}

class ApiEventGetRandomCountries extends ApiEvent {
  const ApiEventGetRandomCountries();
}

class ApiEventGetHomeCountry extends ApiEvent {
  const ApiEventGetHomeCountry();
}
