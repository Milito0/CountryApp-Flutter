class CountryModel {
  Name? name;
  String? cioc;
  bool? independent;
  List<String>? capital;
  String? region;
  String? subregion;
  List<int>? latlng;
  List<String>? borders;
  int? population;
  List<String>? continents;
  Flags? flags;
  bool fav = false;

  CountryModel(
      {this.name,
      this.cioc,
      this.independent,
      this.capital,
      this.region,
      this.subregion,
      this.latlng,
      this.borders,
      this.population,
      this.continents,
      this.flags});

  CountryModel.fromJson(Map<String, dynamic> json) {
    name = json['name'] != null ? Name.fromJson(json['name']) : null;
    cioc = json['cioc'];
    independent = json['independent'];
    capital = json["capital"] == null
        ? []
        : List<String>.from(json["capital"].map((x) => x));
    region = json['region'];
    subregion = json['subregion'];
    latlng = json['latlng'].cast<int>();
    borders = json["borders"] == null
        ? []
        : List<String>.from(json["borders"]!.map((x) => x));
    population = json['population'];
    continents = json['continents'].cast<String>();
    flags = json['flags'] != null ? Flags.fromJson(json['flags']) : null;
  }
}

class Name {
  String? common;

  Name({this.common});

  Name.fromJson(Map<String, dynamic> json) {
    common = json['common'];
  }
}

class Flags {
  String? png;

  Flags({this.png});

  Flags.fromJson(Map<String, dynamic> json) {
    png = json['png'];
  }
}
