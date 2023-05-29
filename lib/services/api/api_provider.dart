import 'package:country_app/models/country_model.dart';

abstract class ApiProvider {
  Future<List<CountryModel>> getAllCountries();
  Future<List<CountryModel>> getAllCountriesByName(String name);
  Future<List<CountryModel>> getAllCountriesByRegion(String name);
  Future<List<CountryModel>> getAllCountriesBySubregion(String name);
  Future<List<CountryModel>> getAllCountriesByCapital(String name);
  Future<List<CountryModel>> getAllCountriesByFavorites(String name);
  Future<CountryModel> getCountry(String code);
}
