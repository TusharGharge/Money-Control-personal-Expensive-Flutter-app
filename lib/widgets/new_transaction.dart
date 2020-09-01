import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransactions extends StatefulWidget {
  final Function addTx;

  NewTransactions(this.addTx);

  @override
  _NewTransactionsState createState() => _NewTransactionsState();
}

class _NewTransactionsState extends State<NewTransactions> {
  final _titlecontroller = TextEditingController();

  final _amountcontroller = TextEditingController();
  DateTime _selectedDate;

  void _submitData() {
    if (_amountcontroller.text.isEmpty) {
      return;
    }
    // function iis created to call button with title and amount statement callback to flatbutton
    final entertitle = _titlecontroller.text;
    final enteramount = double.parse(_amountcontroller.text);
    if (entertitle.isEmpty || enteramount <= 0 || _selectedDate == null) {
      return;
    }
    widget.addTx(
      entertitle,
      enteramount,
      _selectedDate,
    );
    Navigator.of(context).pop(); // to close the + icon tab web its done
  }

  ///date picker
  void _presentDatePicker() {
    // funtion for date picker
    showDatePicker(
      context: context, // context
      initialDate: DateTime.now(), //
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        //this method use in flutter
        _selectedDate = pickedDate;
      });
    });
    //then allow user to add future funtion in date picker
    // then is function made by dart language which use in flutter
    print("...");
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom +
                  10), //viewInsert use for smooth keyboard
          // margin: EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: _titlecontroller,
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: _amountcontroller,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(), // idont use it pass _
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(_selectedDate == null
                        ? 'No Date Choosen'
                        : 'picked Date:${DateFormat.yMd().format(_selectedDate)}'),
                  ),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    child: Text('Choose Date',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        )),
                    onPressed: _presentDatePicker,
                  ),
                ],
              ),
              RaisedButton(
                child: Text('Submit Transaction'),
                color: Colors.purple,
                textColor: Colors.white,
                onPressed: _submitData,
              )
            ],
          ),
        ),
      ),
    );
  }
}
