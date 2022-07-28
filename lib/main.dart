import 'dart:math';

import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/repository/gen_repository.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GenRepository.prepareDatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GenRepository<Product> repository = GenRepository<Product>();
  List<ListTile> tiles = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            ElevatedButton(
                onPressed: () async {
                  await refresh();
                },
                child: const Text("Refresh")),
            ...tiles
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _addRandom();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future _addRandom() async {
    var ppr = Product(name: generateRandomName());
    await repository.addEntity(ppr);
    await refresh();
  }

  String generateRandomName() {
    var letters = <String>[
      "A",
      "B",
      "C",
      "D",
      "E",
      "F",
      "G",
      "H",
      "I",
      "J",
      "K",
      "L",
      "M",
      "N",
      "O",
      "P",
      "Q",
      "R",
      "S",
      "T",
      "U",
      "V",
      "W",
      "X",
      "Y",
      "Z"
    ];
    var random = Random();
    String result = "";
    for (int x = 0; x < 8; x++) {
      var num = random.nextInt(25);
      result += letters[num];
    }
    return result;
  }

  @override
  void initState() {
    restoreMainPageData();
  }

  void restoreMainPageData() async {
    var items = await repository.getAllEntities(Product.TABLE_NAME);
    setState(() {
      tiles = items.map((e) => createProductTile(e)).toList();
    });
  }

  ListTile createProductTile(Map<String, Object?> e) {
    var product = Product.fromMap(e);
    return ListTile(
      tileColor: Colors.blueAccent.withOpacity(0.2),
      onTap: () async {
        await deleteProduct(product);
      },
      title: Text(product.name),
    );
  }

  Future deleteProduct(Product product) async {
    await repository.deleteEntity(product);
    await refresh();
  }

  Future refresh() async {
    var items = await repository.getAllEntities(Product.TABLE_NAME);
    setState(() {
      tiles = items.map((e) => createProductTile(e)).toList();
    });
  }
}
/*
name: ecommerce
description: A new Flutter project.

dependencies:
  flutter:
    sdk: flutter
  sqflite: ^2.0.3
  path_provider: ^2.0.11
  path: ^1.8.1

 */