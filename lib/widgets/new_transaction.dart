import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final Function(String title, double amount) updateState;
  NewTransaction(this.updateState);

  void submitData() {
    final enteredTitle = titleController.text;
    final enterAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enterAmount <= 0) {
      return;
    }

    updateState(
      enteredTitle,
      enterAmount,
    );
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
            FlatButton(
              onPressed: submitData,
              textColor: Colors.purple,
              child: Text('Add transaction'),
            ),
          ],
        ),
      ),
    );
  }
}
