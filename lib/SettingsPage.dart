import 'package:finance_app/ChangeThemeButtonWidget.dart';
import 'package:finance_app/Themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {

    final oppTheme = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark ? "Light" : "Dark";

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(child: Icon(Icons.format_paint_sharp, color: Theme.of(context).iconTheme.color,)),
                      WidgetSpan(child: SizedBox(width: 20.0,)),
                      WidgetSpan(child: Text("Switch to $oppTheme Theme", style: TextStyle(fontFamily: "Livvic", fontSize: 15.0),)),
                    ]
                  ),
                ),
                ChangeThemeButtonWidget(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
