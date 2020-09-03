import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'model.dart';
import 'article-screen.dart';

String API_KEY = '7522f4abcbc34261b57fa62f1a71dbde';
Future<List<Source>> fetchNewsSource(List<String> categories) async {
  final response =
      await http.get('https://newsapi.org/v2/sources?apiKey=${API_KEY}');
  if (response.statusCode == 200) //HTTP OK
  {
    List sources = json.decode(response.body)['sources'];
    sources.map((source) => new Source.fromJson(source));

    List<Source> info =
        sources.map((source) => new Source.fromJson(source)).toList();
    info.removeWhere((element) => !categories.contains(element.category));
    return info.toList();
  } else {
    throw Exception('Failed to load source list');
  }
}

class SourceScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SourceScreenState();
}

class SourceScreenState extends State<SourceScreen> {
  var list_sources;
  List<String> _categories;
  var refreshkey = GlobalKey<RefreshIndicatorState>();
  Future<SharedPreferences> prefs;

  @override
  void initState() {
    prefs = SharedPreferences.getInstance();
    prefs.then((sharedPref) {
      try {
        _categories = sharedPref.getStringList("categories");
        _categories.removeWhere((element) => element.contains(" false"));
        _categories =
            _categories.map((e) => e.split(" ")[0].toLowerCase()).toList();
        refreshListSource();
      } catch (e) {
        print(e.toString());
        Navigator.of(context).pushReplacementNamed('/filter');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Headlines'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                Navigator.of(context).pushNamed('/logout');
              }),
          IconButton(
              icon: Icon(Icons.account_circle),
              onPressed: () {
                Navigator.of(context).pushNamed('/profile');
              }),
        ],
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: RefreshIndicator(
            key: refreshkey,
            child: FutureBuilder<List<Source>>(
                future: list_sources,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    List<Source> sources = snapshot.data;
                    return new ListView(
                        children: sources
                            .map((source) => GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ArticleScreen(source: source)));
                                  },
                                  child: Card(
                                    elevation: 1.0,
                                    color: Colors.white,
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 14.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 2.0),
                                          width: 100.0,
                                          height: 140.0,
                                          child: Image.asset("assets/ind.png"),
                                        ),
                                        Expanded(
                                            child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Expanded(
                                                    child: Container(
                                                  margin: const EdgeInsets.only(
                                                      top: 20.0, bottom: 10.0),
                                                  child: Text('${source.name}',
                                                      style: TextStyle(
                                                          fontSize: 18.0,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ))
                                              ],
                                            ),
                                            Container(
                                              child: Text(
                                                  '${source.description}',
                                                  style: TextStyle(
                                                      color: Colors.blueGrey,
                                                      fontSize: 12.0,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                            Container(
                                              child: Text(
                                                  'Category : ${source.category}',
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 14.0,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                          ],
                                        ))
                                      ],
                                    ),
                                  ),
                                ))
                            .toList());
                  }
                  return SizedBox(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator());
                }),
            onRefresh: refreshListSource),
      ),
    );
  }

  Future<Null> refreshListSource() async {
    refreshkey.currentState?.show(atTop: false);
    setState(() {
      list_sources = fetchNewsSource(_categories);
    });
    return null;
  }
}
