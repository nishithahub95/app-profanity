import 'package:demo_app/Data/Network/base_apiservices.dart';
import 'package:demo_app/Data/Network/network_apiservices.dart';
import 'package:demo_app/Model/Profanity.dart';
import 'package:demo_app/Resources/app_url.dart';

class HomeRepository{
  BaseApiServices _apiServices=NetworkApiServices();
  Future<Profanity>checkProfanity(dynamic data)async{
    var header={
      'content-type': 'application/json',
      'X-RapidAPI-Key': '006631c456msh4acde912b455564p12f1d5jsn73c7ea3c8205',
      'X-RapidAPI-Host': 'profanity-cleaner-bad-word-filter.p.rapidapi.com'
    };
    try{
      dynamic response=await _apiServices.getPostApiResponses(AppUrl.baseUrl,data,header);
      return response=Profanity.fromJson(response);

    }catch(e){
      throw e;
    }

  }
  Future<dynamic>checkNudity(dynamic data)async{
    var header={
      'content-type': 'application/json',
      'X-RapidAPI-Key': '006631c456msh4acde912b455564p12f1d5jsn73c7ea3c8205',
      'X-RapidAPI-Host': 'nsfw-detection1.p.rapidapi.com'
    };
    try{
      dynamic response=await _apiServices.getPostApiResponses(AppUrl.imagebaseUrl,data,header);
      //print(response);
      return response;

    }catch(e){
      throw e;
    }

  }
}