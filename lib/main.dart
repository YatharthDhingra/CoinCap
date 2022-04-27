import 'dart:convert'; //to use jsonDecode

import 'package:coincap/models/app_config.dart';
import 'package:coincap/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

void main() async {
  //made async as we are doing async programming here
  WidgetsFlutterBinding
      .ensureInitialized(); //makes sure that flutter app code has been set up properly
  await loadConfig();
  runApp(const MyApp());
}

Future<void> loadConfig() async {
  //load our config file in asset folder
  String _configContent =
      await rootBundle.loadString("assets\config\main.json");
  Map _configData =
      jsonDecode(_configContent); //converts it into a json object(map)
  GetIt.instance.registerSingleton<AppConfig>(
    //GET IT package is used to create singleton classes(they have only once instance in our project)
    //_configData is a json map now , so to access data , we accces it like we do in a map(key - value pair)
    AppConfig(
      COIN_API_BASE_URL: _configData["COIN_API_BASE_URL"],
    ),
  );
  //now we can access our secret data from appconfig without actually showing the value
  //also , no one can manipulate it now since config file is hidden
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CoinCap',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color.fromRGBO(88, 60, 197, 1.0),
        //changes the background on all screens of the app
      ),
      home: HomePage(),
    );
  }
}
