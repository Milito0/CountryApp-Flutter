import 'dart:convert';
import 'package:country_app/models/country_model.dart';
import 'package:country_app/services/api/api_provider.dart';
import 'package:http/http.dart' as http;

class Repository extends ApiProvider {
  final String _url = "https://restcountries.com/v3.1/";

  @override
  Future<List<CountryModel>> getAllCountries() async {
    final response =
        await http.get(Uri.parse('${_url}independent?status=true'));

    if (response.statusCode == 200) {
      var newData = json.decode(response.body);
      final List<CountryModel> countries =
          List<CountryModel>.from(newData.map((e) => CountryModel.fromJson(e)));
      return countries;
    }
    return List.empty();
  }

  @override
  Future<List<CountryModel>> getAllCountriesByCapital(String name) async {
    final response = await http.get(Uri.parse('${_url}capital/$name'));

    if (response.statusCode == 200) {
      var newData = json.decode(response.body);
      final List<CountryModel> countries =
          List<CountryModel>.from(newData.map((e) => CountryModel.fromJson(e)));

      return countries.where((element) {
        if (element.independent != null && element.independent == true) {
          return true;
        }
        return false;
      }).toList();
    }
    return List.empty();
  }

  @override
  Future<List<CountryModel>> getAllCountriesByFavorites(String name) {
    // TODO: implement getAllCountriesByFavorites
    throw UnimplementedError();
  }

  @override
  Future<List<CountryModel>> getAllCountriesByName(String name) async {
    final response = await http.get(Uri.parse('${_url}name/$name'));

    if (response.statusCode == 200) {
      var newData = json.decode(response.body);
      final List<CountryModel> countries =
          List<CountryModel>.from(newData.map((e) => CountryModel.fromJson(e)));

      return countries.where((element) {
        if (element.independent != null && element.independent == true) {
          return true;
        }
        return false;
      }).toList();
    }
    return List.empty();
  }

  @override
  Future<List<CountryModel>> getAllCountriesByRegion(String name) async {
    final response = await http.get(Uri.parse('${_url}region/$name'));

    if (response.statusCode == 200) {
      var newData = json.decode(response.body);
      final List<CountryModel> countries =
          List<CountryModel>.from(newData.map((e) => CountryModel.fromJson(e)));

      return countries.where((element) {
        if (element.independent != null && element.independent == true) {
          return true;
        }
        return false;
      }).toList();
    }
    return List.empty();
  }

  @override
  Future<List<CountryModel>> getAllCountriesBySubregion(String name) async {
    final response = await http.get(Uri.parse('${_url}subregion/$name'));

    if (response.statusCode == 200) {
      var newData = json.decode(response.body);
      final List<CountryModel> countries =
          List<CountryModel>.from(newData.map((e) => CountryModel.fromJson(e)));

      return countries.where((element) {
        if (element.independent != null && element.independent == true) {
          return true;
        }
        return false;
      }).toList();
    }
    return List.empty();
  }

  @override
  Future<CountryModel> getCountry(String code) async {
    final response = await http.get(Uri.parse('${_url}alpha/$code'));

    if (response.statusCode == 200) {
      var newData = json.decode(response.body);
      final List<CountryModel> countries =
          List<CountryModel>.from(newData.map((e) => CountryModel.fromJson(e)));

      return countries[0];
    }
    return CountryModel();
  }
}
