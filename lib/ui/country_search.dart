import 'package:ezcountries/bloc/search_country_bloc.dart';
import 'package:ezcountries/events/country_event.dart';
import 'package:ezcountries/models/base_response.dart';
import 'package:flutter/material.dart';

import '../models/search_country_model.dart';
import '../services/helpers.dart';

class CountrySearch extends StatefulWidget {
  // Country Search UI to search the country by country code
  const CountrySearch({Key? key}) : super(key: key);

  @override
  _CountrySearchState createState() => _CountrySearchState();
}

class _CountrySearchState extends State<CountrySearch> {
  final _bloc = SearchCountryBloc();

  @override
  void initState() {
    super.initState();
    _bloc.countryEventSink.add(SearchCountriesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search By Country Code"),
        bottom: PreferredSize(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  color: Colors.white,
                ),
                child: TextFormField(
                  textAlignVertical: TextAlignVertical.center,
                  keyboardType: TextInputType.text,
                  textAlign: TextAlign.start,
                  onFieldSubmitted: _searchCountry,
                  maxLines: 1,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: "Enter country code",
                    prefixIcon:
                        Icon(Icons.search, color: Colors.blue),
                  ),
                ),
              ),
            ),
            preferredSize: const Size.fromHeight(64.0)),
      ),
      body: Center(
        child: StreamBuilder<BaseResponses<Country>>(
          stream: _bloc.countries,
          builder: (BuildContext context,
              AsyncSnapshot<BaseResponses<Country>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data?.status == Status.loading) {
                return const CircularProgressIndicator();
              } else if (snapshot.data?.status == Status.error) {
                return const SizedBox();
              } else {
                return Column(
                  children: [
                    ListTile(
                        title: Text(
                      snapshot.data!.data.name!,
                      style: const TextStyle(fontSize: 22),
                    )),
                  ],
                );
              }
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  // search country

  void _searchCountry(String keyword) {
    if (keyword.trim().isNotEmpty) {
      _bloc.searchCountryByCode(context, keyword.trim().toUpperCase());
    } else {
      showSnackBar(context, "Please enter a country code to search", 1500);
    }
  }
}
