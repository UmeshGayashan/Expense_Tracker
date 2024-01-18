import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expense_tracker/models/income.dart';

class IncomeTile extends StatelessWidget {
  const IncomeTile({Key? key, required this.income, required this.onTap}) : super(key: key);

  final IncomeModel income;
  final void Function() onTap;

  IconData _getCategoryIcon(Category category) {
    switch (category) {
      case Category.Wages:
        return Icons.fastfood;
      case Category.Commision:
        return Icons.sports_soccer;
      case Category.Interest:
        return Icons.work;
      case Category.Investment:
        return Icons.flight;
      case Category.Gift:
        return Icons.local_hospital;
      case Category.Passive:
        return Icons.movie;
      default:
        return Icons.trending_down; // Default icon if category is not recognized
    }
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat.yMd().format(income.date);

    return Card(
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(15.0), // Adjust the border radius as needed
  ),
  elevation: 4,
  margin: EdgeInsets.all(8),
  child: InkWell(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(80, 81, 73, 1),
            Color.fromRGBO(34, 35, 34, 1),
          ], // Add your gradient colors here
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp,
        ),
        borderRadius: BorderRadius.circular(15.0), // Same as the border radius for the Card
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              income.title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.white, // Set the title color to white
              ),
            ),
            const SizedBox(height: 4,),
            Row(
              children: [
                Text(
                  income.amount.toStringAsFixed(2),
                  style: TextStyle(
                    color: Colors.white, // Set the amount color to white
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    Icon(
                      _getCategoryIcon(income.category),
                      color: Colors.white, // Set the icon color to white
                    ),
                    const SizedBox(width: 8,),
                    Text(
                      formattedDate,
                      style: TextStyle(
                        color: Colors.white, // Set the date color to white
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  ),
);

  }
}