// Model class of a single country from search result how our data looks and parsing the data

class SearchCountryModel {
  SearchCountryModel({
    this.typename,
    this.country,
  });

  SearchCountryModel.fromJson(dynamic json) {
    typename = json['__typename'];
    country =
        json['country'] != null ? Country.fromJson(json['country']) : null;
  }

  String? typename;
  Country? country;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['__typename'] = typename;
    if (country != null) {
      map['country'] = country?.toJson();
    }
    return map;
  }
}

class Country {
  Country({
    this.typename,
    this.name,
  });

  Country.fromJson(dynamic json) {
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
