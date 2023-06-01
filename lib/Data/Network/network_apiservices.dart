import 'dart:convert';
import 'dart:io';
import 'package:demo_app/Data/Network/base_apiservices.dart';
import 'package:demo_app/Data/app_exception.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';


class NetworkApiServices extends BaseApiServices{
  @override
  Future getGetApiResponses(String url) async{

    dynamic responseJson;

    try{
      final response=await http.get(Uri.parse(url)).timeout(Duration(seconds: 10));
      responseJson=returnResponse(response);

    }on SocketException{
      //Socket exception for no internet connection
      throw FetchDataExceptions('No internet connection');
    }
    return responseJson;
  }

  @override
  Future getPostApiResponses(String url,dynamic data,dynamic header)async {
    dynamic responseJson;

    try{
      Response response=await http.post(Uri.parse(url),
          headers:header,
          body:jsonEncode(data)).timeout(Duration(seconds: 10));
      responseJson=returnResponse(response);

    }on SocketException{
      //Socket exception for no internet connection
      throw FetchDataExceptions('No internet connection');
    }
    return responseJson;
  }
  dynamic returnResponse(http.Response response){

    switch(response.statusCode){
      case 200:
        dynamic responseJson=jsonDecode(response.body);
       // print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestExceptions(response.statusCode.toString());
      case 404:
        throw UnauthorisedExceptions(response.statusCode.toString());

      default:
        throw FetchDataExceptions('Error occurred during communicating with server with statuscode' + response.statusCode.toString());
    }

  }

}