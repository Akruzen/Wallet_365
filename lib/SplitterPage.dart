import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplitterPage extends StatefulWidget {
  @override
  _SplitterPageState createState() => _SplitterPageState();
}

class _SplitterPageState extends State<SplitterPage> {

  bool _isSnackBarActive = false;
  final totalAmountController = TextEditingController();
  final peopleCountController = TextEditingController();
  final totalAmountController2 = TextEditingController();
  final peopleCountController2 = TextEditingController();
  double splitAmount = 0;
  String solutionString = "";
  String solutionString2 = "";
  String snackBarMessage = "";
  int _bottomSelectedIndex = 0;
  PageController pageController = PageController();
  int personCount = 1;
  int percentTotal = 0;
  List <bool> isChecked = [false, false, false, false, false, false, false, false, false, false];
  List <TextEditingController> individualPercentController = [for (int i = 0; i < 10; i++) TextEditingController()];
  List <double> individualShare = [for (int i = 0; i < 10; i++) 0];
  List <double> individualAmount = [for (int i = 0; i < 10; i++) 0];

  void _onBottomTappedItem(int index) {
    setState(() {
      _bottomSelectedIndex = index;
    });
    pageController.animateToPage(index, duration: Duration(milliseconds: 750), curve: Curves.bounceOut);
  }

  void resetValues() {
    setState(() {
      //isChecked = [false, false, false, false, false, false, false, false, false, false];
      //individualPercentController = [for (int i = 0; i < 10; i++) TextEditingController()];
      individualShare = [for (int i = 0; i < 10; i++) 0];
      individualAmount = [for (int i = 0; i < 10; i++) 0];
      solutionString2 = "";
      percentTotal = 0;
    });
  }

  void showCustomSnackBar (String message) {
    if (!_isSnackBarActive) {
      _isSnackBarActive = true;
      final snackBar = SnackBar(
        content: Text(message),
        action: SnackBarAction(label: "Got it", onPressed: () {},),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar).closed.then((SnackBarClosedReason reason) {_isSnackBarActive = false;});
    }
  }

