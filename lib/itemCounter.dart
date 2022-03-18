import 'package:flutter/material.dart';

class ItemCounter extends StatefulWidget {
  final String? title;

  ItemCounter({this.title});

  @override
  State<ItemCounter> createState() => _ItemCounterState(title);
}

class _ItemCounterState extends State<ItemCounter> {
  final String? title;

  _ItemCounterState(this.title);

  int _counter = 1;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Count  : ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                '$_counter',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                width: 5,
              ),
              FloatingActionButton(
                elevation: 0,
                onPressed: _incrementCounter,
                tooltip: 'Increment',
                child: const Icon(
                  Icons.add,
                  color: Colors.black,
                ),
                backgroundColor: Colors.white,
              ),
            ],
          ),
          ElevatedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                          title: Text('Purchased!'),
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                _counter.toString(),
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                title.toString(),
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              if (_counter > 1&&title!="Drumsticks")
                                Text(
                                  's',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                            ],
                          ),
                        ));
              },
              child: Text(
                "Purchase",
                style: TextStyle(fontSize: 30),
              )),
        ],
      ),
    );
  }
}
