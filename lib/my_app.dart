import 'package:flutter/material.dart';
import './restaurants.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurants',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomeScreen(),
    );
  }
}

class MyHomeScreen extends StatefulWidget {
  MyHomeScreen({Key key}) : super(key: key);

  @override
  MyHomeScreenState createState() => MyHomeScreenState();
}

class MyHomeScreenState extends State<MyHomeScreen> {
  String key = '';
  List restaurants = [];
  List filter = [];

  @override
  void initState() {
    super.initState();
    getRestaurants().then((r) {
      restaurants = r;
      filter = r;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    reselectRestaurants();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            padding: EdgeInsets.only(left: 8, right: 8, top: 50, bottom: 20),
            child: TextField(
              onChanged: (text) {
                setState(() => key = text);
                print(text);
              },
              key: ValueKey('edit_search'),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
                hintText: 'Search for restaurants..',
              ),
            ),
          ),
          for (var r in filter)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.network(r['icon'], width: 70, height: 70),
                      ),
                      Expanded(
                        child: Text(
                          r['name'],
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Text(
                        ' ${r['rating']} ',
                        style: TextStyle(
                          backgroundColor: Colors.green,
                          color: Colors.white,
                          fontSize: 22,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    r['types'].join(', '),
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    r['address'],
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
        ]),
      ),
    );
  }

  void reselectRestaurants() {
    List mylist = [];
    for (var r in restaurants) {
      if (r['name'].toLowerCase().contains(key.toLowerCase())) mylist.add(r);
    }
    filter = mylist;
  }
}