  Widget _personField(int checkBoxIndex) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Checkbox(
            value: isChecked[checkBoxIndex],
            activeColor: Colors.amber,
            checkColor: Colors.black,
            onChanged: (bool? value) {
              setState(() {
                isChecked[checkBoxIndex] = value!;
              });
            },
          ),
          SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: TextField(
              enabled: isChecked[checkBoxIndex],
              controller: individualPercentController[checkBoxIndex],
              maxLength: 2,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),],
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurple),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurple, width: 2.0),
                ),
                labelText: ("Person " + (checkBoxIndex+1).toString() + " percent"),
                labelStyle: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
                prefixIcon: Icon(Icons.account_tree_outlined, color: Theme.of(context).iconTheme.color),
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cash Splitter",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showCustomSnackBar("Select Categories below");
        },
        child: Icon(Icons.help_outline_sharp, color: Theme.of(context).scaffoldBackgroundColor,),
        backgroundColor: Theme.of(context).floatingActionButtonTheme.backgroundColor,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.people_outline_sharp), label: "Split Equally"),
          BottomNavigationBarItem(icon: Icon(Icons.workspaces_outline), label: "Split by Percent"),
        ],
        currentIndex: _bottomSelectedIndex,
        onTap: _onBottomTappedItem,
      ),
      body: PageView(
        controller: pageController,
        children: [
          // Split Equally Page
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Split Equally",
                    style: TextStyle(
                      fontFamily: "Livvic",
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextField(
                          maxLength: 10,
                          controller: totalAmountController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),],
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.deepPurple),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.deepPurple, width: 2.0),
                            ),
                            labelText: "Total Amount",
                            labelStyle: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                            prefixIcon: Icon(Icons.money, color: Theme.of(context).iconTheme.color),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        " is split between ",
                        style: TextStyle(
                          fontFamily: "Livvic",
                          fontSize: 15.0,
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: TextField(
                          maxLength: 10,
                          controller: peopleCountController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),],
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.deepPurple),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.deepPurple, width: 2.0),
                            ),
                            labelText: "People Count",
                            labelStyle: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                            prefixIcon: Icon(Icons.money, color: Theme.of(context).iconTheme.color),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    margin: EdgeInsets.all(20.0),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        if (double.parse(peopleCountController.text) != 0) {
                          splitAmount = (double.tryParse(totalAmountController.text) ?? 1) / (double.tryParse(peopleCountController.text) ?? 1);
                          splitAmount = double.tryParse(splitAmount.toStringAsFixed(2)) ?? 1;
                          setState(() {
                            solutionString = "Each person's split is $splitAmount buck(s).";
                          });
                        }
                        else {
                          if (!_isSnackBarActive) {
                            _isSnackBarActive = true;
                            final snackBar = SnackBar(
                              content: Text("Minimum people count has to be 1."),
                              action: SnackBarAction(label: "Got it", onPressed: () {},),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar).closed.then((SnackBarClosedReason reason) {_isSnackBarActive = false;});
                          }
                        }
                      },
                      icon: Icon(Icons.arrow_forward, color: Colors.black,),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.amber[200],
                        padding: EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 50.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                      ),
                      label: Text(
                        "Calculate",
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
                  Divider(
                    height: 20.0,
                    color: Theme.of(context).primaryColor,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "Solution:",
                    style: TextStyle(
                      fontFamily: "Livvic",
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    solutionString,
                    style: TextStyle(
                      fontFamily: "Livvic",
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Split by Percent Page
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Split by Percent",
                    style: TextStyle(
                      fontFamily: "Livvic",
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Text(
                    "Enter the amount you want to divide in percentage",
                    style: TextStyle(
                      fontSize: 15.0,
                      fontFamily: "Livvic",
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextField(
                    maxLength: 10,
                    controller: totalAmountController2,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepPurple),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepPurple, width: 2.0),
                      ),
                      labelText: "Total Amount",
                      labelStyle: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                      prefixIcon: Icon(Icons.money, color: Theme.of(context).iconTheme.color),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    "Tick the checkboxes according to the number of people you want to split the amount into. Maximum people count is 10."
                        " Then enter the percentage share of that respective person in the field adjacent to it.",
                    style: TextStyle(
                      fontFamily: "Livvic",
                      fontSize: 15.0,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  _personField(0),
                  _personField(1),
                  _personField(2),
                  _personField(3),
                  _personField(4),
                  _personField(5),
                  _personField(6),
                  _personField(7),
                  _personField(8),
                  _personField(9),
                  Container(
                    margin: EdgeInsets.all(20.0),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        resetValues();
                        for (int i = 0; i < 10; i++) {
                          if (isChecked[i]) {
                            if (individualPercentController[i].text.isEmpty) {
                              snackBarMessage = "Please fill all checked fields.";
                              showCustomSnackBar(snackBarMessage);
                              resetValues();
                            }
                            else if (int.parse(individualPercentController[i].text) == 0) {
                              snackBarMessage = "Percentage Share cannot be zero";
                              showCustomSnackBar(snackBarMessage);
                              resetValues();
                            }
                            else {
                              percentTotal += int.parse(individualPercentController[i].text);
                              individualShare[i] = double.parse(individualPercentController[i].text);
                            }
                          }
                        }
                        if (percentTotal > 100) {
                          showCustomSnackBar("Percentage Share total should not exceed 100");
                          resetValues();
                        }
                        else if (totalAmountController2.text.isEmpty) {
                          showCustomSnackBar("Please enter the Total Amount.");
                          resetValues();
                        }
                        else {
                          solutionString2 = "";
                          for (int i = 0; i < 10; i++) {
                            if (isChecked[i]) {
                              individualAmount[i] = individualShare[i] * (double.tryParse(totalAmountController2.text) ?? 1) / 100;
                              setState(() {
                                solutionString2 += "Person ${i+1}'s Share is ${individualAmount[i].toStringAsFixed(2)} Buck(s).\n\n";
                              });
                            }
                          }
                        }
                      },
                      icon: Icon(Icons.arrow_forward, color: Colors.black,),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.amber[200],
                        padding: EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 50.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                      ),
                      label: Text(
                        "Calculate",
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
                  Divider(
                    height: 20.0,
                    color: Theme.of(context).primaryColor,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "Solution:",
                    style: TextStyle(
                      fontFamily: "Livvic",
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    solutionString2,
                    style: TextStyle(
                      fontSize: 15.0,
                      fontFamily: "Livvic",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
