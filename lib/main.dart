import 'package:Money_Analyser/widgets/transactionList.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import './widgets/new_transaction.dart';
import 'models/transaction.dart';
import './widgets/chart.dart';

//import './widgets/transactionList.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized(); //required for new flutter version
  // //systemchrome objecct use for device setup in  landscape mode and other
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(PersonalApp());
}

class PersonalApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter App',
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.lightGreen,
          errorColor: Colors.black38,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
                // ignore: deprecated_member_use
                title: TextStyle(fontFamily: 'OpenSans', fontSize: 20),
              ),
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                    // ignore: deprecated_member_use
                    title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
          )),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    Transaction(id: 't1', amount: 100, title: 'books', date: DateTime.now()),
    Transaction(id: 't2', amount: 2500, title: 'shoes', date: DateTime.now()),
  ];
  bool _setshow = false;
// code for transactionbar generate automatically as per week day
  List<Transaction> get _recentTransaction {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  List<Widget> _buildLandscapeContext(AppBar appbar, Widget txlist) {
    return [
      Row(
        //if without { } braces
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('show chart'),
          Switch(
              value: _setshow,
              onChanged: (val) {
                setState(() {
                  _setshow = val;
                });
              })
        ],
      ),
      _setshow
          ? Container(
              height: (MediaQuery.of(context).size.height -
                      appbar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.5,
              child: Chart(_recentTransaction),
            )
          //prefreeedsize property accees height on app bar
          : txlist
    ];
  }

  List<Widget> _buildPortraitContext(AppBar appbar, Widget txlist) {
    return [
      Container(
        height: (MediaQuery.of(context).size.height -
                appbar.preferredSize.height -
                MediaQuery.of(context).padding.top) *
            0.3,
        child: Chart(_recentTransaction),
      ),
      txlist
    ];
  }

  void _addNewTransaction(
      String txTitle, double txamount, DateTime choosenDate) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        amount: txamount,
        title: txTitle,
        date: choosenDate);
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  void _startNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransactions(_addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final isLAndscape = MediaQuery.of(context).orientation ==
        Orientation
            .landscape; //object created for landscape to check landscape or not
    final appbar = AppBar(
      title: Text("Money Control"),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startNewTransaction(context),
        ),
      ],
    );
    final txlist = Container(
        //varivale
        height: (MediaQuery.of(context).size.height -
                appbar.preferredSize.height -
                MediaQuery.of(context).padding.top) *
            0.7,
        child: TransactionList(_userTransactions, _deleteTransaction));
    return Scaffold(
      appBar: appbar,
      body: SingleChildScrollView(
        // SingleChildScrollview use for Scroll the page in App
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            //code for switch which add in row
            if (isLAndscape)
              ..._buildLandscapeContext(appbar, txlist),

            if (!isLAndscape)
              ..._buildPortraitContext(appbar,
                  txlist), //this three dott tell dart to pull out of item add as normal item to outer list
          ],
        ),
      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startNewTransaction(context),
      ),
    );
  }
}
