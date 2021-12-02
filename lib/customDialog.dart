import 'package:finance_app/dataList.dart';
import 'package:flutter/material.dart';



class customDialog extends StatefulWidget {
  String category;
  String subCategory;
  customDialog({required this.category,required this.subCategory});
  @override
  _customDialogState createState() => _customDialogState();
}

class _customDialogState extends State<customDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape:RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      //backgroundColor: Colors.transparent,
      //scrollable: true,
      content: SizedBox(
          height:MediaQuery.of(context).size.height*0.35,
        width:MediaQuery.of(context).size.width*0.80,

        child:dataList(subCategory: widget.subCategory, category: widget.category)
      ),


      actions:<Widget> [
        TextButton(onPressed:(){
          Navigator.of(context).pop();
        }, child: Text('Back'))
      ],

    );

  }
}
