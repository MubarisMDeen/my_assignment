import 'package:flutter/material.dart';
import 'package:my_assignment/itemDataModel.dart';
import 'package:flutter/services.dart' as rootBundle;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Assignment',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'My Assignment'),
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


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      
    );
  }


  Future<List<ItemDataModel>>ReadJsonData() async{
    final jsonData = await rootBundle.rootBundle.loadString('json_file/itemlist.json');
    final list = json.decode(jsonData) as List<dynamic>;

    return list.map((e) => ItemDataModel.fromJson(e)).toList();
  }

}
