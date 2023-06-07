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

class ApiStateGetFavCountries extends ApiState {
  final List<CountryModel> countries;
  const ApiStateGetFavCountries(
      {required this.countries, required bool isLoading})
      : super(
            isLoading: isLoading, loadingText: 'Loading favorite countries..');
}

class ApiStateGetRandomCountries extends ApiState {
  final List<CountryModel> countries;
  const ApiStateGetRandomCountries(
      {required this.countries, required bool isLoading})
      : super(isLoading: isLoading, loadingText: 'Loading..');
}

class ApiStateGetHomeCountry extends ApiState {
  const ApiStateGetHomeCountry(
      {required super.isLoading, required super.loadingText});
}

// NAME & REGION
class ApiStateGetCountriesByNameAndRegion extends ApiState {
  final List<CountryModel> countries;
  const ApiStateGetCountriesByNameAndRegion(
      {required this.countries, required bool isLoading})
      : super(isLoading: isLoading, loadingText: 'Loading..');
}

// NAME & SUBREGION
class ApiStateGetCountriesByNameAndSubregion extends ApiState {
  final List<CountryModel> countries;
  const ApiStateGetCountriesByNameAndSubregion(
      {required this.countries, required bool isLoading})
      : super(isLoading: isLoading, loadingText: 'Loading..');
}

// NAME & CAPITAL
class ApiStateGetCountriesByNameAndCapital extends ApiState {
  final List<CountryModel> countries;
  const ApiStateGetCountriesByNameAndCapital(
      {required this.countries, required bool isLoading})
      : super(isLoading: isLoading, loadingText: 'Loading..');
}

// NAME & FAVORITE
class ApiStateGetCountriesByNameAndFavorite extends ApiState {
  final List<CountryModel> countries;
  const ApiStateGetCountriesByNameAndFavorite(
      {required this.countries, required bool isLoading})
      : super(isLoading: isLoading, loadingText: 'Loading..');
}

// REGION & SUBREGION
class ApiStateGetCountriesByRegionAndSubregion extends ApiState {
  final List<CountryModel> countries;
  const ApiStateGetCountriesByRegionAndSubregion(
      {required this.countries, required bool isLoading})
      : super(isLoading: isLoading, loadingText: 'Loading..');
}

// REGION & CAPITAL
class ApiStateGetCountriesByRegionAndCapital extends ApiState {
  final List<CountryModel> countries;
  const ApiStateGetCountriesByRegionAndCapital(
      {required this.countries, required bool isLoading})
      : super(isLoading: isLoading, loadingText: 'Loading..');
}

// REGION & FAVORITE
class ApiStateGetCountriesByRegionAndFavorite extends ApiState {
  final List<CountryModel> countries;
  const ApiStateGetCountriesByRegionAndFavorite(
      {required this.countries, required bool isLoading})
      : super(isLoading: isLoading, loadingText: 'Loading..');
}

// SUBREGION & CAPITAL
class ApiStateGetCountriesBySubregionAndCapital extends ApiState {
  final List<CountryModel> countries;
  const ApiStateGetCountriesBySubregionAndCapital(
      {required this.countries, required bool isLoading})
      : super(isLoading: isLoading, loadingText: 'Loading..');
}

// SUBREGION & FAVORITE
class ApiStateGetCountriesBySubregionAndFavorite extends ApiState {
  final List<CountryModel> countries;
  const ApiStateGetCountriesBySubregionAndFavorite(
      {required this.countries, required bool isLoading})
      : super(isLoading: isLoading, loadingText: 'Loading..');
}

// CAPITAL & FAVORITE
class ApiStateGetCountriesByCapitalAndFavorite extends ApiState {
  final List<CountryModel> countries;
  const ApiStateGetCountriesByCapitalAndFavorite(
      {required this.countries, required bool isLoading})
      : super(isLoading: isLoading, loadingText: 'Loading..');
}

// REGION, SUBREGION & CAPITAL
class ApiStateGetCountriesByRegionSubregionAndCapital extends ApiState {
  final List<CountryModel> countries;
  const ApiStateGetCountriesByRegionSubregionAndCapital(
      {required this.countries, required bool isLoading})
      : super(isLoading: isLoading, loadingText: 'Loading..');
}

// REGION, SUBREGION & FAVORITE
class ApiStateGetCountriesByRegionSubregionAndFavorite extends ApiState {
  final List<CountryModel> countries;
  const ApiStateGetCountriesByRegionSubregionAndFavorite(
      {required this.countries, required bool isLoading})
      : super(isLoading: isLoading, loadingText: 'Loading..');
}

// REGION, SUBREGION & NAME
class ApiStateGetCountriesByRegionSubregionAndName extends ApiState {
  final List<CountryModel> countries;
  const ApiStateGetCountriesByRegionSubregionAndName(
      {required this.countries, required bool isLoading})
      : super(isLoading: isLoading, loadingText: 'Loading..');
}

