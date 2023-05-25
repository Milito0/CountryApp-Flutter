import 'package:flutter/cupertino.dart';

@immutable
abstract class ApiEvent {
  const ApiEvent();
}

class ApiEventGetAllCountries extends ApiEvent {
  const ApiEventGetAllCountries();
}
