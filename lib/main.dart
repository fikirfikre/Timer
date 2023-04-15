import 'dart:async';

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:productivity_timer/SettingScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './timer.dart';
import './timermodel.dart';


void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  void emptymethod(){}
  final double defaultPadding = 5.0;
  final CountDownTimer timer = CountDownTimer();
  bool? active;
 
  void goToSettings(BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingScreen()));
  }



  

  @override
  Widget build(BuildContext context){
     final List<PopupMenuItem<String>> menuItems = <PopupMenuItem<String>>[];
    menuItems.add(const PopupMenuItem(value:'Settings',child: Text("Settings"),));
    timer.startWork();
        
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme:ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
    
      title: 'My work Timer',
      home: Builder(
        builder: (context) {
        

          return Scaffold(appBar: 
          AppBar(title: const Text('My Work Timer'),
          actions: [
            PopupMenuButton(itemBuilder: (context){
              
              return menuItems.toList();
            },
            onSelected: (s){
              if(s=='Settings'){
              goToSettings(context);
             
              
            }
           
  },)
          ],),
          body: LayoutBuilder(
            builder: (BuildContext context,BoxConstraints constraints) {
              final double avaliableWidth = constraints.maxWidth;

              return Container(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
               
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(padding: EdgeInsets.all(defaultPadding)),
                        Expanded(child: ProductivityButton(colors:Color(0xff009688) ,text: "Work",onPressed:()=> timer.startWork,size: 150,)),
                        Padding(padding: EdgeInsets.all(defaultPadding)),
                        Expanded(child: ProductivityButton(colors:Color(0xff607D8B) ,text: "Short Break",onPressed: ()=>timer.startBreak(true),size: 150,)),
                        Padding(padding: EdgeInsets.all(defaultPadding)),
                        Expanded(child: ProductivityButton(colors:Color(0xff455A64) ,text: "Long Break",onPressed: ()=>timer.startBreak(false),size: 150,)),
                        Padding(padding: EdgeInsets.all(defaultPadding))
                      ],
                    ),
                    StreamBuilder(
                      initialData: '00:00',
                      stream: timer.stream(),
                      builder: (BuildContext context,AsyncSnapshot snapshot) {
                        TimerModel timer =(snapshot.data == '00:00')? TimerModel('00;00', 1):snapshot.data;
                        
                        return Expanded(
                        child: CircularPercentIndicator(
                        radius: avaliableWidth / 5,
                        lineWidth: 13.0,
                        percent: timer.percent
                        ,
                        center: Text(timer.time,
                        style: Theme.of(context).textTheme.displayMedium,),
                        progressColor: Color(0xff009688),)
                        );
                      }
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(padding: EdgeInsets.all(defaultPadding)),
                        Expanded(child: ProductivityButton(colors:Color(0xff455A64) ,text: "Stop",onPressed: timer.stopWork,size: 150,)),
                        Padding(padding: EdgeInsets.all(defaultPadding)),
                        Expanded(child: ProductivityButton( colors :Color(0xff455A64),text: "Restart",onPressed:
                        
                          timer.startWork,size: 150,)
                          ),
                          
                          Padding(padding: EdgeInsets.all(defaultPadding)),
                        Expanded(child: ProductivityButton( colors :Color(0xff455A64),text: "start",onPressed:timer.start,size: 150,)
                          ),

                        Padding(padding: EdgeInsets.all(defaultPadding))
                        
                      ],
                    )
                  ],
                ),
              );
            }
          ),);
        }
      ),
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
      child:Text(text,style:const TextStyle(color: Colors.white),),
      minWidth: size,);
  }
}