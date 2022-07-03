import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'usertransaction.dart';
import 'transactions.dart';
import 'transactionList.dart';

class NewTransaction extends StatefulWidget {
  final Function ftx;
  NewTransaction(this.ftx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  // NewTransaction({Key? key}) : super(key: key);
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();
  DateTime _selectedDate = new DateTime(2019);
  // _selectedDate = null;

  void _submitit() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);
    if (enteredAmount <= 0 ||
        enteredTitle.isEmpty ||
        _selectedDate == DateTime(2019)) {
      return;
    }
    widget.ftx(enteredTitle, enteredAmount, _selectedDate);
    Navigator.of(context).pop();
  }

  void _datePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        _selectedDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                maxLength: 10,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Money Spent'),
                // onChanged: (val){amountInput = val;},
                controller: _amountController,
                onSubmitted: (_) => _submitit,
              ),
              TextField(
                maxLength: 25,
                decoration: InputDecoration(labelText: 'Spent Where'),
                // onChanged: (val) => titleInput = val,
                controller: _titleController,
                onSubmitted: (_) => _submitit,
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        _selectedDate == DateTime(2019)
                            ? 'No Date Chosen'
                            : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}',
                      ),
                    ),
                    FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      onPressed: _datePicker,
                      child: Text(
                        'Choose Date',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              RaisedButton(
                child: Text("Add Transaction"),
                // textColor: Theme.of(context).textTheme.titleLarge.color,
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                onPressed: _submitit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
