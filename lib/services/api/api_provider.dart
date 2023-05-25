import 'package:country_app/models/country_model.dart';

abstract class ApiProvider {
  Future<List<CountryModel>> getAllCountries();
}
