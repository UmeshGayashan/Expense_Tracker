import 'package:expense_tracker/models/expence.dart';
// import 'package:expense_tracker/models/income.dart';
import 'package:hive/hive.dart';

class Database{
  //create a database reference
  final _myBox = Hive.box("expenceDatabase");
  // final _myBox1 = Hive.box("incomeDatabase");

  List<ExpenceModel> expenceList=[];

  //create the init expence list function

  void createInitialDatabase(){
    expenceList =[
        ExpenceModel(amount: 18.25, date: DateTime.now(), title: "Cheese Pasta", category:Category.food ),
        ExpenceModel(amount: 35.0, date: DateTime.now(), title: "Vitermin C", category: Category.health),
        ExpenceModel(amount: 45.50, date: DateTime.now(), title: "VollyBall", category: Category.leasure),
        ExpenceModel(amount: 20.50, date: DateTime.now(), title: "Kandy", category: Category.travel)
      ]; //_ put to that bacause it is private

    }

    //load data

    void loadData(){
      final dynamic data = _myBox.get("EXP_DATA");

      //validate the data
      if(data != null && data is List<dynamic>){
        expenceList=data.cast<ExpenceModel>().toList();
      }
    }

    //update data

    Future <void> updateData () async {
      await _myBox.put("EXP_DATA", expenceList);
      print("data saved");
    }
}