import 'dart:convert';

///****************************************
///region Model Country
class Country {
  ///region Fields
  late String name;
  late String flag;
  late String countryCode;
  late String callingCode;

  ///endregion Fields

  ///region default constructor
  Country({required this.name, required this.flag, required this.countryCode, required this.callingCode});

  ///endregion default constructor

  ///region withFields constructor
  Country.withFields(this.name, this.flag, this.countryCode, this.callingCode);

  ///endregion withFields constructor

  ///region fromMap
  Country.fromMap(Map<String, dynamic> map) {
    name = map['name'].toString();
    flag = map['flag'].toString();
    countryCode = map['countryCode'].toString();
    callingCode = map['callingCode'].toString();
  }

  ///endregion fromMap

  ///region fromMapList
  static List<Country> fromMapList(List<Map<String, dynamic>> list) {
    return list.map((e) => Country.fromMap(e)).toList();
  }

  ///endregion fromMapList

  ///region fromJson
  Country.fromJson(String jsonInput) : this.fromMap(json.decode(jsonInput));

  ///endregion fromJson

  ///region toMap
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map['name'] = name;
    map['flag'] = flag;
    map['countryCode'] = countryCode;
    map['callingCode'] = callingCode;
    return map;
  }

  ///endregion toMap

  ///region toJson
  String toJson() => json.encode(toMap());

  ///endregion toJson

  ///region toString
  @override
  String toString() => toMap().toString();

  ///endregion toString

  ///region copyWith
  Country copyWith({String? name, String? flag, String? countryCode, String? callingCode}) {
    Country newCountry = Country.fromMap(toMap());
    if (name != null) {
      this.name = name;
    }
    if (flag != null) {
      this.flag = flag;
    }
    if (countryCode != null) {
      this.countryCode = countryCode;
    }
    if (callingCode != null) {
      this.callingCode = callingCode;
    }
    return newCountry;
  }

  ///endregion copyWith

  ///region updateFrom
  void updateFrom({required Country another}) {
    name = another.name;
    flag = another.flag;
    countryCode = another.countryCode;
    callingCode = another.callingCode;
  }

  ///endregion updateFrom
}

///endregion Model Country
