import 'dart:ffi';
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingElement {
  String title;
  IconData icon;
  String variable;
  var value;
  String unit;
  SettingElement(this.title, this.variable, this.value,
      {this.icon = null, this.unit = ""});
}

class Settings extends StatefulWidget {
  final settingElements = [
    SettingElement("Enable vibration", "enable_vibration", true, icon: Icons.vibration),
    SettingElement("Vibration duration", "vibration_duration", 100, unit: "ms"),
    SettingElement("Enable sound", "enable_sound", false, icon: Icons.surround_sound),
  ];

  @override
  SettingsState createState() => SettingsState();
}

class SettingsState extends State<Settings> {
  void onSettingElementTap(int index) {
    print(index);
  }

  Future _buildSettingElement(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var _setting = widget.settingElements[index];
    Widget _trailing;

    //Change the trailing widget to a checkbox if _setting.value is bool
    if (_setting.value is bool) {
      _trailing = Checkbox(
        value: prefs.getBool(_setting.variable),
        onChanged: (bool value) {
          setState(() {
            widget.settingElements[index].value = value;
            prefs.setBool(_setting.variable, value);
          });
        },
      );
    }

    //Change the trailing widget to a TextFormField if _setting.value is int
    if (_setting.value is int) {
      _trailing = Container(
        width: 60.0,
        child: TextFormField(
          initialValue: prefs.getInt(_setting.variable).toString(),
          keyboardType: TextInputType.number,
          onFieldSubmitted: (value) async {
            var _value = int.parse(value);

            if (_value <= 0) { _value = 1; }
            await prefs.setInt(_setting.variable, _value);
          },
        ),
      );
    }

    return {
      "leading": _setting.icon,
      "trailing": _trailing,
      "title": _setting.title,
      "onTap": () => onSettingElementTap(index),
    };
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.settingElements.length,
      itemBuilder: (context, index) {
        return FutureBuilder(
          initialData: {"title":"","leading":null,"trailing":Text("")},
          future: _buildSettingElement(index),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.active:
              case ConnectionState.waiting:
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return Text(
                      "An error occured, please notify the developer with this code #DU38");
                }

                var data = snapshot.data;

                return ListTile(
                  title: Text(data["title"]) ?? null,
                  leading: Icon(data["leading"]) ?? null,
                  trailing: data["trailing"] ?? null,
                );
            }
          },
        );
      },
    );
  }
}
