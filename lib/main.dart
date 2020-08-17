import 'package:flutter/material.dart';
import 'package:flutter_housemd_app/episodes_page.dart';
import 'package:flutter_housemd_app/house.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String url =
      "http://api.tvmaze.com/singlesearch/shows?q=house&embed=episodes";

  House house;

  Widget myCard() {
    return SingleChildScrollView(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Hero(
                tag: "g1",
                child: CircleAvatar(
                  radius: 100.0,
                  backgroundImage: NetworkImage(house.image.original),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                house.name,
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "Runtime: ${house.runtime.toString()} minutes",
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                "Sink your teeth into meaty drama and intrigue with House, FOX's take on mystery, where the villain is a medical malady and the hero is an irreverent, controversial doctor who trusts no one, least of all his patients.",
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              RaisedButton(
                color: Colors.red,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EpisodesPage(
                                episodes: house.eEmbedded.episodes,
                                myImage: house.image,
                              )));
                },
                child: Text(
                  "All Episodes",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget myBody() {
    return house == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : myCard();
  }

  @override
  void initState() {
    super.initState();
    fetchEpisodes();
  }

  fetchEpisodes() async {
    var res = await http.get(url);
    var decodedRes = jsonDecode(res.body);
    print(decodedRes);
    house = House.fromJson(decodedRes);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("House M.D."),
      ),
      body: myBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          fetchEpisodes();
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
