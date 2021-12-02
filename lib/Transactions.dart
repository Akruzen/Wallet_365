
import 'package:hive/hive.dart';
part 'Transactions.g.dart'; //model class adapter


@HiveType(typeId:0,adapterName: 'needsTransactionAdapter')
class needsTransaction extends HiveObject {
  @HiveField(0) //once defined number is unique if mistaken then new number
  late DateTime transactionDate;
  @HiveField(1)
  late String label;
  @HiveField(2)
  late String amount;
  @HiveField(3)
  late String subCategory;




}

@HiveType(typeId:1,adapterName: 'miscellaneousTransactionAdapter')
class miscellaneousTransaction extends HiveObject {
  @HiveField(0) //once defined number is unique if mistaken then new number
  late DateTime transactionDate;
  @HiveField(1)
  late String label;
  @HiveField(2)
  late String amount;
  @HiveField(3)
  late String subCategory;



}

@HiveType(typeId:2,adapterName: 'healthCareTransactionAdapter')
class healthCareTransaction extends HiveObject {
  @HiveField(0) //once defined number is unique if mistaken then new number
  late DateTime transactionDate;
  @HiveField(1)
  late String label;
  @HiveField(2)
  late String amount;
  @HiveField(3)
  late String subCategory;



}