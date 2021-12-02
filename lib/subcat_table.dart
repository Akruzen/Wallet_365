import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'Transactions.dart';
class Tile extends StatefulWidget {
    String label;
    String amount;
    DateTime date;
    String category;
  int index;
    Tile({required this.label,required this.amount,required this.date,required this.category,required this.index});

  @override
  _TileState createState() => _TileState();
}

class _TileState extends State<Tile> {



  void delete1(String category,int index){
    final need= Hive.box<needsTransaction>('needsTransactions');
    final misc1= Hive.box<miscellaneousTransaction>('miscellaneousTransactions');
    final medi1=  Hive.box<healthCareTransaction>('healthCareTransactions');

    if(category=='Needs'){
      need.deleteAt(index);
    }
    else if(category=='Miscellaneous'){
      misc1.deleteAt(index);
    }
    else{
      medi1.deleteAt(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key:ValueKey(widget.index),
      background:Container(color:Colors.red,
      child:Icon(Icons.delete,
      color:Colors.white,
      size:45),
      alignment:Alignment.centerRight,
      padding:EdgeInsets.only(right:15),
      margin:EdgeInsets.symmetric(
        horizontal: 20,
        vertical:5,
      )),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction){
        return showDialog(context: context,
            builder:(ctx)=>AlertDialog(
              title:Text('Are you sure?'),
              content:Text('Do you permanently delete this transaction?'),
              actions:<Widget>[
                FlatButton(child:Text('No'),
                onPressed:(){
                  Navigator.of(ctx).pop(false);
                }),
                FlatButton(child:Text('Yes'),
                    onPressed:(){

                      Navigator.of(ctx).pop(true);
                      delete1(widget.category, widget.index);
                    }),
              ]
            ),
        );
      },
      onDismissed: (direction) {

        setState(() {

        });


      },
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal:10,
          vertical:5
        ),

        child:Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            title:Text(widget.label),
            subtitle: Text(widget.date.toString()),
            trailing:Text(widget.amount)
          ),
        ),
      ),
    );
  }
}






