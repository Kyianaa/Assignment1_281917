import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie  App',
      theme: ThemeData(primarySwatch: Colors.red),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Movie Streaming Apps',
              style: TextStyle(fontSize: 25)),
        ),
        body: const HomePage(
          title: '',
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var desc = "", movie = "";
  String selectMov = "";
  TextEditingController searchText = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("Simple Movie Application",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          TextField(
            controller: searchText,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Search movie',
              hintText: 'Search movie here',
            ),
            onChanged: (text) {
              setState(() {
                selectMov = text;
              });
            },
          ),
          ElevatedButton(onPressed: _getGenre, child: const Text("Search")),
          Text(desc,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Future<void> _getGenre() async {
    AlertDialog alert = AlertDialog(
      content: Row(children: [
        CircularProgressIndicator(
          backgroundColor: Colors.red,
        ),
        Container(margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
      ]),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
    var apiKey = "725d6622";
    var url = Uri.parse('https://www.omdbapi.com/?t=$selectMov&apikey=$apiKey');
    var response = await http.get(url);
    var rescode = response.statusCode;
    if (rescode == 200 && selectMov.isNotEmpty) {
      var jsonData = response.body;
      var parsedJson = json.decode(jsonData);
      setState(() {
        var title = parsedJson["Title"];
        var genre = parsedJson["Genre"];
        var year = parsedJson["Year"];
        var descs = parsedJson["Plot"];
        var poster = parsedJson["Poster"];
        //var image = Image.network('$poster');
        Navigator.pop(context);
        desc =
            "Search result for $selectMov is $title \n\nThis movie genre is $genre and released in $year.\n\n$descs\n\nClick link to view image link\n$poster";
      });
    } else {
      setState(() {
        Navigator.pop(context);
        desc = "No record";
      });
    }
  }
}
