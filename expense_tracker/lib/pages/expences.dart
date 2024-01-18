import 'package:expense_tracker/models/expence.dart';
import 'package:expense_tracker/widgets/addNewExpence.dart';
import 'package:expense_tracker/widgets/expenceList.dart';
import 'package:expense_tracker/pages/settings.dart';
import 'package:expense_tracker/pages/incomes.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pie_chart/pie_chart.dart';

import '../server/database.dart';

class Expences extends StatefulWidget {
  const Expences({Key? key});

  @override
  State<Expences> createState() => _ExpencesState();
}

class _ExpencesState extends State<Expences> {
  final _myBox = Hive.box("expenceDatabase");
  Database db = Database();

  final gradientList = <List<Color>>[
    [
      Color.fromRGBO(223, 250, 92, 1),
      Color.fromRGBO(129, 250, 112, 1),
    ],
    [
      Color.fromRGBO(129, 182, 205, 1),
      Color.fromRGBO(91, 253, 199, 1),
    ],
    [
      Color.fromRGBO(175, 63, 62, 1.0),
      Color.fromRGBO(254, 154, 92, 1),
    ]
  ];

  Map<String, double> dataMap = {
    "Food": 0,
    "Leasure": 0,
    "Work": 0,
    "Travel": 0,
    "Health": 0,
    "Entertainment": 0,
  };

  void onAddNewExpence(ExpenceModel expence) {
    setState(() {
      db.expenceList.add(expence);
      calCategoryValues();
    });
    db.updateData();
  }

  void onDeleteExpence(ExpenceModel expence) {
    ExpenceModel deletingExpence = expence;
    final int removingIndex = db.expenceList.indexOf(expence);

    setState(() {
      db.expenceList.remove(expence);
      db.updateData();
      calCategoryValues();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("The Expense was deleted successfully!"),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              db.expenceList.insert(removingIndex, deletingExpence);
              db.updateData();
              calCategoryValues();
            });
          },
        ),
      ),
    );
  }

  double foodVal = 0;
  double leasureVal = 0;
  double workVal = 0;
  double travelVal = 0;
  double healthVal = 0;
  double entertainmentVal = 0;

  void calCategoryValues() {
    double foodValTotal = 0;
    double leasureValTotal = 0;
    double workValTotal = 0;
    double travelValTotal = 0;
    double healthValTotal = 0;
    double entertainmentValTotal = 0;

    for (final expence in db.expenceList) {
      if (expence.category == Category.food) {
        foodValTotal += expence.amount;
      } else if (expence.category == Category.leasure) {
        leasureValTotal += expence.amount;
      } else if (expence.category == Category.work) {
        workValTotal += expence.amount;
      } else if (expence.category == Category.travel) {
        travelValTotal += expence.amount;
      } else if (expence.category == Category.health) {
        healthValTotal += expence.amount;
      } else if (expence.category == Category.entertainment) {
        entertainmentValTotal += expence.amount;
      }
    }

    setState(() {
      foodVal = foodValTotal;
      leasureVal = leasureValTotal;
      workVal = workValTotal;
      travelVal = travelValTotal;
      healthVal = healthValTotal;
      entertainmentVal = entertainmentValTotal;
    });

    dataMap = {
      "Food": foodVal,
      "Leasure": leasureVal,
      "Work": workVal,
      "Travel": travelVal,
      "Health": healthVal,
      "Entertainment": entertainmentVal,
    };
  }

  void _openAddExpencesOverlay() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return AddNewExpence(
          onAddExpence: onAddNewExpence,
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();

    if (_myBox.get("EXP_DATA") == null) {
      db.createInitialDatabase();
      calCategoryValues();
    } else {
      db.loadData();
      calCategoryValues();
    }
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
                MaterialPageRoute(builder: (context) => const SettingsView()),
              );
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
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
            hint: const Text('EXPENSE OVERVIEW'),
          ),
          PieChart(
            dataMap: dataMap,
            animationDuration: Duration(milliseconds: 800),
            chartLegendSpacing: 50,
            chartRadius: MediaQuery.of(context).size.width / 1.8,
            initialAngleInDegree: 0,
            chartType: ChartType.disc,
            centerText: "",
            legendOptions: const LegendOptions(
              showLegendsInRow: false,
              legendPosition: LegendPosition.right,
              showLegends: true,
              legendTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            chartValuesOptions: const ChartValuesOptions(
              showChartValueBackground: true,
              showChartValues: true,
              showChartValuesInPercentage: false,
              showChartValuesOutside: false,
              decimalPlaces: 1,
            ),
            gradientList: const [
  [Color(0xFF42A5F5), Color(0xFF1976D2), Color(0xFF64B5F6)], // Blue shades
  [Color(0xFF4CAF50), Color(0xFF388E3C), Color(0xFF66BB6A)], // Green shades
  [Color(0xFFFFC107), Color(0xFFFF9800), Color(0xFFFFD54F)], // Amber shades
  [Color(0xFF9C27B0), Color(0xFF673AB7), Color(0xFFAB47BC)], // Purple shades
  [Color(0xFFE91E63), Color(0xFFC2185B), Color(0xFFEC407A)], // Pink shades
  [Color(0xFF795548), Color(0xFF5D4037), Color(0xFF8D6E63)], // Brown shades
  [Color(0xFF8BC34A), Color(0xFF689F38), Color(0xFFAED581)], // Light green shades
],

          ),
          ExpenceList(expenceList: db.expenceList, onDeleteExpence: onDeleteExpence),
        ],
      ),
      floatingActionButton: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          height: 67,
          child: FloatingActionButton.extended(
        onPressed: () {
          // Handle the second button press
          Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Incomes()),
              );
        },
        icon: const Icon(Icons.trending_up),
        label: const Text("Income Overview"),
        backgroundColor: Colors.blue, // Customize the color as needed
          ),
        ),
        const Divider(),
        SizedBox(
          height: 67,
          child: FloatingActionButton(
            onPressed: _openAddExpencesOverlay,
            child: const Icon(Icons.add),
            backgroundColor: Colors.purple,
          ),
        ),
      ],
      ),
    );
  }
}
