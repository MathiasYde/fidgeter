import 'package:flutter/material.dart';
import 'package:fidget_app/fidgets/switch.dart';
import 'package:fidget_app/fidgets/single_button.dart';
import 'package:fidget_app/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  final String title = "Single Button";

  final fidgets = [
    new Text("Single Button"),
    new Text("Switch"),
  ];

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int selectedFidgetIndex = 0;
  Widget currentBody = Settings();

  @override
  void initState() {
    defaultVariables();
    super.initState();
  }

  defaultVariables() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setInt("vibration_duration", prefs.getInt("vibration_duration") ?? 200);
  }

  getFidgetWidget(int position) {
    switch (position) {
      case 0:
        return ButtonFidget();
      case 1:
        return SwitchFidget();
      
      default:
        return Text("Error: please notify the developer with this code #A48X");
    }
  }

  onFidgetSelect(int index) {
    setState(() {
      selectedFidgetIndex = index;
    });
    currentBody = getFidgetWidget(selectedFidgetIndex);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    var drawerItems = <Widget>[];
    for (var i = 0; i < widget.fidgets.length; i++) {
      var _fidget = widget.fidgets[i];
      drawerItems.add(
        new ListTile(
          title: Text(_fidget.data),
          selected: i == selectedFidgetIndex,
          onTap: () => onFidgetSelect(i),
        )
      );
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.fidgets[selectedFidgetIndex].data),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.settings),
              tooltip: "Settings",
              onPressed: () {
                setState(() {
                  currentBody = Settings();
                });
              },
            ),
          ],
          primary: true,
        ),
        body: currentBody,
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: drawerItems,
          ),
        ),
      ),
    );
  }
}
