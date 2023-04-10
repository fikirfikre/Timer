import 'dart:async';

import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  void emptymethod(){}
  final double defaultPadding = 5.0;

  @override
  Widget build(BuildContext context){
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme:ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
    
      title: 'My work Timer',
      home: Scaffold(appBar: 
      AppBar(title: const Text('My Work Timer'),),
      body: LayoutBuilder(
        builder: (BuildContext context,BoxConstraints constraints) {
          return Container(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
           
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(padding: EdgeInsets.all(defaultPadding)),
                    Expanded(child: ProductivityButton(colors:Color(0xff009688) ,text: "Work",onPressed: emptymethod,size: 150,)),
                    Padding(padding: EdgeInsets.all(defaultPadding)),
                    Expanded(child: ProductivityButton(colors:Color(0xff607D8B) ,text: "Short Break",onPressed: emptymethod,size: 150,)),
                    Padding(padding: EdgeInsets.all(defaultPadding)),
                    Expanded(child: ProductivityButton(colors:Color(0xff455A64) ,text: "Long Break",onPressed: emptymethod,size: 150,)),
                    Padding(padding: EdgeInsets.all(defaultPadding))
                  ],
                ),
                Text("Timer"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(padding: EdgeInsets.all(defaultPadding)),
                    Expanded(child: ProductivityButton(colors:Color(0xff455A64) ,text: "Stop",onPressed: emptymethod,size: 150,)),
                    Padding(padding: EdgeInsets.all(defaultPadding)),
                    Expanded(child: ProductivityButton(colors:Color(0xff455A64) ,text: "Restart",onPressed: emptymethod,size: 150,)),
                    Padding(padding: EdgeInsets.all(defaultPadding))
                    
                  ],
                )
              ],
            ),
          );
        }
      ),),
    );

  }
}

class TimerHomePage extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return Container();
  }
}

class ProductivityButton extends StatelessWidget{
   final Color colors;
   final String text;
   final double size;
   final  VoidCallback onPressed;

  const ProductivityButton({super.key, required this.colors,required this.text,required this.size, required this.onPressed});
  @override
  Widget build(BuildContext context){
    return MaterialButton(
      onPressed:onPressed,
      color: colors,
      child: Text(text,style:const TextStyle(color: Colors.white),),
      minWidth: size,);
  }
}