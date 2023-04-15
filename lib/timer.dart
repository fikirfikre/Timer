import 'dart:async';

import 'package:productivity_timer/timermodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CountDownTimer{
   double _radius = 1; //used to express the completed time
   bool _isActive = true; // tell us if the counter is active or not
   Timer? timer; //used to create countdown timers
   Duration? _time; //use to express the remaining time 
   Duration? _fulltime ;//express the beginning time

   int work = 30;
   int long = 20;
   int short = 5;



  
   //used to Format the outputs

   String returnTime(Duration t){

    String minutes = (t.inMinutes < 10) ? "0" + t.inMinutes.toString() : t.inMinutes.toString();
    int numSeconds = t.inSeconds -(t.inMinutes * 60);
    String seconds = (numSeconds < 10)?'0'+numSeconds.toString():numSeconds.toString();

    return minutes +":"+ seconds;
   }

   Stream<TimerModel> stream() async*{
    yield* Stream.periodic(Duration(seconds: 1),(inta){

      String? time;
      if (_isActive){
        var t=_time;

       if ( t != null){
          t= t - const Duration(seconds: 1);
        }
       _time = t;
       _radius = (_time?.inSeconds ?? 0) / (_fulltime?.inSeconds ?? 0);
        
        if((_time?.inSeconds ?? 0) <= 0){
          _isActive = false;

        }
        
      }
      time = returnTime(_time as Duration);
      return TimerModel(time, _radius);
    });
   }

   void startWork() async{
    await readSettings();
    _isActive = true;
    _radius = 1;
    _time = Duration(minutes:work,seconds: 0);
    _fulltime = _time;
   }
   void startBreak(bool isShort){
    _radius=1;
    _time =Duration(minutes: (isShort)?short:long,seconds: 0);
    _fulltime = _time;

   }

   void stopWork(){
    _isActive = false;
   }

   void start(){
    _isActive = true;
   }


    Future readSettings() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
     work = prefs.getInt('workTime') ?? 30;
     short = prefs.getInt('shortBreak') ?? 30;
     long = prefs.getInt('longBreak')??30;
  }

  
  
  
}