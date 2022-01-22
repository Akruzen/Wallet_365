import 'package:finance_app/charts.dart';

import 'package:flutter/material.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class analysis extends StatefulWidget {
  @override
  _analysisState createState() => _analysisState();
}

class _analysisState extends State<analysis> {
  var categories=['Needs','Miscellaneous','Healthcare'];
  var needSubcat=['Housing','Transportation','Food','Utilities','Bill'];
  var miscSubcat=['Shopping','Entertainment','Gifts','Hobbies'];
  var mediSubcat=['Emergency','Regular'];
  String cat='';
  bool enabled=true;
  bool show=false;
  Widget chart=Container();
  String subcat='';
  DateTime initial=DateTime.now();
  DateTime endDate=DateTime.now();
  Future<void> _selectmonth(BuildContext context)async{
    final DateTime? picked =await showMonthPicker(context:context,
        initialDate: initial, firstDate:DateTime(2020,12) ,
        lastDate: DateTime(2100,01));
     // locale: Locale("es"));
    if(picked!=null && picked !=initial){
      setState(() {
        initial=picked;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
       title:Text('Analytics')
     ),
      body:SingleChildScrollView(
        child: ListView(
         
          shrinkWrap: true,
          padding: EdgeInsets.all(10),

          children: [

              Expanded(
                child: DropdownButtonFormField(

                   disabledHint: Text(cat),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.deepPurple, width: 2.0),
                    ),
                    icon: Icon(Icons.category_outlined, color: Theme.of(context).iconTheme.color,),
                  ),

                  hint:Text('Select Category'),

                  items:categories.map((Cat){
                    return DropdownMenuItem(
                      value:Cat,
                      child:Text('$Cat Category'),
                    );
                  }).toList(),
                  onChanged:enabled?(String? val)=>setState(()=>cat=val.toString()):null,


                ),
              ),

              SizedBox(height: 10.0,),

              if (cat=='Needs')Expanded(
                child: DropdownButtonFormField(


                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.deepPurple, width: 2.0),
                    ),
                    icon: Icon(Icons.web, color: Theme.of(context).iconTheme.color,),
                  ),

                  hint:Text('Select Subcategory'),
                  items:needSubcat.map((subCat){
                    return DropdownMenuItem(
                      value:subCat,
                      child:Text('$subCat SubCategory'),
                    );
                  }).toList(),
                  onChanged:(String? val)=>setState(()=>subcat=val.toString()),


                ),
              ),
              if(cat=='Miscellaneous')Expanded(
                child: DropdownButtonFormField(


                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.deepPurple, width: 2.0),
                    ),
                    icon: Icon(Icons.web, color: Theme.of(context).iconTheme.color,),
                  ),

                  hint:Text('Select Subcategory'),
                  items:miscSubcat.map((subCat){
                    return DropdownMenuItem(
                      value:subCat,
                      child:Text('$subCat SubCategory'),
                    );
                  }).toList(),
                  onChanged:(String? val)=>setState(()=>subcat=val.toString()),


                ),
              ),
              if(cat=='Healthcare')Expanded(
                child: DropdownButtonFormField(


                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.deepPurple, width: 2.0),
                    ),
                    icon: Icon(Icons.web, color: Theme.of(context).iconTheme.color,),
                  ),

                  hint:Text('Select Subcategory'),
                  items:mediSubcat.map((subCat){
                    return DropdownMenuItem(
                      value:subCat,
                      child:Text('$subCat SubCategory'),
                    );
                  }).toList(),
                  onChanged:(String? val)=>setState(()=>subcat=val.toString()),
                ),
              ),

            SizedBox(height:15),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children:<Widget>[
                  Text('Month'),
                SizedBox(width: 5,),
                  IconButton(onPressed: (){
                    _selectmonth(context);
                    FocusScope.of(context).unfocus();
                  }, icon:Icon(Icons.date_range)),
                  SizedBox(width:5),
                  Text('${initial.day} / ${initial.month} / ${initial.year}')
                ]
              ),
            ),
            SizedBox(height:15),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.all(20.0),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        print(cat);
                        print(subcat);
                        enabled=false;
                        show=true;
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Showing Graph'
                            ,style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),),
                          )
                      );
                    },
                    icon: Icon(Icons.bar_chart, color: Colors.black,),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.amber[200],
                      padding: EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 20.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                    ),
                    label: Text(
                      "Show\nGraph",
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
                      setState(() {
                        initial=DateTime.now();
                        subcat='';
                        cat='';
                        enabled=true;
                        show=false;
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Showing Graph'
                            ,style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),),
                          )
                      );
                    },
                    icon: Icon(Icons.restart_alt, color: Colors.black,),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.amber[200],
                      padding: EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 20.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                    ),
                    label: Text(
                      "Reset",
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

             /*RaisedButton(
                color:Colors.amber,
                child:Text(
                  'Show Graph',
                  style:TextStyle(color:Colors.black),
                ),
                onPressed:() {
                  setState(() {
                   print(cat);
                   print(subcat);
                   enabled=false;
                    show=true;
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Showing Graph'
                        ,style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),),
                      )
                  );

                },

              ),*/
            /*RaisedButton(
              color:Colors.amber,
              child:Text(
                'Reset',
                style:TextStyle(color:Colors.black),
              ),
              onPressed:() {
                setState(() {
                  initial=DateTime.now();
                  subcat='';
                  cat='';
                  enabled=true;
                  show=false;
                });

                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Showing Graph'
                      ,style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),),
                    )
                );

              },

            ),*/

            !show?Text('Your Graph will be displayed here!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontFamily: "Livvic",
                fontSize: 20,
                decoration: TextDecoration.none,
                color: Theme.of(context).primaryColor,
              ),):Container(
              height: MediaQuery.of(context).size.height*0.45,
              width: MediaQuery.of(context).size.width*0.30,
              decoration: BoxDecoration(borderRadius:BorderRadius.circular(15),
                border:Border(
                  left: BorderSide(
                    color: Colors.black,
                    width: 1,),
                  top: BorderSide(
                    color: Colors.black,
                    width: 1,),
                  right: BorderSide(
                    color: Colors.black,
                    width: 1,),
                  bottom: BorderSide(
                    color: Colors.black,
                    width: 1,),
                ),

              ),
              padding: EdgeInsets.all(5),
              child: plotChart(category: cat, subCategory: subcat, selectedmonth: initial.month,),
            ),
            

          ]
        ),
      )

    );
  }
}
