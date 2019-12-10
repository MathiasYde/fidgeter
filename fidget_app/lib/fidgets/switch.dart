import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SwitchFidget extends StatefulWidget {

  @override
  SwitchFidgetState createState() => SwitchFidgetState();
}

class SwitchFidgetState extends State<SwitchFidget> {
  bool _value = true;
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
        child: Switch(
          value: _value,
          onChanged: (bool value) {
            setState(() {
              _value = value;
              Vibration.vibrate(duration: _duration);
            });
          },
        ),
      ),
    );
  }
}
