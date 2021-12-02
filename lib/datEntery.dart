import 'package:finance_app/Transactions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';



class formData extends StatefulWidget {
  String category;
  List<String> subCategories;
  formData({required this.subCategories,required this.category});
  @override
  _formDataState createState() => _formDataState();
}

class _formDataState extends State<formData> {

  final _formKey=GlobalKey<FormState>();
  //bool isButtonEnabled=false;
 String  Subcat='';
  TextEditingController controllerLabelBill= new TextEditingController();

  TextEditingController controllerAmount=new TextEditingController();
  DateTime selectedDate=DateTime.now();

  Future<void> _selectedDate(BuildContext context)async{
    final DateTime? picked =await showDatePicker(context:context,
        initialDate: selectedDate, firstDate:DateTime(2020,12) ,
        lastDate: DateTime(2100,01));
    if(picked!=null && picked !=selectedDate){
      setState(() {
        selectedDate=picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {


    Future<void> addTransaction(String label,String amount,String subCategory,String category,DateTime date)  async {

      var need=await Hive.openBox<needsTransaction>('needsTransactions');
      var misc=await Hive.openBox<miscellaneousTransaction>('miscellaneousTransactions');
      var medi=await Hive.openBox<healthCareTransaction>('healthCareTransactions');
      if(category=='Needs') {


      var trans=needsTransaction()
        ..label=label
        ..transactionDate=date
        ..amount=amount
        ..subCategory=subCategory.toString();



      need.add( trans);

      // var employeeList = need.values.toList().cast<needsTransaction>();
      //
      // for(var item in employeeList){
      //   print(item.subCategory);
      //   print(item.amount);
      //   print(item.transactionDate);
      //   print(item.label);
      // }


      }
    else if(category=='Miscellaneous'){

      var trans1=miscellaneousTransaction()
        ..label=label
        ..transactionDate=date
        ..amount=amount
        ..subCategory=subCategory.toString();

       misc.add( trans1);

      //  var employeeList1 = misc.values.toList().cast<miscellaneousTransaction>();
      //
      // for(var item in employeeList1){
      //   print(item.subCategory);
      //   print(item.amount);
      //   print(item.transactionDate);
      //   print(item.label);
      // }

    }
    else{

      var trans2=healthCareTransaction()
        ..label=label
        ..transactionDate=date
        ..amount=amount
        ..subCategory=subCategory.toString();

       medi.add( trans2);

      // var employeeList2 = need.values.toList().cast<healthCareTransaction>();
      //
      // for(var item in employeeList2){
      //   print(item.subCategory);
      //   print(item.amount);
      //   print(item.transactionDate);
      //   print(item.label);

   // }

    }}
    return Form(

      key:_formKey,

      child:Padding(

        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children:<Widget>[
            Text(widget.category),
            SizedBox(height:10),

            TextField(

              // decoration: buildInputDecoration().copyWith(labelText: 'Bill Label'),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurple),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.deepPurple, width: 2.0),
                ),
                labelText: "Bill Label",
                labelStyle: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
                icon: Icon(Icons.label, color: Theme.of(context).iconTheme.color,),
              ),

              controller: controllerLabelBill,
              textInputAction: TextInputAction.next,


            ),
            SizedBox(height:10),
            TextField(

              // decoration: buildInputDecoration().copyWith(labelText: 'Amount'),
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

              keyboardType: TextInputType.number,

              controller: controllerAmount,
              textInputAction: TextInputAction.next,
            ),
            SizedBox(height:10),
            DropdownButtonFormField(
             hint:Text('Select the subcategory', style: TextStyle(color: Theme.of(context).primaryColor),) ,

              //decoration:buildInputDecoration(),
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

              items:widget.subCategories.map((subCat){

                return DropdownMenuItem(
                  value:subCat,
                  child:Text('$subCat'),
                );
              }).toList(),
              onChanged:(String? val){


                  setState((){
                    Subcat=val.toString();

                },

            );}),
            SizedBox(height:10),
            Column(
              children: [
                Icon(Icons.date_range_outlined),
                SizedBox(width:12),
                TextButton(
                  onPressed: (){
                    _selectedDate(context);
                    FocusScope.of(context).unfocus();
                  },
                  child:Text('${selectedDate.day} / ${selectedDate.month} / ${selectedDate.year}')
                ),
              ],
            ),
            SizedBox(height:10),
            ElevatedButton.icon(
              onPressed: () {

                var label=controllerLabelBill.text;
                var amount=controllerAmount.text;
                if(label.isNotEmpty & amount.isNotEmpty & Subcat.isNotEmpty){
                  addTransaction(label, amount, Subcat,widget.category,selectedDate);}
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Transaction Added!'
                      ,style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),),
                    )
                );

              },
              icon: Icon(Icons.add, color: Colors.black,),
              style: ElevatedButton.styleFrom(
                primary: Colors.amber[200],
                padding: EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 50.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
              ),
              label: Text(
                "Add",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Livvic",
                  fontSize: 15.0,
                  letterSpacing: 1.5,
                ),
              ),
            ),
            /*RaisedButton(
                color:Colors.amber,
                child:Text(
                  'Add',
                  style:TextStyle(color:Colors.black),
                ),

                onPressed:() {

                  var label=controllerLabelBill.text;
                  var amount=controllerAmount.text;
                  if(label.isNotEmpty & amount.isNotEmpty & Subcat.isNotEmpty){
                  addTransaction(label, amount, Subcat,widget.category,selectedDate);}
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Transaction Added!'
                    ,style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),),
                    )
                  );

                },

            ),*/
          ],
        ),
      )

    );
  }

  InputDecoration buildInputDecoration() {
    return InputDecoration(
            fillColor: Colors.white,
            filled:true,
            enabledBorder:OutlineInputBorder(
              borderSide:BorderSide(
                color:Colors.white,width:1.0
              )
            ),
            focusedBorder:OutlineInputBorder(
              borderSide: BorderSide(color:Colors.amber,
              width:1.0)
            )
          );
  }
}

