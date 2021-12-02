import 'dart:async';
import 'dart:core';

import 'package:finance_app/Transactions.dart';

import 'package:fl_chart/fl_chart.dart';

import 'package:hive/hive.dart';


import 'package:flutter/material.dart';

class plotChart extends StatefulWidget {


String category;
String subCategory;
int selectedmonth;

  plotChart({required this.category,required this.subCategory,required this.selectedmonth});


  @override
  _plotChartState createState() => _plotChartState();
}

class _plotChartState extends State<plotChart> {
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



  List lists(String title,String subcat){
    getData();
    List points=[];
    if(title=='Needs'){
      if(subcat=='All'){
      return needList;}
      else{

        for(var item in needList){
          //print(item.subCategory);
          if(subcat==item.subCategory){
            points.add(item);
          }


      }

      }

    }
     else if(title=='Miscellaneous'){
      if(subcat=='All'){
      return miscList;}
      else{
        //List needed1=[];
        for(var item in miscList){
         // print(item.subCategory);
          if(subcat==item.subCategory){
            points.add(item);
          }


        }

      }
    }
    else{
      if(subcat=='All'){
      return healthList;}
      else{

        for(var item in healthList){
          //print(item.subCategory);
          if(subcat==item.subCategory){
            points.add(item);
          }


        }

      }
    }
    return points;
  }

  @override
  void initState() {
    // TODO: implement initState


    super.initState();
    getData();
  }

  DateTime today=DateTime.now();
  List<FlSpot> getPlotPoints(List data){

    List<FlSpot> dataSet=[];
    List temp=[];
    List temp1=[];
    data.forEach((value){
      // if(((value.transactionDate as DateTime).month >= widget.startDate.month
      // && (value.transactionDate as DateTime).year >= widget.startDate.year
      //     && (value.transactionDate as DateTime).day >= widget.startDate.day
      // )&& ((value.transactionDate as DateTime).month <= widget.endDate.month
      //     && (value.transactionDate as DateTime).year <= widget.endDate.year
      //     && (value.transactionDate as DateTime).day <= widget.endDate.day
      // ))
      if((value.transactionDate as DateTime).month == widget.selectedmonth){
         temp.add({
           'day':(value.transactionDate as DateTime).day,
          'amount': int.parse(value.amount)
         }
         );
      }
    });
    temp.sort((a,b)=>a['day'].compareTo(b['day']));



    for(var i=0;i<temp.length;i++){

      dataSet.add(
        FlSpot(
          temp[i]['day'].toDouble(),
            temp[i]['amount'].toDouble()
        )
      );
    }

      return dataSet;
  }

  @override
  Widget build(BuildContext context) {
    var checker=lists(widget.category,widget.subCategory);
    return
        checker.isEmpty?Container(
          height:MediaQuery.of(context).size.height*0.30,
          decoration:BoxDecoration(borderRadius:BorderRadius.circular(15),


          ),
          width:(MediaQuery.of(context).size.width)-30,
          padding:const EdgeInsets.all(10),
          child: Text('This Category is Empty!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 20,
              decoration: TextDecoration.none,
              color: Theme.of(context).primaryColor,
            ),),
        ):
       Container(
          height:MediaQuery.of(context).size.height*0.30,
          decoration:BoxDecoration(borderRadius:BorderRadius.circular(15),


          ),
          width:(MediaQuery.of(context).size.width)-30,
          padding:const EdgeInsets.all(10),
          child: LineChart(

          LineChartData(


            axisTitleData: FlAxisTitleData(show:false,
            ),
            gridData: FlGridData(show: false,
            drawHorizontalLine: false,
            drawVerticalLine: false),
            borderData: FlBorderData(
              show:false,

            ),
              lineBarsData: [
                LineChartBarData(

                  spots:getPlotPoints(checker),
                  isCurved: false,
                  barWidth: 2,
                  colors:[Colors.purple],

                ),
              ]
          )
        ),


      );


  }
}

