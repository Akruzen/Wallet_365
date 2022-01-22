import 'package:finance_app/3buttons.dart';
import 'package:finance_app/AboutPage.dart';
import 'package:finance_app/AddBalanceDialog.dart';
import 'package:finance_app/MainScreen.dart';
import 'package:finance_app/SetSalaryDialog.dart';
import 'package:finance_app/SettingsPage.dart';
import 'package:finance_app/SplitterPage.dart';
import 'package:finance_app/Themes.dart';
import 'package:finance_app/analytics.dart';
import 'package:finance_app/bar_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

import 'Transactions.dart';



void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter(); //initialize the hive
  Hive.registerAdapter(needsTransactionAdapter());
  Hive.registerAdapter(miscellaneousTransactionAdapter());
  Hive.registerAdapter(healthCareTransactionAdapter());


  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(ChangeNotifierProvider(
    create: (context) => ThemeProvider(isDarkMode: prefs.getBool("isDarkTheme") ?? true),
    builder: (context, _) {
      final themeProvider = Provider.of<ThemeProvider>(context);
      return MaterialApp(
          themeMode:themeProvider.themeMode,
          theme: MyThemes.lightTheme,
          darkTheme: MyThemes.darkTheme,
          home: Home()
      );
    }
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<bool> isSelected = List.generate(2, (_) => false);
  var currentBalance = 0;
  String username = "";
  String currBalKey = "currentBalanceInt";

  _HomeState() {
    loadStringData("currUsername");
  }

  void updateBalance (int x) {
    setState(() {
      currentBalance = x;
      saveIntData(currBalKey, x);
    });
  }

  // To save integers in shared preferences
  void saveIntData(String key, int value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, value);
  }

  // To load the saved integers in shared preferences
  void loadValues(String name) async {
    final prefs = await SharedPreferences.getInstance();
    int x = prefs.getInt(name) ?? 0;
    setState(() {
      currentBalance = x;
    });
  }

  // To load the saved integers in shared preferences
  void loadStringData(String name) async {
    final prefs = await SharedPreferences.getInstance();
    String x = prefs.getString(name) ?? "User";
    setState(() {
      username = ",\n" + x;
    });
  }

  Widget build(BuildContext context) {
    loadValues(currBalKey);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          "Finance App",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        //backgroundColor: Colors.deepPurple[500],
      ),
      floatingActionButton: MainAction(),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Text(
                  "Options",
                style: TextStyle(
                  fontFamily: "Livvic",
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  letterSpacing: 2.0,
                ),
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/drawer_back.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            ListTile(
              title: Text(
                "Cash Splitter",
                style: TextStyle(
                  fontFamily: "Livvic",
                  color: Theme.of(context).primaryColor,
                ),
              ),
              leading: Icon(Icons.attach_money_sharp, color: Theme.of(context).iconTheme.color,),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => SplitterPage()));
              },
            ),
            ListTile(
              title: Text(
                "Analytics",
                style: TextStyle(
                  fontFamily: "Livvic",
                  color: Theme.of(context).primaryColor,
                ),
              ),
              leading: Icon(Icons.stacked_line_chart, color: Theme.of(context).iconTheme.color,),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => analysis()));
              },
            ),
            ListTile(
              title: Text(
                "Categories",
                style: TextStyle(
                  fontFamily: "Livvic",
                  color: Theme.of(context).primaryColor,
                ),
              ),
              leading: Icon(Icons.category_outlined, color: Theme.of(context).iconTheme.color,),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen()));
              },
            ),
            ListTile(
              title: Text(
                "Settings",
                style: TextStyle(
                  fontFamily: "Livvic",
                  color: Theme.of(context).primaryColor,
                ),
              ),
              leading: Icon(Icons.settings, color: Theme.of(context).iconTheme.color,),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()));
              },
            ),
            ListTile(
              title: Text(
                "About",
                style: TextStyle(
                  fontFamily: "Livvic",
                  color: Theme.of(context).primaryColor,
                ),
              ),
              leading: Icon(Icons.info_outline, color: Theme.of(context).iconTheme.color,),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => AboutPage()));
              },
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return Future.delayed(
            Duration(seconds: 1),
              () {
              setState(() {
                loadStringData("currUsername");
                SnackBar(content: Text("Page Refreshed"),);
              });
              }
          );
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.all(20.0),
                      padding: EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 50.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.deepPurple,
                          width: 2.5,
                        ),
                        color: Theme.of(context).backgroundColor,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Text(
                        "Hello" + "$username",
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Livvic",
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(20.0),
                      padding: EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 20.0),
                      decoration: BoxDecoration(
                        color: Colors.blueGrey[800],
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Text(
                        "Balance:\n₹ $currentBalance",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Livvic",
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.all(20.0),
                      child: ElevatedButton.icon(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext ctx) =>
                                AddBalanceDialog(currentBalance, updateBalance),
                          );
                        },
                        icon: Icon(Icons.add, color: Colors.black,),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.amber[200],
                          padding: EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 50.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          ),
                        ),
                        label: Text(
                          "Add",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Livvic",
                            fontSize: 15.0,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(20.0),
                      child: ElevatedButton.icon(
                        onPressed: () {
                          DateTime selectedDate = DateTime.now();
                          showDialog(
                            context: context,
                            builder: (BuildContext ctx) =>
                                SetSalaryDialog(),
                          );
                        },
                        icon: Icon(Icons.edit, color: Colors.black,),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.amber[200],
                          padding: EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 50.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          ),
                        ),
                        label: Text(
                          "Set",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Livvic",
                            fontSize: 15.0,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 350.0,
                  margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
                  padding: EdgeInsets.symmetric(horizontal: 100.0, vertical: 10.0),
                  decoration: BoxDecoration(
                    color: Colors.amber[300],
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Pie Chart",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Livvic",
                          fontSize: 15.0,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 350.0,
                  height: 300.0,
                  padding: EdgeInsets.symmetric(horizontal: 100.0, vertical: 10.0),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey[50],
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0),),
                  ),
                  child: barChart(),
                ),
                SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
