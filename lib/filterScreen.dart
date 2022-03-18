import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

bool? fruitBoxValue = true;
bool? vegBoxValue = true;

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
                      });
                    }),
                SizedBox(width: 10,),
                Text('Fruits',style: TextStyle(color: Colors.blueGrey, fontSize: 20),)
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
                      });
                    }),
                SizedBox(width: 10,),
                Text('Vegetables',style: TextStyle(color: Colors.blueGrey, fontSize: 20),)
              ],
            )
          ],
        ),
      ),
    );
  }
}