// REGION, CAPITAL & FAVORITE
class ApiStateGetCountriesByRegionCapitalAndFavorite extends ApiState {
  final List<CountryModel> countries;
  const ApiStateGetCountriesByRegionCapitalAndFavorite(
      {required this.countries, required bool isLoading})
      : super(isLoading: isLoading, loadingText: 'Loading..');
}

// REGION, CAPITAL & NAME
class ApiStateGetCountriesByRegionCapitalAndName extends ApiState {
  final List<CountryModel> countries;
  const ApiStateGetCountriesByRegionCapitalAndName(
      {required this.countries, required bool isLoading})
      : super(isLoading: isLoading, loadingText: 'Loading..');
}

// REGION, FAVORITE & NAME
class ApiStateGetCountriesByRegionFavoriteAndName extends ApiState {
  final List<CountryModel> countries;
  const ApiStateGetCountriesByRegionFavoriteAndName(
      {required this.countries, required bool isLoading})
      : super(isLoading: isLoading, loadingText: 'Loading..');
}

// SUBREGION, CAPITAL & FAVORITE
class ApiStateGetCountriesBySubregionCapitalAndFavorite extends ApiState {
  final List<CountryModel> countries;
  const ApiStateGetCountriesBySubregionCapitalAndFavorite(
      {required this.countries, required bool isLoading})
      : super(isLoading: isLoading, loadingText: 'Loading..');
}

// SUBREGION, CAPITAL & NAME
class ApiStateGetCountriesBySubregionCapitalAndName extends ApiState {
  final List<CountryModel> countries;
  const ApiStateGetCountriesBySubregionCapitalAndName(
      {required this.countries, required bool isLoading})
      : super(isLoading: isLoading, loadingText: 'Loading..');
}

// SUBREGION, FAVORITE & NAME
class ApiStateGetCountriesBySubregionFavoriteAndName extends ApiState {
  final List<CountryModel> countries;
  const ApiStateGetCountriesBySubregionFavoriteAndName(
      {required this.countries, required bool isLoading})
      : super(isLoading: isLoading, loadingText: 'Loading..');
}

// CAPITAL, FAVOURITE & NAME
class ApiStateGetCountriesByCapitalFavoriteAndName extends ApiState {
  final List<CountryModel> countries;
  const ApiStateGetCountriesByCapitalFavoriteAndName(
      {required this.countries, required bool isLoading})
      : super(isLoading: isLoading, loadingText: 'Loading..');
}

// REGION, SUBREGION, CAPITAL & FAVORITE
class ApiStateGetCountriesByRegionSubregionCapitalAndFavorite extends ApiState {
  final List<CountryModel> countries;
  const ApiStateGetCountriesByRegionSubregionCapitalAndFavorite(
      {required this.countries, required bool isLoading})
      : super(isLoading: isLoading, loadingText: 'Loading..');
}

// REGION, SUBREGION, CAPITAL & NAME
class ApiStateGetCountriesByRegionSubregionCapitalAndName extends ApiState {
  final List<CountryModel> countries;
  const ApiStateGetCountriesByRegionSubregionCapitalAndName(
      {required this.countries, required bool isLoading})
      : super(isLoading: isLoading, loadingText: 'Loading..');
}

// REGION, SUBREGION, FAVORITE & NAME
class ApiStateGetCountriesByRegionSubregionFavoriteAndName extends ApiState {
  final List<CountryModel> countries;
  const ApiStateGetCountriesByRegionSubregionFavoriteAndName(
      {required this.countries, required bool isLoading})
      : super(isLoading: isLoading, loadingText: 'Loading..');
}

// REGION, CAPITAL, FAVORITE & NAME
class ApiStateGetCountriesByRegionCapitalFavoriteAndName extends ApiState {
  final List<CountryModel> countries;
  const ApiStateGetCountriesByRegionCapitalFavoriteAndName(
      {required this.countries, required bool isLoading})
      : super(isLoading: isLoading, loadingText: 'Loading..');
}

// SUBREGION, CAPITAL, FAVORITE & NAME
class ApiStateGetCountriesBySubregionCapitalFavoriteAndName extends ApiState {
  final List<CountryModel> countries;
  const ApiStateGetCountriesBySubregionCapitalFavoriteAndName(
      {required this.countries, required bool isLoading})
      : super(isLoading: isLoading, loadingText: 'Loading..');
}

// REGION, SUBREGION, CAPITAL, FAVORITE & NAME
class ApiStateGetCountriesByAll extends ApiState {
  final List<CountryModel> countries;
  const ApiStateGetCountriesByAll(
      {required this.countries, required bool isLoading})
      : super(isLoading: isLoading, loadingText: 'Loading..');
}
