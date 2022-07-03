import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'transactions.dart';
import 'package:intl/intl.dart';
import 'usertransaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deletetx;

  TransactionList(this.transactions, this.deletetx);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? Column(
            children: const <Widget>[
              Text(
                "No DATA H ERE",
              ),
            ],
          )
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8,horizontal: 5),
                elevation: 5,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FittedBox(
                          child: Text('\$${transactions[index].amount}'),
                      ),
                    ),
                  ),
                  title: Text(
                    transactions[index].title,
                    style:  Theme.of(context).textTheme.titleLarge,
                  ),
                  subtitle:Text(
                    DateFormat.yMMMd().format(transactions[index].date),
                    // style:  Theme.of(context).textTheme.titleSmall,
                  ),
                  trailing:  IconButton(
                    icon: Icon(Icons.delete),
                        color: Theme.of(context).errorColor,
                        onPressed:() => deletetx(transactions[index].id),
                  ),

                ),
              );
            },
            itemCount: transactions.length,
            // children: transactions.map((tx) {
            //   return
            // }).toList(),
          );
  }
}

// return Card(
// child: Row(
// children: <Widget>[
// Container(
// margin: const EdgeInsets.symmetric(
// vertical: 10,
// horizontal: 15,
// ),
// decoration: BoxDecoration(
// border: Border.all(
// color: Theme.of(context).primaryColor,
// width: 2,
// ),
// ),
// padding: EdgeInsets.all(10),
// child: Text(
// transactions[index].amount.toStringAsFixed(2),
// style: Theme.of(context).textTheme.titleLarge,
// ),
// ),
// Column(
// mainAxisAlignment: MainAxisAlignment.start,
// crossAxisAlignment: CrossAxisAlignment.start,
// children: <Widget>[
// Text(transactions[index].title,
// style: Theme.of(context).textTheme.titleLarge),
// Text(
// DateFormat().format(transactions[index].date),
// // tx.date.toString(),
// style: const TextStyle(
// fontSize: 11,
// color: Colors.grey,
// ),
// ),
// ],
// )
// ],
// ),
// );
