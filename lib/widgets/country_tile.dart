import 'package:ezcountries/models/country_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CountryTile extends StatelessWidget {
  // Country Expansion Tile for rendering single country item
  final Countries country;

  const CountryTile({Key? key, required this.country}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget continentPhoneCurrency = Container(
      margin: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Wrap(
        spacing: 15,
        runSpacing: 5,
        children: <Widget>[
          countryInfo(continentIcon(country.continent!.name!),
              country.continent!.name!),
          countryInfo(Icons.phone, country.phone!),
          country.currency != null
              ? countryInfo(MdiIcons.currencySign, country.currency!)
              : const SizedBox(),
        ],
      ),
    );

    return Card(
      child: ExpansionTile(
        leading: Text(country.emoji!, style: const TextStyle(fontSize: 24)),
        title: Text(country.name!),
        children: <Widget>[
          continentPhoneCurrency,
          const SizedBox(height: 15.0),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.0),
            child: Divider(height: 1.0),
          ),
          const SizedBox(height: 15.0),
          country.languages!.isNotEmpty ? officialLanguage() : const SizedBox(),
          country.languages!.isNotEmpty
              ? const SizedBox(height: 15.0)
              : const SizedBox(),
        ],
      ),
    );
  }

  IconData continentIcon(String continent) {
    if (continent == "Africa") {
      return FontAwesomeIcons.globeAfrica;
    } else if (continent == "Asia" || continent == "Oceania") {
      return FontAwesomeIcons.globeAsia;
    } else if (continent == "Europe") {
      return FontAwesomeIcons.globeEurope;
    } else if (continent == "North America" || continent == "South America") {
      return FontAwesomeIcons.globeAmericas;
    } else {
      return MdiIcons.earth;
    }
  }

  final double iconSize = 20.0;
  final double iconTextSpacing = 5.0;

  Widget countryInfo(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(icon, size: iconSize),
        SizedBox(width: iconTextSpacing),
        Text(text),
      ],
    );
  }

  Widget officialLanguage() {
    Widget icon = const Icon(Icons.translate, size: 20.0);
    String languages = '';
    if (country.languages!.length != 1) {
      for (var element in country.languages!) {
        languages += element.name! + ", ";
      }
    } else {
      country.languages!.isNotEmpty
          ? languages = languages = country.languages![0].name!
          : languages = '';
    }
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          icon,
          SizedBox(width: iconTextSpacing),
          Flexible(child: Text(languages)),
        ],
      ),
    );
  }
}
