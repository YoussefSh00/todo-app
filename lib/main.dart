import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/screen.dart';
import 'package:todo/sql.dart';

void main(){
  runApp(ChangeNotifierProvider(
    create: (context) => Sql(),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Screen(),
    ),
  ));
}