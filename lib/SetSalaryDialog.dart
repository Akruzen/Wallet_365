import 'package:finance_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Dialog box which opens up when "Set" button is clicked
class SetSalaryDialog extends StatefulWidget {
  @override
  State<SetSalaryDialog> createState() => _SetSalaryDialogState();
}

class _SetSalaryDialogState extends State<SetSalaryDialog> {
  String selectedDate = "";
  String currSalary = "";


  _SetSalaryDialogState() {
    loadStringData("selectedDate", "selectedDate");
    loadStringData("currSalary", "currSalary");
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime selectedDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        saveStringData("selectedDateTemp", selectedDate.toString());
        loadStringData("selectedDateTemp", "selectedDate");
      });
  }

  // To save strings in shared preferences
  void saveStringData(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  // To load strings in shared preferences
  void loadStringData(String key, String variableName) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      switch (variableName) {
        case "selectedDate":
          selectedDate = prefs.getString(key) ?? "No-Selection";
          break;
        case "currSalary":
          currSalary = prefs.getString(key) ?? "No Selection";
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final setSalaryController = TextEditingController();
    final setUsernameController = TextEditingController();
    return new AlertDialog(
      backgroundColor: Theme.of(context).dialogBackgroundColor,
      contentPadding: EdgeInsets.all(20.0),
      actionsPadding: EdgeInsets.all(10.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      title: Text(
        "Set your Info",
        style: TextStyle(
          fontFamily: "Livvic",
          fontWeight: FontWeight.bold,
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 20.0),
                  child: Text(
                    "Set your Username",
                    style: TextStyle(
                      fontFamily: "Livvic",
                    ),
                  ),
                ),
                TextField(
                  controller: setUsernameController,
                  maxLength: 10,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple, width: 2.0),
                    ),
                    labelText: "Username",
                    labelStyle: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                    icon: Icon(Icons.account_box_rounded, color: Theme.of(context).iconTheme.color),
                  ),
                ),
                Divider(
                  height: 30.0,
                  thickness: 1.0,
                  color: Colors.black38,
                ),
                Text(
                  "Set your monthly income here.\nOn the selected date, the amount you enter will get added automatically.",
                  style: TextStyle(
                    fontFamily: "Livvic",
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  padding: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple[100],
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                  child: Text(
                    "Current Monthly Income:\n" + "$currSalary",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Livvic",
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextField(
                  controller: setSalaryController,
                  maxLength: 8,
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),],
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple, width: 2.0),
                    ),
                    labelText: "Set Monthly Income",
                    labelStyle: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                    icon: Icon(Icons.money, color: Theme.of(context).iconTheme.color),
                  ),
                ),
                Divider(
                  height: 30.0,
                  thickness: 1.0,
                  color: Colors.black38,
                ),
                Text(
                  "Select the date of month",
                  style: TextStyle(
                    fontFamily: "Livvic",
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple[100],
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      child: Text(
                        "Currently Selected:\n" + "$selectedDate".split(" ")[0],
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Livvic",
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Container(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          _selectDate(context);
                          setState(() {

                          });
                        },
                        icon: Icon(Icons.date_range_sharp, color: Colors.black),
                        label: Text("Set Date", style: TextStyle(color: Colors.black),),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.amber[100],
                          padding: EdgeInsets.all(30.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          )
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        new ElevatedButton(
          onPressed: () {
            loadStringData("selectedDateTemp", "selectedDate");
            saveStringData("selectedDate", selectedDate.toString());
            saveStringData("currSalary", setSalaryController.text.toString());
            saveStringData("currUsername", setUsernameController.text.toString());
            Navigator.of(context).pop();
          },
          child: Text(
            "Save",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          style: ElevatedButton.styleFrom(
            primary: Colors.amber[400],
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
          ),
        ),
        new ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            "Close",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          style: ElevatedButton.styleFrom(
            primary: Colors.amber[200],
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
          ),
        ),
      ],
    );
  }
}
