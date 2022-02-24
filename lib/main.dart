import 'package:flutter/material.dart';
import 'package:sunny/screen/loadingScreen.dart';

void main(){
  runApp(Sunny());
}

class Sunny extends StatelessWidget {
  const Sunny({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoadingScreen(),
    );

  }
}
