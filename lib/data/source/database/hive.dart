import 'package:hive/hive.dart';

part 'hive.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  late String username;

  @HiveField(1)
  late String password;

  @HiveField(2)
  late bool loginStatus;

  @HiveField(3)
  late int invoiceNumber;

  User({
    required this.username,
    required this.password,
    this.loginStatus = false,
    this.invoiceNumber = 0,
  });
}

@HiveType(typeId: 1)
class Pizza extends HiveObject {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late num smallPrice;

  @HiveField(2)
  late num mediumPrice;

  @HiveField(3)
  late num largePrice;

  @HiveField(4)
  late String image;

  @HiveField(5)
  late String username;
}

@HiveType(typeId: 2)
class Invoice extends HiveObject {
  @HiveField(0)
  late int invoiceNumber;

  @HiveField(1)
  late String customerName;

  @HiveField(2)
  late String date;

  @HiveField(3)
  late String time;

  @HiveField(4)
  late double totalAmount;

  @HiveField(5)
  late num discount;

  @HiveField(6)
  late String items;

  @HiveField(7)
  late String username;
}
