import 'dart:async';
import 'dart:convert';

import 'package:ezcountries/events/country_event.dart';

import '../models/country_model.dart';
import '../services/api.dart';

// Country bloc to fetch list of countries and render to UI

class CountryBloc {
  final Api _api = Api();
  List<Countries> _countries = [];
  final List<Countries> _filteredCountries = [];

  final _countryStateController = StreamController<List<Countries>>.broadcast();

  StreamSink<List<Countries>>? get _inCountry => _countryStateController.sink;

  Stream<List<Countries>>? get countries =>
      _countryStateController.stream.asBroadcastStream();

  final _countryEventController = StreamController<CountryEvent>();

  Sink<CountryEvent> get countryEventSink => _countryEventController.sink;

  CountryBloc() {
    _countryEventController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(CountryEvent event) {
    if (event is GetCountriesEvent) {
      getListOfCountries();
    }
  }

  // get list of countries to UI

  Future getListOfCountries() async {
    _countries.clear();
    final result = await _api.getCountries();
    final decode = jsonDecode(result);

    CountryModel country = CountryModel.fromJson(decode);
    _countries = country.countries!;
    _countries.sort((a, b) => a.name!.compareTo(b.name!));
    _inCountry!.add(_countries);
  }

  // filter list

  Future filterListCountries(String keyword) async {
    if (keyword.trim().isEmpty) {
      getListOfCountries();
    } else {
      _filteredCountries.clear();
      _inCountry!.add([]);
      List<Countries> _tempCountries = [];
      _tempCountries.addAll(_countries);
      for (var v in _tempCountries) {
        for (var l in v.languages!) {
          if (l.name!.toLowerCase().contains(keyword.toLowerCase())) {
            _filteredCountries.add(v);
          }
        }
      }
      _inCountry!.add(_filteredCountries);
    }
  }

  void dispose() {
    _countryEventController.close();
    _countryStateController.close();
  }
}
