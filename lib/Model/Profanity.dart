import 'dart:convert';
/// clean : "What is this xxxx. You have to do better than that."
/// language : "en"
/// profanities : ["shit"]

Profanity profanityFromJson(String str) => Profanity.fromJson(json.decode(str));
String profanityToJson(Profanity data) => json.encode(data.toJson());
class Profanity {
  Profanity({
      String? clean, 
      String? language, 
      List<String>? profanities,}){
    _clean = clean;
    _language = language;
    _profanities = profanities;
}

  Profanity.fromJson(dynamic json) {
    _clean = json['clean'];
    _language = json['language'];
    _profanities = json['profanities'] != null ? json['profanities'].cast<String>() : [];
  }
  String? _clean;
  String? _language;
  List<String>? _profanities;
Profanity copyWith({  String? clean,
  String? language,
  List<String>? profanities,
}) => Profanity(  clean: clean ?? _clean,
  language: language ?? _language,
  profanities: profanities ?? _profanities,
);
  String? get clean => _clean;
  String? get language => _language;
  List<String>? get profanities => _profanities;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['clean'] = _clean;
    map['language'] = _language;
    map['profanities'] = _profanities;
    return map;
  }

}