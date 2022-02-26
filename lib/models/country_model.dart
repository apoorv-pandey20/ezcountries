// Model class of a single country item representing how our data looks and parsing the data
class CountryModel {
  CountryModel({
    this.typename,
    this.countries,
  });

  CountryModel.fromJson(dynamic json) {
    typename = json['__typename'];
    if (json['countries'] != null) {
      countries = [];
      json['countries'].forEach((v) {
        countries?.add(Countries.fromJson(v));
      });
    }
  }

  String? typename;
  List<Countries>? countries;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['__typename'] = typename;
    if (countries != null) {
      map['countries'] = countries?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Countries {
  Countries({
    this.typename,
    this.emoji,
    this.name,
    this.continent,
    this.phone,
    this.currency,
    this.languages,
  });

  Countries.fromJson(dynamic json) {
    typename = json['__typename'];
    emoji = json['emoji'];
    name = json['name'];
    continent = json['continent'] != null
        ? Continent.fromJson(json['continent'])
        : null;
    phone = json['phone'];
    currency = json['currency'];
    if (json['languages'] != null) {
      languages = [];
      json['languages'].forEach((v) {
        languages?.add(Languages.fromJson(v));
      });
    }
  }

  String? typename;
  String? emoji;
  String? name;
  Continent? continent;
  String? phone;
  String? currency;
  List<Languages>? languages;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['__typename'] = typename;
    map['emoji'] = emoji;
    map['name'] = name;
    if (continent != null) {
      map['continent'] = continent?.toJson();
    }
    map['phone'] = phone;
    map['currency'] = currency;
    if (languages != null) {
      map['languages'] = languages?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Languages {
  Languages({
    this.typename,
    this.name,
  });

  Languages.fromJson(dynamic json) {
    typename = json['__typename'];
    name = json['name'];
  }

  String? typename;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['__typename'] = typename;
    map['name'] = name;
    return map;
  }
}

class Continent {
  Continent({
    this.typename,
    this.name,
  });

  Continent.fromJson(dynamic json) {
    typename = json['__typename'];
    name = json['name'];
  }

  String? typename;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['__typename'] = typename;
    map['name'] = name;
    return map;
  }
}
