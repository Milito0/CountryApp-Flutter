import 'dart:convert';
import 'package:country_app/models/country_model.dart';
import 'package:http/http.dart' as http;

class Repository {
  final String _url = "https://restcountries.com/v3.1/independent?status=true";

  Future<List<CountryModel>> getCountries() async {
    final response = await http.get(Uri.parse(_url));

    if (response.statusCode == 200) {
      var newData = json.decode(response.body);
      final List<CountryModel> countries =
          List<CountryModel>.from(newData.map((e) => CountryModel.fromJson(e)));
      return countries;
    }
    return List.empty();
  }
}
