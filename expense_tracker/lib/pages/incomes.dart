import 'package:expense_tracker/models/income.dart';
import 'package:expense_tracker/widgets/addNewIncome.dart';
import 'package:expense_tracker/widgets/incomeList.dart';
import 'package:expense_tracker/pages/settings.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class Incomes extends StatefulWidget {
  const Incomes({super.key});

  @override
  State<Incomes> createState() => _IncomesState();
}

class _IncomesState extends State<Incomes> {
//expenselist
final List <IncomeModel> _expenseList=[
  IncomeModel(amount: 18.25, date: DateTime.now(), title: "January", category:Category.Wages ),
  IncomeModel(amount: 35.0, date: DateTime.now(), title: "BitCoin", category: Category.Investment),
  IncomeModel(amount: 45.50, date: DateTime.now(), title: "Fixed Deposit", category: Category.Interest),
  IncomeModel(amount: 20.50, date: DateTime.now(), title: "Loan", category: Category.Commision)
]; //_ put to that bacause it is private

Map<String, double> dataMap={
  "Wages":0,
  "Commision":0,
  "Interest":0,
  "Invsetment":0,
  "Gift":0,
  "Passive":0,
};

void onAddNewIncome(IncomeModel income){
  setState(() {
    _expenseList.add(income);
    calCategoryValues();
  });
}

//remove a income
void onDeleteincome(IncomeModel income){
  //store the deleting expense
  IncomeModel deletingincome=income;
  //get the right index after undoing the deleting
  final int removingIndex=_expenseList.indexOf(income);

  setState(() {
    _expenseList.remove(income);
    calCategoryValues();
  });
  //show snackbar
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: const Text("The income deleting is successfully!"),
    action: SnackBarAction(
      label: "undo",
      onPressed: (){
        setState(() {
          _expenseList.insert(removingIndex, deletingincome);
          calCategoryValues();
        });
      },
    ), 
  ),
  );
}

//pie chart
double foodVal=0;
double leasureVal=0;
double workVal=0;
double travelVal=0;
double healthVal=0;
double entertainmentVal=0;

void calCategoryValues(){
  double foodValTotal=0;
  double leasureValTotal=0;
  double workValTotal=0;
  double travelValTotal=0;
  double healthValTotal=0;
  double entertainmentValTotal=0;

  for (final income in _expenseList){
    if(income.category==Category.Wages){
      foodValTotal+=income.amount;
    }
    if(income.category==Category.Commision){
      leasureValTotal+=income.amount;
    }
    if(income.category==Category.Interest){
      workValTotal+=income.amount;
    }
    if(income.category==Category.Investment){
      travelValTotal+=income.amount;
    }
    if(income.category==Category.Gift){
      healthValTotal+=income.amount;
    }
    if(income.category==Category.Passive){
      entertainmentValTotal+=income.amount;
    }
  }
  setState(() {
    foodVal=foodValTotal;
    leasureVal=leasureValTotal;
    workVal=workValTotal;
    travelVal=travelValTotal;
    healthVal=healthValTotal;
    entertainmentVal=entertainmentValTotal;
  });

  //update data map
  dataMap={
  "Wages":foodVal,
  "Commission":leasureVal,
  "Interset":workVal,
  "Investment":travelVal,
  "Gift":healthVal,
  "Passive":entertainmentVal,
  };
}
//function to open a model overplay
void _openAddIncomesOverlay(){
  showModalBottomSheet(
    context: context, 
    builder: (context){
    return AddNewIncome(onAddIncome: onAddNewIncome,);
  },
  );
}
@override
  void initState() {
        super.initState();
        calCategoryValues();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense Tracker"),
        backgroundColor: Colors.purple,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
                    Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SettingsView()), // Assuming SettingsView is your settings screen
                    );
            },
            // onPressed: _openAddIncomesOverlay,
            icon:const Icon(Icons.settings),)],
      ),
    body: Column(
      children: [
        // Add DropdownButton and DropdownMenuItem
        DropdownButton<String>(
          items: <String>['Monthly', 'Weekly', 'Daily'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? newValue) {
            // Handle dropdown selection
          },
          hint: const Text('INCOME OVERVIEW'), // Add a hint or default value
        ),
        PieChart(dataMap: dataMap),
        IncomeList(incomeList: _expenseList, onDeleteIncome: onDeleteincome),
      ],
    ),
    floatingActionButton: SizedBox(
      height: 67,
      child: FloatingActionButton(
        onPressed: _openAddIncomesOverlay,
        child: Icon(Icons.add),
        backgroundColor: Colors.purple,
      ),
    ),
    // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
  );
  }
}