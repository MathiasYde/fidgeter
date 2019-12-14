import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SwitchFidget extends StatefulWidget {

  @override
  SwitchFidgetState createState() => SwitchFidgetState();
}

class SwitchFidgetState extends State<SwitchFidget> {
  bool _value = true;
  bool _vibrate = true;
  bool _sound = false;
  int _duration = 1;

  @override
  void initState() {
    getPrefs();
    super.initState();
  }

  getPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    _duration = prefs.getInt("vibration_duration");
    _vibrate = prefs.getBool("enable_vibration");
    _sound = prefs.getBool("enable_sound");
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
              if (_vibrate) { Vibration.vibrate(duration: _duration); }
              if (_sound) {}
            });
          },
        ),
      ),
    );
  }
}
