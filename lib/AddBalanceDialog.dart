import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddBalanceDialog extends StatelessWidget {
  final int currentBalance;
  final Function updateBalance2;
  AddBalanceDialog(this.currentBalance, this.updateBalance2);
  @override
  Widget build(BuildContext context) {
    final addBalanceController = TextEditingController();
    return AlertDialog(
      backgroundColor: Theme.of(context).dialogBackgroundColor,
      contentPadding: EdgeInsets.all(20.0),
      actionsPadding: EdgeInsets.all(10.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      title: Text(
        "Add money to your Wallet",
        style: TextStyle(
          fontFamily: "Livvic",
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: Text(
                  "How much money do you want to add?",
                  style: TextStyle(
                    fontFamily: "Livvic",
                  ),
                ),
              ),
              TextField(
                controller: addBalanceController,
                maxLength: 8,
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),],
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.deepPurple, width: 2.0),
                  ),
                  labelText: "Amount",
                  labelStyle: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                  icon: Icon(Icons.money, color: Theme.of(context).iconTheme.color,),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  "What is the source of Income?",
                  style: TextStyle(
                    fontFamily: "Livvic",
                  ),
                ),
              ),
              TextField(
                maxLength: 50,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.deepPurple, width: 2.0),
                  ),
                  labelText: "Description",
                  labelStyle: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                  icon: Icon(
                    Icons.text_fields_sharp, color: Theme.of(context).iconTheme.color),
                ),
              ),
            ],
          ),
        ],
      ),
      actions: <Widget>[
        new ElevatedButton(
          onPressed: () {
            if (addBalanceController.text.isEmpty) {
              final snackBar = SnackBar(content: Text(
                  "Value to add cannot be empty. Press close to cancel.",
                style: TextStyle(
                  color: Colors.white,
                ),
              ));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
            else {
              updateBalance2 (currentBalance + int.parse(addBalanceController.text));
              Navigator.of(context).pop();
            }
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
