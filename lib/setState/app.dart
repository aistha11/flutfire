import 'package:flutter/material.dart';

class SetStateApp extends StatelessWidget {
  const SetStateApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "SetState App",
      home: CounterView(),
    );
  }
}

class CounterView extends StatefulWidget {
  const CounterView({
    Key? key,
  }) : super(key: key);

  @override
  State<CounterView> createState() => _CounterViewState();
}

class _CounterViewState extends State<CounterView> {
  
  var count = 0;

  increment() {
    setState(() {
      count++;
    });
  }

  decrement() {
    setState(() {
      count--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Counter with setState"),
      ),
      body: Container(
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FloatingActionButton(
                onPressed: () {
                  decrement();
                },
                child: Icon(Icons.remove),
              ),
              Text("$count"),
              FloatingActionButton(
                onPressed: () {
                  increment();
                },
                child: Icon(Icons.add),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
