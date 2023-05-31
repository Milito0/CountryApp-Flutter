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
  }
}
