import 'package:country_app/services/api/bloc/api_event.dart';
import 'package:country_app/services/api/bloc/api_state.dart';
import 'package:country_app/services/api/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApiBloc extends Bloc<ApiEvent, ApiState> {
  ApiBloc(Repository repository)
      : super(const ApiStateUninitialized(isLoading: true)) {
    on<ApiEventGetAllCountries>(
      (event, emit) async {
        emit(const ApiStateUninitialized(isLoading: true));
        final countries = await repository.getAllCountries();
        emit(ApiStateGetAllCountries(isLoading: false, countries: countries));
      },
    );

    on<ApiEventGetAllCountriesByCapital>(
      (event, emit) async {
        final countries = await repository.getAllCountriesByCapital(event.name);
        emit(ApiStateGetAllCountriesByCapital(
            isLoading: false, countries: countries));
      },
    );

    on<ApiEventGetAllCountriesByName>(
      (event, emit) async {
        final countries = await repository.getAllCountriesByName(event.name);
        emit(ApiStateGetAllCountriesByName(
            isLoading: false, countries: countries));
      },
    );

    on<ApiEventGetAllCountriesByRegion>(
      (event, emit) async {
        final countries = await repository.getAllCountriesByRegion(event.name);
        emit(ApiStateGetAllCountriesByRegion(
            isLoading: false, countries: countries));
      },
    );

    on<ApiEventGetAllCountriesBySubregion>(
      (event, emit) async {
        final countries =
            await repository.getAllCountriesBySubregion(event.name);
        emit(ApiStateGetAllCountriesBySubregion(
            isLoading: false, countries: countries));
      },
    );

    on<ApiEventGetCountry>(
      (event, emit) async {
        final country = await repository.getCountry(event.code);
        emit(ApiStateGetCountry(isLoading: false, country: country));
      },
    );
  }
}
