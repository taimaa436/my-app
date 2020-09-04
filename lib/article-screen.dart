import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'model.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

String API_KEY = '7522f4abcbc34261b57fa62f1a71dbde';
Future<List<Article>> fetchArticleBySource(String source) async {
  final response = await http.get(
      'https://newsapi.org/v2/top-headlines?sources=${source}&apiKey=${API_KEY}');
  if (response.statusCode == 200) //HTTP OK
  {
    List articles = json.decode(response.body)['articles'];
    return articles.map((article) => new Article.fromJson(article)).toList();
  } else {
    throw Exception('Failed to load article list');
  }
}

class ArticleScreen extends StatefulWidget {
  final Source source;

  ArticleScreen({Key key, @required this.source}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ArticleScreenState();
}

class ArticleScreenState extends State<ArticleScreen> {
  var list_articles;
  var refreshkey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    refreshListArticle();
  }

  Future<Null> refreshListArticle() async {
    refreshkey.currentState?.show(atTop: false);
    setState(() {
      list_articles = fetchArticleBySource(widget.source.id);
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
          widget.source.name,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        )),
        body: Center(
          child: RefreshIndicator(
              key: refreshkey,
              child: FutureBuilder<List<Article>>(
                future: list_articles,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  } else if (snapshot.hasData) {
                    List<Article> articles = snapshot.data;
                    return ListView(
                      shrinkWrap: true,
                      children: articles
                          .map(
                            (article) => Padding(
                              padding: const EdgeInsets.only(bottom: 15.0),
                              child: InkWell(
                                  onTap: () {_launchUrl('${article.url}');},
                                  child: Card(
                                  elevation: 1.0,
                                  margin: const EdgeInsets.symmetric(
                                            vertical: 2.0, horizontal: 8.0),
                                  child: Container(
                                    height: 240,
                                    child: Stack(
                                      fit: StackFit.expand,
                                        children: <Widget>[
                                        FadeInImage(
                                          fit: BoxFit.cover,
                                          alignment: Alignment.center,
                                          placeholder: AssetImage("assets/back.jpg"),
                                          image: NetworkImage('${article.urlToImage}'),
                                        ),
                                        Container(
                                        color: Colors.white.withAlpha(220),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(8),
                                          child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Expanded(
                                                child: Container(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  '${article.title}',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Flexible(
                                                child: Text(
                                                '${article.description}',
                                                textAlign: TextAlign.justify,
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                           Text(
                                              '${article.publishedAt}'.split(".")[0].replaceFirst(RegExp('T'), ' '),
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 12.0,
                                              ),
                                            )
                                          ],
                                      ),
                                        ),]
                                    ),
                                  ),
                                ),
                              ),
                            ))
                          .toList(),
                    );
                  }
                  return CircularProgressIndicator();
                },
              ),
              onRefresh: refreshListArticle),
        ),
      );
  }

  _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw ('couldn\'t launch ${url}');
    }
  }
}
