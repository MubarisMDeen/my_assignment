import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:my_assignment/ItemDataModel.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:my_assignment/showDialogFunc.dart';


int stateIndex = 1;
bool? fruitBoxValue = true;
bool? vegBoxValue = true;

List<ItemDataModel> list = [];
List<ItemDataModel>? items;
List<ItemDataModel> itemso = [];


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Assignment',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Future<List<ItemDataModel>> ReadJsonData() async {
    final jsonData =
    await rootBundle.rootBundle.loadString('json_file/itemlist.json');
    final list = json.decode(jsonData) as List<dynamic>;

    return list.map((e) => ItemDataModel.fromJson(e)).toList();
  }

  void updateState(int stateIndex) {

    setState(() {
      print(stateIndex);
      if (stateIndex == 1)
        items = itemso
            .where((element) =>
        element.category == "Fruits" ||
            element.category == "Vegetables")
            .toList();
      else if (stateIndex == 2)
        items = itemso
            .where((element) => element.category == "Fruits")
            .toList();
      else
        items = itemso
            .where((element) => element.category == "Vegetables")
            .toList();
    });}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Menu",
          style: TextStyle(color: Colors.grey),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.menu),
            color: Colors.grey,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FilterScreen(updateState)));
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: ReadJsonData(),
        builder: (context, data) {
          if (data.hasError)
            return Center(child: Text("${data.error}"));
          else if (data.hasData) {
            var itemso = data.data as List<ItemDataModel>;
            List<ItemDataModel> items = itemso
                .where((element) =>
                    element.category == "Fruits" ||
                    element.category == "Vegetables")
                .toList();
            if (stateIndex == 1)
              items = itemso
                  .where((element) =>
              element.category == "Fruits" ||
                  element.category == "Vegetables")
                  .toList();
            else if (stateIndex == 2)
              items = itemso
                  .where((element) => element.category == "Fruits")
                  .toList();
            else
              items = itemso
                  .where((element) => element.category == "Vegetables")
                  .toList();
            //List<ItemDataModel> filteredItems;



            return ListView.builder(
                itemCount: items == null ? 0 : items.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // This Will Call When User Click On ListView Item
                      ShowDialogFunc(
                          context,
                          items[index].imageurl.toString(),
                          items[index].name.toString(),
                          items[index].price.toString(),
                          items[index].vendor.toString());
                    },
                    // Card Which Holds Layout Of ListView Item
                    child: Card(
                      elevation: 5,
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Container(
                        padding: EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 70,
                              height: 70,
                              child: Image(
                                image: NetworkImage(
                                    items[index].imageurl.toString()),
                                fit: BoxFit.fill,
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(bottom: 8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 5, right: 5),
                                      child: Row(
                                        children: [
                                          Text(
                                            items[index].name.toString(),
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          if (items[index].available == 0)
                                            Text("*Out of Stock*",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.deepOrange),),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 5, right: 5),
                                      child: Text(
                                        items[index].vendor.toString(),
                                        style: TextStyle(
                                            fontSize: 11, color: Colors.grey),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 10, right: 5),
                                      child: Text(
                                        items[index].price.toString(),
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }

                );
          } else
            return Center(
              child: CircularProgressIndicator(),
            );
        },
      ),
    );
  }


}

class FilterScreen extends StatefulWidget {
  final Function updateState;


  FilterScreen(this.updateState);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Filter Items",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
        backgroundColor: Colors.grey,
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              children: [
                Checkbox(
                    value: fruitBoxValue,
                    activeColor: Colors.grey,
                    onChanged: (newValue) {
                      setState(() {
                        fruitBoxValue = newValue;
                        print(fruitBoxValue);
                        if (fruitBoxValue == true && vegBoxValue == true)
                          stateIndex = 1;
                        if (fruitBoxValue == true && vegBoxValue == false)
                          stateIndex = 2;
                        if (fruitBoxValue == false && vegBoxValue == true)
                          stateIndex = 3;
                        widget.updateState(stateIndex);
                      });
                    }),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Fruits',
                  style: TextStyle(color: Colors.blueGrey, fontSize: 20),
                )
              ],
            ),
            Row(
              children: [
                Checkbox(
                    value: vegBoxValue,
                    activeColor: Colors.grey,
                    onChanged: (newValue) {
                      setState(() {
                        vegBoxValue = newValue;
                        print(vegBoxValue);
                        if (fruitBoxValue == true && vegBoxValue == true)
                          stateIndex = 1;
                        if (fruitBoxValue == true && vegBoxValue == false)
                          stateIndex = 2;
                        if (fruitBoxValue == false && vegBoxValue == true)
                          stateIndex = 3;
                        widget.updateState(stateIndex);
                      });
                    }),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Vegetables',
                  style: TextStyle(color: Colors.blueGrey, fontSize: 20),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}


