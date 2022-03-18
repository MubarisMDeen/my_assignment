import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:my_assignment/ItemDataModel.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:my_assignment/filterScreen.dart';

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
                  MaterialPageRoute(builder: (context) => FilterScreen()));
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
            var items = data.data as List<ItemDataModel>;
            return ListView.builder(
                itemCount: items == null ? 0 : items.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // This Will Call When User Click On ListView Item
                      showDialogFunc(
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
                                      child: Text(
                                        items[index].name.toString(),
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
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
                });
          } else
            return Center(
              child: CircularProgressIndicator(),
            );
        },
      ),
    );
  }



  Future<List<ItemDataModel>> ReadJsonData() async {
    final jsonData =
        await rootBundle.rootBundle.loadString('json_file/itemlist.json');
    final list = json.decode(jsonData) as List<dynamic>;

    return list.map((e) => ItemDataModel.fromJson(e)).toList();
  }
}




showDialogFunc(context, img, title, cost, vend) {
  return showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: Material(
          type: MaterialType.transparency,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            padding: EdgeInsets.all(15),
            height: 620,
            width: MediaQuery.of(context).size.width * 0.9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image(
                      image: NetworkImage(img),
                    )),
                SizedBox(
                  height: 30,
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 35,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  vend,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  // width: 200,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      cost,
                      maxLines: 3,
                      style: TextStyle(fontSize: 35, color: Colors.redAccent,fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}