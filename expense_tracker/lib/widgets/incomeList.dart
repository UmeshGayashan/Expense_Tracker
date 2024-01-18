import 'package:expense_tracker/models/income.dart';
import 'package:expense_tracker/widgets/incomeTile.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class IncomeList extends StatelessWidget {
  final List<IncomeModel> incomeList;
  final void Function(IncomeModel income) onDeleteIncome;

  const IncomeList({Key? key, required this.incomeList, required this.onDeleteIncome}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: incomeList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 5,
            ),
            child: Dismissible(
              key: ValueKey(incomeList[index]),
              direction: DismissDirection.startToEnd,
              onDismissed: (direction) {
                onDeleteIncome(incomeList[index]);
              },
              child: IncomeTile(
                income: incomeList[index],
                onTap: () {
                  // Open a detailed dialog
                  _showDetailsDialog(context, incomeList[index]);
                },
              ),
            ),
          );
        },
      ),
    );
  }

  void _showDetailsDialog(BuildContext context, IncomeModel income) {
    // Format the amount in Rs.
    final formattedAmount = NumberFormat.currency(symbol: 'Rs.').format(income.amount);
    // Format the date without time
    final formattedDate = DateFormat.yMd().format(income.date);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Theme(
          data: Theme.of(context).copyWith(
            dialogBackgroundColor: Colors.white, // Set your background color
            // Customize other AlertDialog styles here
          ),
          child: AlertDialog(
            title: Text("Expense Details"),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Title: ${income.title}"),
                Text("Category: ${income.category.toString()}"),
                Text("Amount: $formattedAmount"),
                Text("Date: $formattedDate"),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  // Navigate to the Edit screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddNewExpenseScreen(expense: income),
                    ),
                  );
                },
                child: Text("Edit"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Close"),
              ),
            ],
          ),
        );
      },
    );
  }
}

class AddNewExpenseScreen extends StatefulWidget {
  final IncomeModel expense;

  const AddNewExpenseScreen({Key? key, required this.expense}) : super(key: key);

  @override
  _AddNewExpenseScreenState createState() => _AddNewExpenseScreenState();
}

class _AddNewExpenseScreenState extends State<AddNewExpenseScreen> {
  // Implement your edit screen here
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Expense"),
      ),
      body: Center(
        //child: Text("Edit Screen"),
      ),
    );
  }
}