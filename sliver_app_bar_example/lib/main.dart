import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            expandedHeight: 240,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Sliver App Bar Demo'),
              background: Image.network(
                'https://images.unsplash.com/photo-1664568363162-4cdb797204a0?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=435&q=80',
                fit: BoxFit.cover,
              ),
            ),
            floating: true,
          ),
        ],
        body: ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: 30,
            itemBuilder: (context, index) => ListTile(
                  title: Text('Item $index'),
                ),
            separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                )),
      ),
    );
  }
}
