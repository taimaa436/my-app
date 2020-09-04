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
  Map<String, MaterialColor> _categoriesColors = {
    "General": Colors.grey,
    "Business": Colors.red,
    "Entertainment": Colors.brown,
    "Health": Colors.green,
    "Science": Colors.deepPurple,
    "Sports": Colors.blue,
    "Technology": Colors.lime
  };

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
        title: Text('Top Sources'),
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
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),topRight: Radius.circular(20)),
                                      ),
                                      elevation: 1.0,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 4.0, horizontal: 8.0),
                                      child: Container(
                                        height: 150,
                                        //padding: EdgeInsets.all(10),
                                        child: Row(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: _categoriesColors[
                                                      "${source.category[0].toUpperCase()}${source.category.substring(1)}"],
                                                  ),
                                              padding:EdgeInsets.only(left: 20),
                                              margin:
                                                  EdgeInsets.only(right: 10),
                                              width: 6,
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .center,
                                                children: <Widget>[
                                                  Container(
                                                    padding: EdgeInsets.only(bottom: 8),
                                                    child: Text(
                                                        '${source.name}',
                                                        style: TextStyle(
                                                            fontSize: 24.0,
                                                            letterSpacing: 2,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                  ),
                                                  Container(
                                                    height: 2,
                                                    width: 30,
                                                    color: _categoriesColors[
                                                      "${source.category[0].toUpperCase()}${source.category.substring(1)}"],
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(top: 8),
                                                    child: Text(
                                                        '${source.category[0].toUpperCase()}${source.category.substring(1)}',
                                                        style: TextStyle(
                                                            color: _categoriesColors[
                                                                "${source.category[0].toUpperCase()}${source.category.substring(1)}"],
                                                            fontSize: 18.0,
                                                            letterSpacing: 2,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: _categoriesColors[
                                                      "${source.category[0].toUpperCase()}${source.category.substring(1)}"],
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          bottomRight:
                                                              Radius.circular(
                                                                  20),
                                                          topRight:
                                                              Radius.circular(
                                                                  20))),
                                              width: 16,
                                            ),
                                          ],
                                        ),
                                      )),
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
