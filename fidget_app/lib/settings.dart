import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

class SettingElement {
  String title;
  IconData icon;
  var value;
  String unit;
  SettingElement(this.title, this.value, {this.icon = null, this.unit = ""});
}

class Settings extends StatefulWidget {
  final settingElements = [
    SettingElement("Enable vibration", true, icon: Icons.vibration),
    SettingElement("Vibration duration", 100, unit: "ms"),
    SettingElement("Enable sound", false, icon: Icons.surround_sound),
  ];

  @override
  SettingsState createState() => SettingsState();
}

class SettingsState extends State<Settings> {
  void onSettingElementTap(int index) {

  }

  @override
  Widget build(BuildContext context) {
    var _settingsElements = <Widget>[];

    for (var i = 0; i < widget.settingElements.length; i++) {
      var _setting = widget.settingElements[i];

      Widget _trailing; //= Text("${_setting.value.toString()}${_setting.unit}");
      //Change the trailing widget to a checkbox if the _setting.value is a bool
      if (_setting.value is bool) {
        _trailing = Checkbox(
          value: _setting.value,
          onChanged: (bool value) => {

          },
        );
      }

      //Change the trailing widget to a TextField if the _setting.value is a String
      if (_setting.value is String || _setting.value is int) {
        _trailing = Container(
          width: 60.0,
          child: TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'ms'
            ),
          ), 
        );
      }

      _settingsElements.add(
        new ListTile(
          leading: Icon(_setting.icon),
          title: Text(_setting.title),
          trailing: _trailing,
          onTap: () => onSettingElementTap(i),
        )
      );
    }

    return ListView(
      children: _settingsElements,
    );
  }
}
