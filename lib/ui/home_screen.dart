import 'package:ezcountries/bloc/country_bloc.dart';
import 'package:ezcountries/events/country_event.dart';
import 'package:ezcountries/services/helpers.dart';
import 'package:ezcountries/ui/country_search.dart';
import 'package:flutter/material.dart';

import '../models/country_model.dart';
import '../widgets/country_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _bloc = CountryBloc();

  @override
  void initState() {
    super.initState();
    _bloc.countryEventSink.add(GetCountriesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Countries'),
        actions: [
          IconButton(
            onPressed: () => pushToNewRoute(context, const CountrySearch()),
            icon: const Icon(Icons.search),
          ),
        ],
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
                  onChanged: _filter,
                  maxLines: 1,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: "Filter",
                    prefixIcon:
                        Icon(Icons.filter_alt_outlined, color: Colors.blue),
                  ),
                ),
              ),
            ),
            preferredSize: const Size.fromHeight(64.0)),
      ),
      body: Center(
        child: StreamBuilder<List<Countries>>(
          stream: _bloc.countries,
          builder:
              (BuildContext context, AsyncSnapshot<List<Countries>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return CountryTile(country: snapshot.data![index]);
                  });
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  void _filter(String keyword) {
    _bloc.filterListCountries(keyword);
  }
}
