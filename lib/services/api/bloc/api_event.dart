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

class ApiEventGetCountriesByRegionAndSubregion extends ApiEvent {
  final String name;
  const ApiEventGetCountriesByRegionAndSubregion({required this.name});
}

class ApiEventGetCountriesByRegionAndCapital extends ApiEvent {
  final String name;
  const ApiEventGetCountriesByRegionAndCapital({required this.name});
}

class ApiEventGetCountriesByRegionAndFavorite extends ApiEvent {
  final String name;
  const ApiEventGetCountriesByRegionAndFavorite({required this.name});
}

class ApiEventGetCountriesByRegionAndName extends ApiEvent {
  final String name;
  const ApiEventGetCountriesByRegionAndName({required this.name});
}

class ApiEventGetCountriesBySubregionAndCapital extends ApiEvent {
  final String name;
  const ApiEventGetCountriesBySubregionAndCapital({required this.name});
}

class ApiEventGetCountriesBySubregionAndFavorite extends ApiEvent {
  final String name;
  const ApiEventGetCountriesBySubregionAndFavorite({required this.name});
}

class ApiEventGetCountriesBySubregionAndName extends ApiEvent {
  final String name;
  const ApiEventGetCountriesBySubregionAndName({required this.name});
}

class ApiEventGetCountriesByCapitalAndFavorite extends ApiEvent {
  final String name;
  const ApiEventGetCountriesByCapitalAndFavorite({required this.name});
}

class ApiEventGetCountriesByCapitalAndName extends ApiEvent {
  final String name;
  const ApiEventGetCountriesByCapitalAndName({required this.name});
}

class ApiEventGetCountriesByFavoriteAndName extends ApiEvent {
  final String name;
  const ApiEventGetCountriesByFavoriteAndName({required this.name});
}

class ApiEventGetCountriesByRegionSubregionAndCapital extends ApiEvent {
  final String name;
  const ApiEventGetCountriesByRegionSubregionAndCapital({required this.name});
}

class ApiEventGetCountriesByRegionSubregionAndFavorite extends ApiEvent {
  final String name;
  const ApiEventGetCountriesByRegionSubregionAndFavorite({required this.name});
}

class ApiEventGetCountriesByRegionSubregionAndName extends ApiEvent {
  final String name;
  const ApiEventGetCountriesByRegionSubregionAndName({required this.name});
}

class ApiEventGetCountriesByRegionCapitalAndFavorite extends ApiEvent {
  final String name;
  const ApiEventGetCountriesByRegionCapitalAndFavorite({required this.name});
}

class ApiEventGetCountriesByRegionCapitalAndName extends ApiEvent {
  final String name;
  const ApiEventGetCountriesByRegionCapitalAndName({required this.name});
}

class ApiEventGetCountriesByRegionFavoriteAndName extends ApiEvent {
  final String name;
  const ApiEventGetCountriesByRegionFavoriteAndName({required this.name});
}

class ApiEventGetCountriesBySubregionCapitalAndFavorite extends ApiEvent {
  final String name;
  const ApiEventGetCountriesBySubregionCapitalAndFavorite({required this.name});
}

class ApiEventGetCountriesBySubregionCapitalAndName extends ApiEvent {
  final String name;
  const ApiEventGetCountriesBySubregionCapitalAndName({required this.name});
}

class ApiEventGetCountriesBySubregionFavoriteAndName extends ApiEvent {
  final String name;
  const ApiEventGetCountriesBySubregionFavoriteAndName({required this.name});
}

class ApiEventGetCountriesByCapitalFavoriteAndName extends ApiEvent {
  final String name;
  const ApiEventGetCountriesByCapitalFavoriteAndName({required this.name});
}

class ApiEventGetCountriesByRegionSubregionCapitalAndFavorite extends ApiEvent {
  final String name;
  const ApiEventGetCountriesByRegionSubregionCapitalAndFavorite(
      {required this.name});
}

class ApiEventGetCountriesByRegionSubregionCapitalAndName extends ApiEvent {
  final String name;
  const ApiEventGetCountriesByRegionSubregionCapitalAndName(
      {required this.name});
}

class ApiEventGetCountriesByRegionSubregionFavoriteAndName extends ApiEvent {
  final String name;
  const ApiEventGetCountriesByRegionSubregionFavoriteAndName(
      {required this.name});
}

class ApiEventGetCountriesByRegionCapitalFavoriteAndName extends ApiEvent {
  final String name;
  const ApiEventGetCountriesByRegionCapitalFavoriteAndName(
      {required this.name});
}

class ApiEventGetCountriesBySubregionCapitalFavoriteAndName extends ApiEvent {
  final String name;
  const ApiEventGetCountriesBySubregionCapitalFavoriteAndName(
      {required this.name});
}

class ApiEventGetCountriesByAll extends ApiEvent {
  final String name;
  const ApiEventGetCountriesByAll({required this.name});
}
