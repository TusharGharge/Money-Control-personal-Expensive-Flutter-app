import '../models/transaction.dart';
import 'package:flutter/material.dart';
import './Trasactionfile.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  final Function deletetx;
  TransactionList(this.transactions, this.deletetx);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 400,
        child: transactions.isEmpty
            ? LayoutBuilder(builder: (ctx, constraints) {
                return Column(
                  children: <Widget>[
                    Text('No Transaction yet|'),
                    SizedBox(height: 20),
                    Container(
                        height: constraints.maxHeight * 0.6,
                        child: Image.asset('assets/images/empty.jfif',
                            fit: BoxFit.cover))
                  ],
                );
              })
            : ListView(
                children: transactions
                    .map((tx) => TransactionItem(
                        key: ValueKey(tx.id),
                        transaction: tx,
                        deletetx: deletetx))
                    .toList(),
              ));
  }
}
