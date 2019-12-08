import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

class SingleButtonFidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Transform.scale(
        scale: 5,
        child: FloatingActionButton(
          backgroundColor: Colors.redAccent,
          elevation: 10.0,
          onPressed: () {
            Vibration.vibrate(duration: 100);
          },
          child: Icon(Icons.vibration),
        )
      ),
    );
  }
}
