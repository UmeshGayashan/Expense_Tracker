import 'package:expense_tracker/models/expence.dart';
import 'package:expense_tracker/widgets/expenceTile.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenceList extends StatelessWidget {
  final List<ExpenceModel> expenceList;
  final void Function(ExpenceModel expence) onDeleteExpence;

  const ExpenceList({Key? key, required this.expenceList, required this.onDeleteExpence}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: expenceList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 5,
            ),
            child: Dismissible(
              key: ValueKey(expenceList[index]),
              direction: DismissDirection.startToEnd,
              onDismissed: (direction) {
                onDeleteExpence(expenceList[index]);
              },
              child: ExpenceTile(
                expence: expenceList[index],
                onTap: () {
                  // Open a detailed dialog
                  _showDetailsDialog(context, expenceList[index]);
                },
              ),
            ),
          );
        },
      ),
    );
  }

  void _showDetailsDialog(BuildContext context, ExpenceModel expence) {
    // Format the amount in Rs.
    final formattedAmount = NumberFormat.currency(symbol: 'Rs.').format(expence.amount);
    // Format the date without time
    final formattedDate = DateFormat.yMd().format(expence.date);

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
                Text("Title: ${expence.title}"),
                Text("Category: ${expence.category.toString()}"),
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
                      builder: (context) => AddNewExpenseScreen(expense: expence),
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
  final ExpenceModel expense;

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
