

import 'package:demo_app/Data/Response/api_responses.dart';
import 'package:demo_app/Model/Profanity.dart';
import 'package:demo_app/Repository/home_repository.dart';
import 'package:flutter/material.dart';

class HomeViewModel with ChangeNotifier{
  final _myRepo=HomeRepository();
  ApiResponses<Profanity>profanityWord=ApiResponses.loading();
  findProfanity(ApiResponses<Profanity>responses){
    profanityWord=responses;
    print(profanityWord.data?.clean.toString());
    notifyListeners();
  }
  findNudity(ApiResponses apiResponses) {
   var nudityScore=apiResponses;
   print(nudityScore.data.toString());
   notifyListeners();
  }

  Future<void>findProfanityApi(dynamic data)async{
    findProfanity(ApiResponses.loading());
    _myRepo.checkProfanity(data).then((value) {
      findProfanity(ApiResponses.completed(value));
    }).onError((error, stackTrace){
      findProfanity(ApiResponses.error(error.toString()));
    });

  }
  Future<void>findNudityApi(dynamic data)async{
    //print(data);
    findNudity(ApiResponses.loading());
    _myRepo.checkNudity(data).then((value) {
     // print(value);
      findNudity(ApiResponses.completed(value));
    }).onError((error, stackTrace){
      findNudity(ApiResponses.error(error.toString()));
    });

  }


}