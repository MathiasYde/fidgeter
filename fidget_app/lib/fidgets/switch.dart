import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

class SwitchFidget extends StatefulWidget {
  @override
  SwitchFidgetState createState() => SwitchFidgetState();
}

class SwitchFidgetState extends State<SwitchFidget> {
  bool _value = true;

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
              Vibration.vibrate(duration: 100);
            });
          },
        ),
      ),
    );
  }
}
