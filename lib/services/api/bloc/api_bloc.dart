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
  }
}
