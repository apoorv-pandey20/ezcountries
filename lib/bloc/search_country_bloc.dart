import 'dart:async';
import 'dart:convert';

import 'package:ezcountries/models/base_response.dart';
import 'package:ezcountries/models/search_country_model.dart';
import 'package:flutter/material.dart';

import '../events/country_event.dart';
import '../services/api.dart';
import '../services/helpers.dart';

// Country search bloc to search countries and render list to UI

class SearchCountryBloc {
  final Api _api = Api();
  late Country _country;

  final _countryStateController =
      StreamController<BaseResponses<Country>>.broadcast();

  StreamSink<BaseResponses<Country>>? get _inCountry =>
      _countryStateController.sink;

  Stream<BaseResponses<Country>>? get countries =>
      _countryStateController.stream.asBroadcastStream();
  final _countryEventController = StreamController<CountryEvent>();

  Sink<CountryEvent> get countryEventSink => _countryEventController.sink;

  SearchCountryBloc() {
    _countryEventController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(CountryEvent event) {}

  // Fetch response from API
  Future searchCountryByCode(BuildContext context, String countryCode) async {
    _inCountry!.add(BaseResponses.loading('Processing...'));
    final result = await _api.getCountryByCode(code: countryCode);

    final decode = jsonDecode(result);
    if (decode['country'] != null) {
      SearchCountryModel country = SearchCountryModel.fromJson(decode);
      _country = country.country!;
      _inCountry!.add(BaseResponses.completed(_country));
    } else {
      _inCountry!.add(BaseResponses.error(decode.toString()));
      showSnackBar(context, "Country code doesn't exists!", 1500);
    }
  }
}
