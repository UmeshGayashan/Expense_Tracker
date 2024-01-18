//create a unique id using uuid

import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:hive/hive.dart';

part 'expence.g.dart';

final uuid= const Uuid().v4();

final famattedDate =DateFormat.yMd();

//enum for category
enum Category{food, leasure, work, travel, health, entertainment, subscriptions}

@HiveType(typeId: 1)

class ExpenceModel{

ExpenceModel({
  required this.amount, required this.date, required this.title, required this.category})
  :id =uuid;

  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final double amount;

  @HiveField(3)
  final DateTime date;

  @HiveField(4)
  final Category category;
}