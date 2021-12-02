import 'dart:async';
import 'package:finance_app/3buttons.dart';
import 'package:finance_app/Transactions.dart';
import 'package:finance_app/charts.dart';
import 'package:finance_app/customDialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';



class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
@override
  void initState() {
    // TODO: implement initState
  open();
    super.initState();
  }
  Future<void> open() async {
    var need=await Hive.openBox<needsTransaction>('needsTransactions');
    var misc=await Hive.openBox<miscellaneousTransaction>('miscellaneousTransactions');
    var medi=await Hive.openBox<healthCareTransaction>('healthCareTransactions');
  }
void customList(String category,String subCategory){
  setState(() {
    showDialog(context: context,
        builder:(ctx)=>customDialog(category: category, subCategory: subCategory));
  });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text('Categories'),
      ),
      body:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(


            children:<Widget>[
              Container(

                height:MediaQuery.of(context).size.height*0.35,
                decoration:buildBoxDecorationCategories(),
                width:(MediaQuery.of(context).size.width)-30,
                padding:const EdgeInsets.all(10),
                child:Stack(
                  //alignment: AlignmentDirectional.bottomCenter,
                  children: <Widget>[
                   plotChart(category: 'Needs', subCategory: 'All',selectedmonth: DateTime.now().month ),

                    Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.stretch,

                    children: [
                      Text('Needs',style:TextStyle(fontSize: 30,fontWeight:FontWeight.w600)),
                      Row(
                        crossAxisAlignment:  CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        mainAxisSize:MainAxisSize.min ,
                        children:<Widget>[
                          Column(
                            mainAxisAlignment:MainAxisAlignment.end,

                            children: [
                              SizedBox(
                                height:30,
                                child: IconButton(
                                  icon: Icon(Icons.home_filled, color: Theme.of(context).iconTheme.color,),
                                  onPressed: (){

                                    showDialog(context: context,
                                        builder:(ctx)=>customDialog(category: 'Needs', subCategory:  'Housing'));


                                  },
                                ),
                              ),

                               Text('House'),
                            ],
                          ),

                          Column(
                            mainAxisAlignment:MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                height:30,
                                child: IconButton(
                                  icon: Icon(Icons.emoji_transportation, color: Theme.of(context).iconTheme.color,),
                                  onPressed: (){
                                    showDialog(context: context,
                                        builder:(ctx)=>customDialog(category: 'Needs', subCategory: 'Transportation'));

                                  },
                                ),
                              ),
                              Text('Transport'),
                            ],
                          ),

                          Column(
                            mainAxisAlignment:MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                height:30,
                                child: IconButton(
                                  icon: Icon(Icons.fastfood, color: Theme.of(context).iconTheme.color,),
                                  onPressed: (){
                                    showDialog(context: context,
                                        builder:(ctx)=>customDialog(category: 'Needs', subCategory: 'Food' ));

                                  },
                                ),
                              ),
                              Text('Food'),
                            ],
                          ),


                          Column(
                            mainAxisAlignment:MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                height:30,
                                child: IconButton(
                                  icon: Icon(Icons.filter_tilt_shift_sharp, color: Theme.of(context).iconTheme.color,), //utilities
                                  onPressed: (){
                                    showDialog(context: context,
                                        builder:(ctx)=>customDialog(category: 'Needs', subCategory:  'Utilities'));

                                  },
                                ),
                              ),
                              Text('Utilities'),
                            ],
                          ),


                          Column(
                            mainAxisAlignment:MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                height:30,
                                child: IconButton(
                                  icon: Icon(Icons.payments_outlined, color: Theme.of(context).iconTheme.color,),
                                  onPressed: (){
                                    showDialog(context: context,
                                        builder:(ctx)=>customDialog(category: 'Needs', subCategory:  'Bill'));

                                  },
                                ),
                              ),
                              Text('Bills'),
                            ],
                          ),

                        ],
                      ),
                    ],
                  ),]
                ),

              ),

              SizedBox(height:20,),

              Container(
                height:MediaQuery.of(context).size.height*0.35,
                decoration:buildBoxDecorationCategories(),
                width:(MediaQuery.of(context).size.width)-30,
                padding:const EdgeInsets.all(10),
                child:Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                  children:<Widget>[
                    plotChart(category: 'Miscellaneous', subCategory: 'All', selectedmonth: DateTime.now().month,),
                    Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize:MainAxisSize.min ,
                    children: [
                      Text('Miscellaneous',style:TextStyle(fontSize: 30,fontWeight:FontWeight.w600)),
                      Row(
                        crossAxisAlignment:  CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        mainAxisSize:MainAxisSize.min ,
                        children:<Widget>[
                          Column(
                            mainAxisAlignment:MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                height:30,
                                child: IconButton(
                                  icon: Icon(Icons.shopping_bag_outlined, color: Theme.of(context).iconTheme.color,),
                                  onPressed: (){
                                    showDialog(context: context,
                                        builder:(ctx)=>customDialog(category: 'Miscellaneous', subCategory:  'Shopping'));

                                  },
                                ),
                              ),
                              Text('Shopping'),
                            ],
                          ),

                          Column(
                            mainAxisAlignment:MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                height:30,
                                child: IconButton(
                                  icon: Icon(Icons.tv, color: Theme.of(context).iconTheme.color,),
                                  onPressed: (){
                                    showDialog(context: context,
                                        builder:(ctx)=>customDialog(category: 'Miscellaneous', subCategory:  'Entertainment'));

                                  },
                                ),
                              ),
                              Text('Entertainment')
                            ],
                          ),

                          Column(
                            mainAxisAlignment:MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                height:30,
                                child: IconButton(
                                  icon: Icon(Icons.card_giftcard, color: Theme.of(context).iconTheme.color,),
                                  onPressed: (){
                                    showDialog(context: context,
                                        builder:(ctx)=>customDialog(category: 'Miscellaneous', subCategory:  'Gifts'));

                                  },
                                ),
                              ),
                              Text('Gifts')
                            ],
                          ),


                          Column(
                            mainAxisAlignment:MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                height:30,
                                child: IconButton(
                                  icon: Icon(Icons.pregnant_woman_rounded), //hobbies
                                  onPressed: (){
                                    showDialog(context: context,
                                        builder:(ctx)=>customDialog(category: 'Miscellaneous', subCategory:  'Hobbies'));

                                  },
                                ),
                              ),
                              Text('Hobbies')
                            ],
                          ),


                        ],
                      ),
                    ],
                  ),]
                ),

              ),


              SizedBox(height:20,),

              Container(
                height:MediaQuery.of(context).size.height*0.35,
                decoration:buildBoxDecorationCategories(),
                width:(MediaQuery.of(context).size.width)-30,
                padding:const EdgeInsets.all(10),
                child:Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                  children:<Widget>[
                    plotChart(category: 'Healthcare', subCategory: 'All',selectedmonth: DateTime.now().month),
                    Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize:MainAxisSize.min ,
                    children: [
                      Text('Healthcare',style:TextStyle(fontSize: 30,fontWeight:FontWeight.w600)),
                      Row(
                        crossAxisAlignment:  CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children:<Widget>[
                          Column(
                            mainAxisAlignment:MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                height:30,
                                child: IconButton(
                                  icon: Icon(Icons.local_hospital, color: Theme.of(context).iconTheme.color,),
                                  onPressed: (){
                                    showDialog(context: context,
                                        builder:(ctx)=>customDialog(category: 'HealthCare', subCategory:  'Emergency'));

                                  },
                                ),
                              ),
                              Text('Emergency')
                            ],
                          ),

                          Column(
                            mainAxisAlignment:MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                height:30,
                                child: IconButton(
                                  icon: Icon(Icons.healing, color: Theme.of(context).iconTheme.color,),
                                  onPressed: (){
                                    showDialog(context: context,
                                        builder:(ctx)=>customDialog(category: 'HealthCare', subCategory:  'Regular'));

                                  },
                                ),
                              ),
                              Text('Regular')
                            ],
                          ),


                        ],
                      ),
                    ],
                  ),]
                ),

              ),
            ],
          ),
        ),
      ),

    floatingActionButton: MainAction(),);
  }

  BoxDecoration buildBoxDecorationCategories() {
    return BoxDecoration(borderRadius:BorderRadius.circular(15),
                border:Border(
                  left: BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: 1,),
                  top: BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: 1,),
                  right: BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: 1,),
                  bottom: BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: 1,),
                ),


              );
  }
}

