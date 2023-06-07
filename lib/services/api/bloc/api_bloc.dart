import 'dart:math';

import 'package:country_app/models/country_model.dart';
import 'package:country_app/services/api/bloc/api_event.dart';
import 'package:country_app/services/api/bloc/api_state.dart';
import 'package:country_app/services/api/repository.dart';
import 'package:country_app/services/auth/auth_service.dart';
import 'package:country_app/services/cloud/firebase_cloud.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApiBloc extends Bloc<ApiEvent, ApiState> {
  final FirebaseCloudStorage _countryService = FirebaseCloudStorage();
  String get userId => AuthService.firebase().currentUser!.id;

  ApiBloc(Repository repository)
      : super(const ApiStateUninitialized(isLoading: true)) {
    on<ApiEventGetAllCountries>(
      (event, emit) async {
        emit(const ApiStateUninitialized(isLoading: true));
        final countries = await repository.getAllCountries();

        final favCountries =
            await _countryService.getFavCountries(ownerId: userId);

        for (var country in countries) {
          for (var favCountry in favCountries) {
            if (country.cioc == favCountry.cioc) country.fav = true;
          }
        }

        emit(ApiStateGetAllCountries(isLoading: false, countries: countries));
      },
    );

    on<ApiEventGetAllCountriesByCapital>(
      (event, emit) async {
        emit(const ApiStateUninitialized(isLoading: true));
        final countries = await repository.getAllCountriesByCapital(event.name);
        final favCountries =
            await _countryService.getFavCountries(ownerId: userId);

        for (var country in countries) {
          for (var favCountry in favCountries) {
            if (country.cioc == favCountry.cioc) country.fav = true;
          }
        }
        emit(ApiStateGetAllCountriesByCapital(
            isLoading: false, countries: countries));
      },
    );

    on<ApiEventGetAllCountriesByName>(
      (event, emit) async {
        emit(const ApiStateUninitialized(isLoading: true));
        final countries = await repository.getAllCountriesByName(event.name);
        final favCountries =
            await _countryService.getFavCountries(ownerId: userId);

        for (var country in countries) {
          for (var favCountry in favCountries) {
            if (country.cioc == favCountry.cioc) country.fav = true;
          }
        }
        emit(ApiStateGetAllCountriesByName(
            isLoading: false, countries: countries));
      },
    );

    on<ApiEventGetAllCountriesByRegion>(
      (event, emit) async {
        emit(const ApiStateUninitialized(isLoading: true));
        final countries = await repository.getAllCountriesByRegion(event.name);
        final favCountries =
            await _countryService.getFavCountries(ownerId: userId);

        for (var country in countries) {
          for (var favCountry in favCountries) {
            if (country.cioc == favCountry.cioc) country.fav = true;
          }
        }
        emit(ApiStateGetAllCountriesByRegion(
            isLoading: false, countries: countries));
      },
    );

    on<ApiEventGetAllCountriesBySubregion>(
      (event, emit) async {
        emit(const ApiStateUninitialized(isLoading: true));
        final countries =
            await repository.getAllCountriesBySubregion(event.name);
        final favCountries =
            await _countryService.getFavCountries(ownerId: userId);

        for (var country in countries) {
          for (var favCountry in favCountries) {
            if (country.cioc == favCountry.cioc) country.fav = true;
          }
        }
        emit(ApiStateGetAllCountriesBySubregion(
            isLoading: false, countries: countries));
      },
    );

    on<ApiEventGetCountry>(
      (event, emit) async {
        emit(const ApiStateUninitialized(isLoading: true));
        final country = await repository.getCountry(event.code);
        final favCountries =
            await _countryService.getFavCountries(ownerId: userId);

        for (var favCountry in favCountries) {
          if (country.cioc == favCountry.cioc) country.fav = true;
        }
        emit(ApiStateGetCountry(isLoading: false, country: country));
      },
    );

    on<ApiEventGetFavorites>(
      (event, emit) async {
        emit(const ApiStateUninitialized(isLoading: true));
        final countries = await repository.getAllCountries();
        final List<CountryModel> favs = [];
        final favCountries =
            await _countryService.getFavCountries(ownerId: userId);

        for (var country in countries) {
          for (var favCountry in favCountries) {
            if (country.cioc == favCountry.cioc) {
              country.fav = true;
              favs.add(country);
            }
          }
        }
        emit(ApiStateGetFavCountries(isLoading: false, countries: favs));
      },
    );

    on<ApiEventGetRandomCountries>(
      (event, emit) async {
        emit(const ApiStateUninitialized(isLoading: true));
        final countries = await repository.getAllCountries();
        final List<CountryModel> randomCountries = [];
        final List<CountryModel> americaCountries = [];
        final List<CountryModel> oceaniaCountries = [];
        final List<CountryModel> africaCountries = [];
        final List<CountryModel> europeCountries = [];
        final List<CountryModel> asiaCountries = [];
        var rng = Random();
        for (var c in countries) {
          if (c.region == 'Asia') {
            asiaCountries.add(c);
          } else if (c.region == 'Oceania') {
            oceaniaCountries.add(c);
          } else if (c.region == 'Europe') {
            europeCountries.add(c);
          } else if (c.region == 'Americas') {
            americaCountries.add(c);
          } else if (c.region == 'Africa') {
            africaCountries.add(c);
          }
        }

        randomCountries
            .add(asiaCountries.elementAt(rng.nextInt(asiaCountries.length)));
        randomCountries.add(
            oceaniaCountries.elementAt(rng.nextInt(oceaniaCountries.length)));
        randomCountries.add(
            europeCountries.elementAt(rng.nextInt(europeCountries.length)));
        randomCountries.add(
            americaCountries.elementAt(rng.nextInt(americaCountries.length)));
        randomCountries.add(
            africaCountries.elementAt(rng.nextInt(africaCountries.length)));

        emit(ApiStateGetRandomCountries(
            countries: randomCountries, isLoading: false));
      },
    );

    on<ApiEventGetHomeCountry>(
      (event, emit) {
        emit(const ApiStateGetHomeCountry(
            isLoading: false, loadingText: 'Loading..'));
      },
    );

// -------------------------
    on<ApiEventGetCountriesByRegionAndSubregion>(
      (event, emit) async {
        emit(const ApiStateUninitialized(isLoading: true));
        final subregionCountries =
            await repository.getAllCountriesBySubregion(event.name);
        final regionCountries =
            await repository.getAllCountriesByRegion(event.name);

        final favCountries =
            await _countryService.getFavCountries(ownerId: userId);

        for (var country in subregionCountries) {
          regionCountries.add(country);
        }

        for (var country in regionCountries) {
          for (var favCountry in favCountries) {
            if (country.cioc == favCountry.cioc) country.fav = true;
          }
        }

        regionCountries.toSet().toList();

        emit(ApiStateGetCountriesByRegionAndSubregion(
            isLoading: false, countries: subregionCountries));
      },
    );

    on<ApiEventGetCountriesByRegionAndCapital>(
      (event, emit) async {
        emit(const ApiStateUninitialized(isLoading: true));
        final countries = await repository.getAllCountriesByCapital(event.name);
        final regionCountries =
            await repository.getAllCountriesByRegion(event.name);

        final favCountries =
            await _countryService.getFavCountries(ownerId: userId);

        for (var country in countries) {
          regionCountries.add(country);
        }

        for (var country in regionCountries) {
          for (var favCountry in favCountries) {
            if (country.cioc == favCountry.cioc) country.fav = true;
          }
        }

        regionCountries.toSet().toList();

        emit(ApiStateGetCountriesByRegionAndCapital(
            isLoading: false, countries: countries));
      },
    );

    on<ApiEventGetCountriesByRegionAndFavorite>(
      (event, emit) async {
        emit(const ApiStateUninitialized(isLoading: true));
        final countries = await repository.getAllCountriesByRegion(event.name);
        final List<CountryModel> favs = [];
        final favCountries =
            await _countryService.getFavCountries(ownerId: userId);

        for (var country in countries) {
          for (var favCountry in favCountries) {
            if (country.cioc == favCountry.cioc) {
              country.fav = true;
              favs.add(country);
            }
          }
        }
        emit(ApiStateGetCountriesByRegionAndFavorite(
            isLoading: false, countries: favs));
      },
    );

    on<ApiEventGetCountriesByRegionAndName>(
      (event, emit) async {
        emit(const ApiStateUninitialized(isLoading: true));
        final countries = await repository.getAllCountriesByName(event.name);
        final regionCountries =
            await repository.getAllCountriesByRegion(event.name);

        final favCountries =
            await _countryService.getFavCountries(ownerId: userId);

        for (var country in countries) {
          regionCountries.add(country);
        }

        for (var country in regionCountries) {
          for (var favCountry in favCountries) {
            if (country.cioc == favCountry.cioc) country.fav = true;
          }
        }

        regionCountries.toSet().toList();

        emit(ApiStateGetCountriesByNameAndRegion(
            isLoading: false, countries: countries));
      },
    );

    on<ApiEventGetCountriesBySubregionAndCapital>(
      (event, emit) async {
        emit(const ApiStateUninitialized(isLoading: true));
        final countries = await repository.getAllCountriesByCapital(event.name);
        final subregionCountries =
            await repository.getAllCountriesBySubregion(event.name);

        final favCountries =
            await _countryService.getFavCountries(ownerId: userId);

        for (var country in countries) {
          subregionCountries.add(country);
        }

        for (var country in subregionCountries) {
          for (var favCountry in favCountries) {
            if (country.cioc == favCountry.cioc) country.fav = true;
          }
        }

        subregionCountries.toSet().toList();

        emit(ApiStateGetCountriesBySubregionAndCapital(
            isLoading: false, countries: countries));
      },
    );

    on<ApiEventGetCountriesBySubregionAndFavorite>(
      (event, emit) async {
        emit(const ApiStateUninitialized(isLoading: true));
        final countries =
            await repository.getAllCountriesBySubregion(event.name);
        final List<CountryModel> favs = [];
        final favCountries =
            await _countryService.getFavCountries(ownerId: userId);

        for (var country in countries) {
          for (var favCountry in favCountries) {
            if (country.cioc == favCountry.cioc) {
              country.fav = true;
              favs.add(country);
            }
          }
        }
        emit(ApiStateGetCountriesBySubregionAndFavorite(
            isLoading: false, countries: favs));
      },
    );

    on<ApiEventGetCountriesBySubregionAndName>(
      (event, emit) async {
        emit(const ApiStateUninitialized(isLoading: true));
        final countries = await repository.getAllCountriesByName(event.name);
        final subregionCountries =
            await repository.getAllCountriesBySubregion(event.name);

        final favCountries =
            await _countryService.getFavCountries(ownerId: userId);

        for (var country in countries) {
          subregionCountries.add(country);
        }

        for (var country in subregionCountries) {
          for (var favCountry in favCountries) {
            if (country.cioc == favCountry.cioc) country.fav = true;
          }
        }

        subregionCountries.toSet().toList();

        emit(ApiStateGetCountriesByNameAndSubregion(
            isLoading: false, countries: countries));
      },
    );

    on<ApiEventGetCountriesByCapitalAndFavorite>(
      (event, emit) async {
        emit(const ApiStateUninitialized(isLoading: true));
        final countries = await repository.getAllCountriesByCapital(event.name);
        final List<CountryModel> favs = [];
        final favCountries =
            await _countryService.getFavCountries(ownerId: userId);

        for (var country in countries) {
          for (var favCountry in favCountries) {
            if (country.cioc == favCountry.cioc) {
              country.fav = true;
              favs.add(country);
            }
          }
        }
        emit(ApiStateGetCountriesByCapitalAndFavorite(
            isLoading: false, countries: favs));
      },
    );

    on<ApiEventGetCountriesByCapitalAndName>(
      (event, emit) async {
        emit(const ApiStateUninitialized(isLoading: true));
        final countries = await repository.getAllCountriesByCapital(event.name);
        final regionCountries =
            await repository.getAllCountriesByName(event.name);

        final favCountries =
            await _countryService.getFavCountries(ownerId: userId);

        for (var country in countries) {
          regionCountries.add(country);
        }

        for (var country in regionCountries) {
          for (var favCountry in favCountries) {
            if (country.cioc == favCountry.cioc) country.fav = true;
          }
        }

        regionCountries.toSet().toList();

        emit(ApiStateGetCountriesByNameAndCapital(
            isLoading: false, countries: countries));
      },
    );

    on<ApiEventGetCountriesByFavoriteAndName>(
      (event, emit) async {
        emit(const ApiStateUninitialized(isLoading: true));
        final countries = await repository.getAllCountriesByName(event.name);
        final List<CountryModel> favs = [];
        final favCountries =
            await _countryService.getFavCountries(ownerId: userId);

        for (var country in countries) {
          for (var favCountry in favCountries) {
            if (country.cioc == favCountry.cioc) {
              country.fav = true;
              favs.add(country);
            }
          }
        }
        emit(ApiStateGetCountriesByNameAndFavorite(
            isLoading: false, countries: favs));
      },
    );

    on<ApiEventGetCountriesByRegionSubregionAndCapital>(
      (event, emit) async {
        emit(const ApiStateUninitialized(isLoading: true));
        final countries = await repository.getAllCountriesByCapital(event.name);
        final regionCountries =
            await repository.getAllCountriesByRegion(event.name);
        final subCountries =
            await repository.getAllCountriesBySubregion(event.name);

        final favCountries =
            await _countryService.getFavCountries(ownerId: userId);

        for (var country in countries) {
          regionCountries.add(country);
        }
        for (var country in subCountries) {
          regionCountries.add(country);
        }

        for (var country in regionCountries) {
          for (var favCountry in favCountries) {
            if (country.cioc == favCountry.cioc) country.fav = true;
          }
        }

        regionCountries.toSet().toList();

        emit(ApiStateGetCountriesByRegionSubregionAndCapital(
            isLoading: false, countries: countries));
      },
    );

    on<ApiEventGetCountriesByRegionSubregionAndFavorite>(
      (event, emit) async {
        emit(const ApiStateUninitialized(isLoading: true));
        final countries = await repository.getAllCountriesByRegion(event.name);
        final subCountries =
            await repository.getAllCountriesBySubregion(event.name);
        final List<CountryModel> favs = [];
        final favCountries =
            await _countryService.getFavCountries(ownerId: userId);

        for (var country in subCountries) {
          countries.add(country);
        }

        countries.toSet().toList();

        for (var country in countries) {
          for (var favCountry in favCountries) {
            if (country.cioc == favCountry.cioc) {
              country.fav = true;
              favs.add(country);
            }
          }
        }
        emit(ApiStateGetCountriesByRegionSubregionAndFavorite(
            isLoading: false, countries: favs));
      },
    );

    on<ApiEventGetCountriesByRegionSubregionAndName>(
      (event, emit) async {
        emit(const ApiStateUninitialized(isLoading: true));
        final countries = await repository.getAllCountriesByName(event.name);
        final regionCountries =
            await repository.getAllCountriesByRegion(event.name);
        final subCountries =
            await repository.getAllCountriesBySubregion(event.name);

        final favCountries =
            await _countryService.getFavCountries(ownerId: userId);

        for (var country in countries) {
          regionCountries.add(country);
        }
        for (var country in subCountries) {
          regionCountries.add(country);
        }

        for (var country in regionCountries) {
          for (var favCountry in favCountries) {
            if (country.cioc == favCountry.cioc) country.fav = true;
          }
        }

        regionCountries.toSet().toList();

        emit(ApiStateGetCountriesByRegionSubregionAndName(
            isLoading: false, countries: countries));
      },
    );

    on<ApiEventGetCountriesByRegionCapitalAndFavorite>(
      (event, emit) async {
        emit(const ApiStateUninitialized(isLoading: true));
        final countries = await repository.getAllCountriesByRegion(event.name);
        final subCountries =
            await repository.getAllCountriesByCapital(event.name);
        final List<CountryModel> favs = [];
        final favCountries =
            await _countryService.getFavCountries(ownerId: userId);

        for (var country in subCountries) {
          countries.add(country);
        }

        countries.toSet().toList();

        for (var country in countries) {
          for (var favCountry in favCountries) {
            if (country.cioc == favCountry.cioc) {
              country.fav = true;
              favs.add(country);
            }
          }
        }
        emit(ApiStateGetCountriesByRegionCapitalAndFavorite(
            isLoading: false, countries: favs));
      },
    );

    on<ApiEventGetCountriesByRegionCapitalAndName>(
      (event, emit) async {
        emit(const ApiStateUninitialized(isLoading: true));
        final countries = await repository.getAllCountriesByCapital(event.name);
        final regionCountries =
            await repository.getAllCountriesByRegion(event.name);
        final subCountries = await repository.getAllCountriesByName(event.name);

        final favCountries =
            await _countryService.getFavCountries(ownerId: userId);

        for (var country in countries) {
          regionCountries.add(country);
        }
        for (var country in subCountries) {
          regionCountries.add(country);
        }

        for (var country in regionCountries) {
          for (var favCountry in favCountries) {
            if (country.cioc == favCountry.cioc) country.fav = true;
          }
        }

        regionCountries.toSet().toList();

        emit(ApiStateGetCountriesByRegionCapitalAndName(
            isLoading: false, countries: countries));
      },
    );

    on<ApiEventGetCountriesByRegionFavoriteAndName>(
      (event, emit) async {
        emit(const ApiStateUninitialized(isLoading: true));
        final countries = await repository.getAllCountriesByRegion(event.name);
        final subCountries = await repository.getAllCountriesByName(event.name);
        final List<CountryModel> favs = [];
        final favCountries =
            await _countryService.getFavCountries(ownerId: userId);

        for (var country in subCountries) {
          countries.add(country);
        }

        countries.toSet().toList();

        for (var country in countries) {
          for (var favCountry in favCountries) {
            if (country.cioc == favCountry.cioc) {
              country.fav = true;
              favs.add(country);
            }
          }
        }
        emit(ApiStateGetCountriesByRegionFavoriteAndName(
            isLoading: false, countries: favs));
      },
    );

    on<ApiEventGetCountriesBySubregionCapitalAndFavorite>(
      (event, emit) async {
        emit(const ApiStateUninitialized(isLoading: true));
        final countries = await repository.getAllCountriesByCapital(event.name);
        final subCountries =
            await repository.getAllCountriesBySubregion(event.name);
        final List<CountryModel> favs = [];
        final favCountries =
            await _countryService.getFavCountries(ownerId: userId);

        for (var country in subCountries) {
          countries.add(country);
        }

        countries.toSet().toList();

        for (var country in countries) {
          for (var favCountry in favCountries) {
            if (country.cioc == favCountry.cioc) {
              country.fav = true;
              favs.add(country);
            }
          }
        }
        emit(ApiStateGetCountriesBySubregionCapitalAndFavorite(
            isLoading: false, countries: favs));
      },
    );

    on<ApiEventGetCountriesBySubregionCapitalAndName>(
      (event, emit) async {
        emit(const ApiStateUninitialized(isLoading: true));
        final countries = await repository.getAllCountriesByCapital(event.name);
        final regionCountries =
            await repository.getAllCountriesByName(event.name);
        final subCountries =
            await repository.getAllCountriesBySubregion(event.name);

        final favCountries =
            await _countryService.getFavCountries(ownerId: userId);

        for (var country in countries) {
          regionCountries.add(country);
        }
        for (var country in subCountries) {
          regionCountries.add(country);
        }

        for (var country in regionCountries) {
          for (var favCountry in favCountries) {
            if (country.cioc == favCountry.cioc) country.fav = true;
          }
        }

        regionCountries.toSet().toList();

        emit(ApiStateGetCountriesBySubregionCapitalAndName(
            isLoading: false, countries: countries));
      },
    );

    on<ApiEventGetCountriesBySubregionFavoriteAndName>(
      (event, emit) async {
        emit(const ApiStateUninitialized(isLoading: true));
        final countries = await repository.getAllCountriesByName(event.name);
        final subCountries =
            await repository.getAllCountriesBySubregion(event.name);
        final List<CountryModel> favs = [];
        final favCountries =
            await _countryService.getFavCountries(ownerId: userId);

        for (var country in subCountries) {
          countries.add(country);
        }

        countries.toSet().toList();

        for (var country in countries) {
          for (var favCountry in favCountries) {
            if (country.cioc == favCountry.cioc) {
              country.fav = true;
              favs.add(country);
            }
          }
        }
        emit(ApiStateGetCountriesBySubregionAndFavorite(
            isLoading: false, countries: favs));
      },
    );

    on<ApiEventGetCountriesByCapitalFavoriteAndName>(
      (event, emit) async {
        emit(const ApiStateUninitialized(isLoading: true));
        final countries = await repository.getAllCountriesByCapital(event.name);
        final subCountries = await repository.getAllCountriesByName(event.name);
        final List<CountryModel> favs = [];
        final favCountries =
            await _countryService.getFavCountries(ownerId: userId);

        for (var country in subCountries) {
          countries.add(country);
        }

        countries.toSet().toList();

        for (var country in countries) {
          for (var favCountry in favCountries) {
            if (country.cioc == favCountry.cioc) {
              country.fav = true;
              favs.add(country);
            }
          }
        }
        emit(ApiStateGetCountriesByCapitalFavoriteAndName(
            isLoading: false, countries: favs));
      },
    );

    on<ApiEventGetCountriesByRegionSubregionCapitalAndFavorite>(
      (event, emit) async {
        emit(const ApiStateUninitialized(isLoading: true));
        final countries = await repository.getAllCountriesByRegion(event.name);
        final subCountries =
            await repository.getAllCountriesBySubregion(event.name);
        final capCountries =
            await repository.getAllCountriesByCapital(event.name);
        final List<CountryModel> favs = [];
        final favCountries =
            await _countryService.getFavCountries(ownerId: userId);

        for (var country in subCountries) {
          countries.add(country);
        }
        for (var country in capCountries) {
          countries.add(country);
        }

        countries.toSet().toList();

        for (var country in countries) {
          for (var favCountry in favCountries) {
            if (country.cioc == favCountry.cioc) {
              country.fav = true;
              favs.add(country);
            }
          }
        }
        emit(ApiStateGetCountriesByRegionSubregionCapitalAndFavorite(
            isLoading: false, countries: favs));
      },
    );

    on<ApiEventGetCountriesByRegionSubregionCapitalAndName>(
      (event, emit) async {
        emit(const ApiStateUninitialized(isLoading: true));
        final countries = await repository.getAllCountriesByCapital(event.name);
        final regionCountries =
            await repository.getAllCountriesByRegion(event.name);
        final subCountries =
            await repository.getAllCountriesBySubregion(event.name);
        final nameCountries =
            await repository.getAllCountriesByName(event.name);

        final favCountries =
            await _countryService.getFavCountries(ownerId: userId);

        for (var country in countries) {
          regionCountries.add(country);
        }
        for (var country in subCountries) {
          regionCountries.add(country);
        }
        for (var country in nameCountries) {
          regionCountries.add(country);
        }

        for (var country in regionCountries) {
          for (var favCountry in favCountries) {
            if (country.cioc == favCountry.cioc) {
              country.fav = true;
            }
          }
        }

        regionCountries.toSet().toList();

        emit(ApiStateGetCountriesByRegionSubregionCapitalAndName(
            isLoading: false, countries: countries));
      },
    );

    on<ApiEventGetCountriesByRegionSubregionFavoriteAndName>(
      (event, emit) async {
        emit(const ApiStateUninitialized(isLoading: true));
        final countries = await repository.getAllCountriesByRegion(event.name);
        final subCountries =
            await repository.getAllCountriesBySubregion(event.name);
        final nameCountries =
            await repository.getAllCountriesByName(event.name);
        final List<CountryModel> favs = [];
        final favCountries =
            await _countryService.getFavCountries(ownerId: userId);

        for (var country in subCountries) {
          countries.add(country);
        }
        for (var country in nameCountries) {
          countries.add(country);
        }

        countries.toSet().toList();

        for (var country in countries) {
          for (var favCountry in favCountries) {
            if (country.cioc == favCountry.cioc) {
              country.fav = true;
              favs.add(country);
            }
          }
        }
        emit(ApiStateGetCountriesByRegionSubregionFavoriteAndName(
            isLoading: false, countries: favs));
      },
    );

    on<ApiEventGetCountriesByRegionCapitalFavoriteAndName>(
      (event, emit) async {
        emit(const ApiStateUninitialized(isLoading: true));
        final countries = await repository.getAllCountriesByRegion(event.name);
        final subCountries =
            await repository.getAllCountriesByCapital(event.name);
        final nameCountries =
            await repository.getAllCountriesByName(event.name);
        final List<CountryModel> favs = [];
        final favCountries =
            await _countryService.getFavCountries(ownerId: userId);

        for (var country in subCountries) {
          countries.add(country);
        }
        for (var country in nameCountries) {
          countries.add(country);
        }

        countries.toSet().toList();

        for (var country in countries) {
          for (var favCountry in favCountries) {
            if (country.cioc == favCountry.cioc) {
              country.fav = true;
              favs.add(country);
            }
          }
        }
        emit(ApiStateGetCountriesByRegionCapitalFavoriteAndName(
            isLoading: false, countries: favs));
      },
    );

    on<ApiEventGetCountriesBySubregionCapitalFavoriteAndName>(
      (event, emit) async {
        emit(const ApiStateUninitialized(isLoading: true));
        final countries = await repository.getAllCountriesByCapital(event.name);
        final subCountries =
            await repository.getAllCountriesBySubregion(event.name);
        final nameCountries =
            await repository.getAllCountriesByName(event.name);
        final List<CountryModel> favs = [];
        final favCountries =
            await _countryService.getFavCountries(ownerId: userId);

        for (var country in subCountries) {
          countries.add(country);
        }
        for (var country in nameCountries) {
          countries.add(country);
        }

        countries.toSet().toList();

        for (var country in countries) {
          for (var favCountry in favCountries) {
            if (country.cioc == favCountry.cioc) {
              country.fav = true;
              favs.add(country);
            }
          }
        }
        emit(ApiStateGetCountriesBySubregionCapitalFavoriteAndName(
            isLoading: false, countries: favs));
      },
    );

    on<ApiEventGetCountriesByAll>(
      (event, emit) async {
        emit(const ApiStateUninitialized(isLoading: true));
        final countries = await repository.getAllCountriesByRegion(event.name);
        final subCountries =
            await repository.getAllCountriesBySubregion(event.name);
        final nameCountries =
            await repository.getAllCountriesByName(event.name);
        final capCountries =
            await repository.getAllCountriesByCapital(event.name);
        final List<CountryModel> favs = [];
        final favCountries =
            await _countryService.getFavCountries(ownerId: userId);

        for (var country in subCountries) {
          countries.add(country);
        }
        for (var country in nameCountries) {
          countries.add(country);
        }
        for (var country in capCountries) {
          countries.add(country);
        }

        countries.toSet().toList();

        for (var country in countries) {
          for (var favCountry in favCountries) {
            if (country.cioc == favCountry.cioc) {
              country.fav = true;
              favs.add(country);
            }
          }
        }
        emit(ApiStateGetCountriesByAll(isLoading: false, countries: favs));
      },
    );
  }
}
