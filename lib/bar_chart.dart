import 'dart:core';

import 'package:finance_app/Transactions.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class barChart extends StatefulWidget {
  @override
  _barChartState createState() => _barChartState();
}

class _barChartState extends State<barChart> {
  List<needsTransaction> needList=[];
  List<healthCareTransaction> healthList=[];
  List<miscellaneousTransaction> miscList=[];

  Future<void> getData() async {
    final need= await Hive.openBox<needsTransaction>('needsTransactions');
    final misc= await Hive.openBox<miscellaneousTransaction>('miscellaneousTransactions');
    final medi=  await Hive.openBox<healthCareTransaction>('healthCareTransactions');
    if(mounted){
      setState(() {
        needList=need.values.toList();
        healthList=medi.values.toList();
        miscList=misc.values.toList();

      });}
  }
  int today=DateTime.now().month;
  // int total=0;
  // int needs=0;
  // int medical=0;
  // int misl=0;

  List getFraction(){
    int total=0;
    int needs=0;
    int medical=0;
    int misl=0;
    getData();
    List<int> fraction=[];
    for(var item in needList){
      if(item.transactionDate.month==today){
        needs+=int.parse(item.amount);
        total+=int.parse(item.amount);
      }
    }
    fraction.add(needs);

    for(var item in miscList){
      if(item.transactionDate.month==today){
        misl+=int.parse(item.amount);
        total+=int.parse(item.amount);
      }
    }
    fraction.add(misl);

    for(var item in healthList){
      if(item.transactionDate.month==today){
        medical+=int.parse(item.amount);
        total+=int.parse(item.amount);
      }
    }
    fraction.add(medical);
    fraction.add(total);
    return fraction;
  }

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }



  @override
  Widget build(BuildContext context) {
    List fractionData=getFraction();
    return Container(
      height:MediaQuery.of(context).size.height*0.30,
      decoration:BoxDecoration(
        borderRadius:BorderRadius.circular(15),
      ),
      width:(MediaQuery.of(context).size.width)-30,
      padding:const EdgeInsets.all(10),
      child:PieChart(

        PieChartData(
          centerSpaceRadius: 10,
          sectionsSpace: 3,
          sections: [
            PieChartSectionData(
              value:(fractionData[0]/fractionData[3])*100,
              title:'Needs ${(fractionData[0]/fractionData[3])*100} %',
              color: Colors.pink,
            ),
            PieChartSectionData(
              value:(fractionData[1]/fractionData[3])*100,
              title:'miscellaneous ${(fractionData[1]/fractionData[3])*100} %',
              color: Colors.amber,
            ),
            PieChartSectionData(
              // value:((fractionData[3]-(fractionData[0]+(fractionData[1])))/fractionData[3])*100,
              value: 100 - ((fractionData[0]/fractionData[3])*100) + ((fractionData[1]/fractionData[3])*100) as double,
              title:'Medical ${(fractionData[2]/fractionData[3])*100} %',
              color: Colors.blue,
            ),
          ]
        )
      ),

    );
  }
}
