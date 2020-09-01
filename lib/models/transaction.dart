import 'package:flutter/foundation.dart';

// required decoration introduce by dart language,
// which include in flutter material package,
// but if you want import pacific package than import 'package:flutter/foundation.dart'.
class Transaction {
  final String id;
  final String title;
  final double amount;
  final DateTime date;

  Transaction({
    @required this.id,
    @required this.amount,
    @required this.title,
    @required this.date,
  });
}
