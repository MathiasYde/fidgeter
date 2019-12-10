import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ButtonFidget extends StatefulWidget {

  @override
  ButtonFidgetState createState() => ButtonFidgetState();
}

class ButtonFidgetState extends State<ButtonFidget> {
  int _duration = 1;

  @override
  void initState() {
    getDuration();
    super.initState();
  }

  getDuration() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    _duration = prefs.getInt("vibration_duration");
  }

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Transform.scale(
        scale: 5,
        child: FloatingActionButton(
          backgroundColor: Colors.redAccent,
          elevation: 10.0,
          onPressed: () {
            Vibration.vibrate(duration: _duration);
          },
          child: Icon(Icons.vibration),
        )
      ),
    );
  }
}
