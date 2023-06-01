import 'dart:io';

import 'package:demo_app/Data/Response/status.dart';
import 'package:demo_app/Repository/home_repository.dart';
import 'package:demo_app/Resources/Component/round_button.dart';
import 'package:demo_app/Utils/utils.dart';
import 'package:demo_app/View_Model/homeView_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController typingController=TextEditingController();
  HomeViewModel homeViewModel=HomeViewModel();
  bool loading=false;
  File? _image;
  final picker=ImagePicker();
  Future getGallaryImage()async{

    final pickedFile = await picker.pickImage(source: ImageSource.gallery , imageQuality: 80);
    setState(() {
      if(pickedFile != null){
        _image = File(pickedFile.path);
      }else {
        print('no image picked');
      }
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: typingController,
              style: TextStyle(color: Colors.black),
              cursorColor: Colors.white,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.black)),
                prefixIcon: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Icon( Icons.text_fields,
                    )),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30)),
                hintText: 'Enter your Post',
                hintStyle: TextStyle(color: Colors.black),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.black)),
              ),
            ),
            SizedBox(height: 20,),
            RoundButton(
                title: 'Post', onPress:(){
                  if(typingController.text.isEmpty){
                    Utils.flushbarErrorMessage('Enter Post', context);
                  }else{
                    Map data={
                      "text":typingController.text.toString(),
                      "maskCharacter": "x",
                      "language": "en"
                    };
                    homeViewModel.findProfanityApi(data);
                  }

            }),
            Text('You cannot use a profanity in your post'),
            ChangeNotifierProvider<HomeViewModel>(
              create: (BuildContext context)=>homeViewModel,
              child: Consumer<HomeViewModel>(builder: (context,value,_){

                switch(value.profanityWord.status) {
                  case Status.LOADING:
                    return Center(child: CircularProgressIndicator());
                  case Status.ERROR:
                    return Center(child: Text(value.profanityWord.message.toString()));
                  case Status.COMPLETED:
                    return Text('The profanity word is:  '+value.profanityWord.data!.profanities![0].toString());

                }
                return Container(

                );
              },),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: (){
                getGallaryImage();
              },
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.black
                    )
                ),
                child: _image != null ? Image.file(_image!.absolute) :     //Show the image in front end
                Center(child: Icon(Icons.image)),
              ),
            ),
            SizedBox(height: 20,),
            RoundButton(title: 'Upload', onPress: (){
              print(_image);
              Map data1=  {
                //"url":_image.toString()
                "url": "https://upload.wikimedia.org/wikipedia/commons/thumb/3/33/Tom_Cruise_by_Gage_Skidmore_2.jpg/476px-Tom_Cruise_by_Gage_Skidmore_2.jpg"
            };
              homeViewModel.findNudityApi(data1);
            }


            ),



          ],
        ),
      ),

    );
  }
}
