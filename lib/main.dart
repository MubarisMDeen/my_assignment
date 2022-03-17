import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:my_assignment/ItemDataModel.dart';
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
      home:  MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: FutureBuilder(
        future: ReadJsonData(),
        builder: (context,data){
          if(data.hasError)
            return Center(child: Text("${data.error}"));
          else if(data.hasData){
            var items =data.data as List<ItemDataModel>;
           return ListView.builder(
               itemCount: items == null? 0: items.length,
               itemBuilder: (context,index){
                 return Card(
                   elevation: 5,
                   margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                   child: Container(
                     padding: EdgeInsets.all(8),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       crossAxisAlignment: CrossAxisAlignment.center,
                       children: [
                         Container(
                           width: 50,
                           height: 50,
                           child: Image(image: NetworkImage(items[index].imageurl.toString()),fit: BoxFit.fill,),
                         ),
                         SizedBox(width: 10),
                         Expanded(child: Container(
                         padding: EdgeInsets.only(bottom: 8),
                 child: Column(
                           mainAxisAlignment: MainAxisAlignment.center,
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Padding(padding: EdgeInsets.only(left: 5, right: 5),child: Text(
                               items[index].name.toString(),style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                             ),),
                             Padding(padding: EdgeInsets.only(left: 10, right: 5),child: Text(
                               items[index].price.toString(),style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.red),
                             ),),
                             Padding(padding: EdgeInsets.only(left: 5, right: 5),child: Text(
                               items[index].vendor.toString(),style: TextStyle(fontSize: 13),
                             ),),
                             Padding(padding: EdgeInsets.only(left: 5, right: 5),child: Text(
                               items[index].category.toString(),style: TextStyle(fontSize: 13,color: Colors.grey),
                             ),),
                           ],
                         ),),
                         )],
                     ),
                   ),
                 );
               }


           );
          }
          else
            return Center(child: CircularProgressIndicator(),);
        },
      ),
    );
  }


  Future<List<ItemDataModel>>ReadJsonData() async{
    final jsonData = await rootBundle.rootBundle.loadString('json_file/itemlist.json');
    final list = json.decode(jsonData) as List<dynamic>;

    return list.map((e) => ItemDataModel.fromJson(e)).toList();
  }

}
