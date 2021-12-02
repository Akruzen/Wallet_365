import 'dart:core';
import 'package:finance_app/subcat_table.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:finance_app/Transactions.dart';
import 'package:hive_flutter/adapters.dart';

class dataList extends StatefulWidget {
  String category;
  String subCategory;
  dataList({required this.category,required this.subCategory});
  @override
  _dataListState createState() => _dataListState();


}

class _dataListState extends State<dataList> {
  Map needList={};
  Map healthList={};
  Map miscList={};


  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    open();
  }

  Future<void> open() async {
    final need=await Hive.openBox<needsTransaction>('needsTransactions');
    final misc=await Hive.openBox<miscellaneousTransaction>('miscellaneousTransactions');
    final medi=await Hive.openBox<healthCareTransaction>('healthCareTransactions');



    setState(() {
       needList= need.toMap();
      miscList=misc.toMap();
       healthList=medi.toMap();
    });
  }


 Map<int,dynamic>subCatList(String category,String subCategory){

   open();

    if(category=='Needs') {

      Map<int,dynamic> needed={};

      needList.forEach((key,value){

        if(subCategory==value.subCategory){

          needed.addAll({key:value});
        }
      });

      return needed;

    }
    else if(category=='Miscellaneous'){

      Map<int,dynamic> needed1={};
      miscList.forEach((key,value){

        if(subCategory==value.subCategory){
          needed1.addAll({key:value});
        }
      });

      return needed1;
    }
    else {

      Map<int,dynamic> needed2={};
      healthList.forEach((key,value){

        if(subCategory==value.subCategory){
          needed2.addAll({key:value});
        }
      });

      return needed2;
    }

  }

  @override
  Widget build(BuildContext context) {

    Map<int,dynamic> finalneed=subCatList(widget.category, widget.subCategory);
    List keys=finalneed.keys.toList();
    List values1=finalneed.values.toList();

    return Container(
     padding:EdgeInsets.all(5),
      child:finalneed.isEmpty?Container(

        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Text('No Transactions yet for this subcategory!',
              textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                 decoration: TextDecoration.none,
                  color: Colors.black,
              ),),
            ),
          ],
        ),
      ):ListView.builder(
        scrollDirection: Axis.vertical,
          shrinkWrap: true,

          itemCount: values1.length,
          itemBuilder: (context,i){

          print(keys[i]);
        return Tile(amount: values1[i].amount, label: values1[i].label, date:values1[i].transactionDate, category: widget.category,index:keys[i] );
      })


    );
  }
}


