import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SettingScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("Settings"),),
      body: Settings()
    );
  }
}
class Settings extends StatefulWidget {
 const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}


class _SettingsState extends State<Settings> {
  TextStyle textStyle =const TextStyle(fontSize: 24);
  SharedPreferences? prefs;
   
  TextEditingController? txtWork;
  TextEditingController? txtShort;
  TextEditingController? txtLong;


  static const String WORKTIME = "workTime";
  static const String SHORTBREAK = "shortBreak";
  static const String LONGBREAK = "longBreak";

  int? workTime;
  int? shortBreak;
  int? longBreak;


  @override
  void initState() {
    txtWork = TextEditingController();
    txtShort = TextEditingController();
    txtLong = TextEditingController();
    readSettings();
    super.initState();
  }

  
  
  @override
  Widget build(BuildContext context) {
    return  Container(
      child: GridView.count(
        crossAxisCount: 3,
        scrollDirection: Axis.vertical,
        childAspectRatio: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        padding: const EdgeInsets.all(20.0),
        children: <Widget> [

         Text("Work",style: textStyle,),
         const Text(""),
         const Text(""),
       
          SettingsButton(Color(0xff455A64), "-", -1,WORKTIME,updateSetting),
         TextField(style: textStyle,textAlign: TextAlign.center,keyboardType: TextInputType.number,controller: txtWork,),
        SettingsButton(Color(0xff455A64), "+", 1,WORKTIME,updateSetting),

         Text("Short",style: textStyle,),
         const Text(""),
         const  Text(""),
          SettingsButton(Color(0xff455A64), "-", -1,SHORTBREAK,updateSetting),
         TextField(style: textStyle,textAlign: TextAlign.center,keyboardType: TextInputType.number,controller: txtShort,),
          SettingsButton(Color(0xff455A64), "+", 1,SHORTBREAK,updateSetting),


          Text("Long",style: textStyle,),
         const Text(""),
         const  Text(""),
          SettingsButton(Color(0xff455A64), "-", -1,LONGBREAK,updateSetting),
         TextField(style: textStyle,textAlign: TextAlign.center,keyboardType: TextInputType.number,controller: txtLong,),
          SettingsButton(Color(0xff455A64), "+", 1,LONGBREAK,updateSetting),
          
        ],),

    );
  }

  readSettings() async{
    prefs = await SharedPreferences.getInstance();
    workTime = prefs?.getInt(WORKTIME);
    if (workTime == null){
      await prefs?.setInt(WORKTIME, int.parse('30'));
    }
    longBreak = prefs?.getInt(LONGBREAK);
    if (longBreak == null){
      await prefs?.setInt(LONGBREAK, int.parse('30'));
    }
    shortBreak = prefs?.getInt(SHORTBREAK);
    if (shortBreak == null){
      await prefs?.setInt(SHORTBREAK, int.parse('30'));
    }
    setState(() {
      txtWork?.text = workTime.toString();
      txtShort?.text = shortBreak.toString();
      txtLong?.text = longBreak.toString();
    });
  }

  void updateSetting(String key,int value){
    switch(key){
      case WORKTIME:
      {
         workTime = prefs?.getInt(WORKTIME);
         workTime = (workTime??0) + value;
         if ((workTime??0) >= 1 && (workTime??0) <=180){
          prefs?.setInt(WORKTIME, (workTime??0));
          setState(() {
            txtWork?.text=(workTime??0).toString();
          });
         }

         
      }
      break;

      case SHORTBREAK:
      {
        shortBreak=prefs?.getInt(SHORTBREAK);
        shortBreak =(shortBreak ?? 0) +value;
        if ((shortBreak ?? 0) >= 1 && (shortBreak ?? 0) <=180){
          prefs?.setInt(SHORTBREAK, (shortBreak ?? 0));
          setState(() {
            txtShort?.text = (shortBreak ?? 0).toString();
          });
        }
      }
      break;

      case LONGBREAK:
      {
         longBreak = prefs?.getInt(LONGBREAK);
         longBreak = (longBreak ??0) + value;
         if((longBreak ??0)  >= 1 && (longBreak ??0) <= 180){
          prefs?.setInt(LONGBREAK,longBreak??0);


         }
         setState(() {
           txtLong?.text =(longBreak??0).toString();
         });
      }
      break;
    }
  }
}
typedef CallbackSetting = void Function(String,int);
class SettingsButton extends StatelessWidget{
  final Color colors;
  final String text;
  final int value;
  final String setting;
  final CallbackSetting callback;
 
  
const  SettingsButton(this.colors,this.text,this.value,this.setting,this.callback, {super.key});
  @override
  Widget build(BuildContext context){
    return MaterialButton(
     onPressed: ()=> callback(setting,value),
     color: colors,
     minWidth: 150,
     
     child: Text(text,style: const TextStyle(color: Colors.white,fontSize: 22),),
      )
      ;
  }
}