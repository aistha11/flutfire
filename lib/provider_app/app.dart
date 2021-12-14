import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'counter/counterProvider.dart';

class ProviderApp extends StatelessWidget {
  const ProviderApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Provider App",
      home: ProviderCounterView(),
    );
  }
}

class ProviderCounterView extends StatelessWidget {
  const ProviderCounterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Counter with Provider"),
      ),
      body: Container(
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FloatingActionButton(
                onPressed: () {
                  // Provider.of<CounterProvider>(context).decrement();
                  context.read<CounterProvider>().decrement();
                },
                child: Icon(Icons.remove),
              ),
              Text("${context.watch<CounterProvider>().count}"),
              FloatingActionButton(
                onPressed: () {
                  context.read<CounterProvider>().increment();
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
