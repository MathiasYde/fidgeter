import 'package:flutter/material.dart';
import 'package:fidget_app/fidgets/switch.dart';
import 'package:fidget_app/fidgets/single_button.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class DrawerItem {
  String title;
  DrawerItem(this.title);
}

class HomePage extends StatefulWidget {
  final String title = "Single Button";

  final fidgets = [
    new DrawerItem("Single Button"),
    new DrawerItem("Switch"),
  ];

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _selectedFidget = 0;

  getDrawerItemWidget(int position) {
    switch (position) {
      case 0:
        return SingleButtonFidget();
      case 1:
        return SwitchFidget();
      
      default:
        return Text("Error: please notify the developer with this code #A48X");
    }
  }

  onSelectItem(int index) {
    setState(() => _selectedFidget = index);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    var drawerItems = <Widget>[];
    for (var i = 0; i < widget.fidgets.length; i++) {
      var _fidget = widget.fidgets[i];
      drawerItems.add(
        new ListTile(
          title: Text(_fidget.title),
          selected: i == _selectedFidget,
          onTap: () => onSelectItem(i),
        )
      );
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.fidgets[_selectedFidget].title),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.settings),
              tooltip: "Settings",
              onPressed: () {},
            ),
          ],
          primary: true,
        ),
        body: getDrawerItemWidget(_selectedFidget),
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
