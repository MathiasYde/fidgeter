import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SingleButton(),
    );
  }
}

class SingleButton extends StatefulWidget {
  final String title = "Single Button";

  @override
  SingleButtonState createState() => SingleButtonState();
}

class SingleButtonState extends State<SingleButton> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.menu),
            tooltip: "Menu",
            onPressed: (){},
          ),
          title: Text(widget.title),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.settings),
              tooltip: "Settings",
              onPressed: () {},
            ),
          ],
          primary: true,
        ),
        body: Center(
          child: Transform.scale(
            scale: 5,
            child: FloatingActionButton(
              backgroundColor: Colors.redAccent,
              elevation: 0,
              onPressed: () { Vibration.vibrate(duration: 100); },
              child: Icon(Icons.vibration),
            )
          ),
        ),
      ),
    );
  }
}
