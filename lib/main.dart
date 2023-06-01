import 'package:demo_app/View/home_screen.dart';
import 'package:demo_app/View_Model/homeView_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>HomeViewModel())
      ],
      child: MaterialApp(

        home: HomeScreen()
      ),
    );
  }
}

