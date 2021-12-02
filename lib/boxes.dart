import 'package:hive/hive.dart';
import 'Transactions.dart';

class needsBoxes{


  static Box<needsTransaction>getTransaction()=>
      Hive.box<needsTransaction>('needsTransaction');
}

class miscellaneousBoxes{

  static Box<miscellaneousTransaction>getTransaction()=>
      Hive.box<miscellaneousTransaction>('miscellaneousTransaction');
}

class healthCareBoxes{

  static Box<healthCareTransaction>getTransaction()=>
      Hive.box<healthCareTransaction>('healthCareTransaction');
}