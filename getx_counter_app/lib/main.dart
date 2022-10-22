import 'package:flutter/material.dart';

//import get package
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // create variable that hold out number with .obs parameter (.obs comes from getx state management)
    var _counter = 0.obs;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Counter app with Getx (Get) state management"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),

              // in get (getx) we must ue Obx for the widget that we want to change like setState in statefull widget\
              Obx(() => Text(
                    // we can show our variable by call .value method
                    '${_counter.value}',
                    style: Theme.of(context).textTheme.headline4,
                  )),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          // we can plus or everything that we want by add .value method to our obs variable
          onPressed: () => _counter.value++,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ));
  }
}
