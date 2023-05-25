import 'package:country_app/services/api/bloc/api_event.dart';
import 'package:country_app/services/api/bloc/api_state.dart';
import 'package:country_app/services/api/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApiBloc extends Bloc<ApiEvent, ApiState> {
  ApiBloc(Repository repository)
      : super(const ApiStateUninitialized(isLoading: true)) {
    on<ApiEventGetAllCountries>(
      (event, emit) async {
        final countries = await repository.getCountries();
        emit(ApiStateGetAllCountries(isLoading: true, countries: countries));
      },
    );
  }
}
