import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function(String, double, DateTime) updateState;
  NewTransaction(this.updateState);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime? _selectedDate;

  void submitData() {
    if (amountController.text.isEmpty) {
      return;
    }

    final enteredTitle = titleController.text;
    final enterAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enterAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.updateState(
      enteredTitle,
      enterAmount,
      _selectedDate!,
    );
    Navigator.of(context).pop();
  }

  void presentDatePicker() {
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
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
              onSubmitted: (_) => submitData(),
            ),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Amount'),
              onSubmitted: (_) => submitData(),
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? 'No Date Chosen!'
                          : 'Picked Date: ${(DateFormat.yMd().format(_selectedDate!).toString())}',
                    ),
                  ),
                  TextButton(
                    onPressed: presentDatePicker,
                    child: Text(
                      'Choose Date',
                    ),
                  )
                ],
              ),
            ),
            RaisedButton(
              onPressed: submitData,
              color: Theme.of(context).primaryColor,
              child: Text('Add transaction'),
            ),
          ],
        ),
      ),
    );
  }
}
