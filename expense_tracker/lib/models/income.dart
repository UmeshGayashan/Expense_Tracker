//create a unique id using uuid

import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';



final uuid= const Uuid().v4();

final formattedDate =DateFormat.yMd();

//enum for category
enum Category{Wages, Commision, Interest, Investment, Gift, Passive}

class IncomeModel{

IncomeModel({
  required this.amount, required this.date, required this.title, required this.category})
  :id =uuid;

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;
}