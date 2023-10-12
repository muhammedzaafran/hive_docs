import 'package:flutter/material.dart';
import 'package:hive_docs/bank_account.dart';
import 'package:hive_flutter/hive_flutter.dart';

late Box box;

Future<void> main() async
{
  await Hive.initFlutter();
  box = await Hive.openBox('box');
  Hive.registerAdapter(BankAccountAdapter());
  box.put('bankAccount', BankAccount(currency: "\$USD", myMoney: 10000));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    BankAccount bankAccount = box.get('bankAccount');

    return Scaffold(
        appBar: AppBar(
          title: Text("${bankAccount.currency} ${bankAccount.myMoney}"),)
    );
  }
}