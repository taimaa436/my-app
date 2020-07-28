import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'model.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

String API_KEY ='7522f4abcbc34261b57fa62f1a71dbde';
Future <List<Article>> fetchArticleBySource (String source) async{
  final response =
  await http.get('https://newsapi.org/v2/top-headlines?sources=${source}&apiKey=${API_KEY}');
  if (response.statusCode==200)//HTTP OK
      {
    List articles=json.decode(response.body) ['articles'];
    return articles.map((article)=>new Article.fromJson(article)).toList();
  }
  else{
    throw Exception('Failed to load article list');
  }
}

class ArticleScreen extends StatefulWidget{


  final Source source;

  ArticleScreen({Key key, @required this.source}) : super(key: key);


  @override
  State<StatefulWidget> createState() => ArticleScreenState();


}

class ArticleScreenState extends State<ArticleScreen> {

  var list_articles;
  var refreshkey = GlobalKey<RefreshIndicatorState>();


  @override
  void initState(){
    refreshListArticle();
  }

  Future<Null> refreshListArticle() async {
    refreshkey.currentState?.show(atTop: false);
    setState(() {
      list_articles = fetchArticleBySource(widget.source.id );
    });
    return null ;
  }

  @override
  Widget build(BuildContext context) {



    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'articles',
      theme: ThemeData(primarySwatch: Colors.amber),
      home: Scaffold(
        appBar: AppBar(
            title : Text(widget.source.name)
        ),
        body: Center(
          child: RefreshIndicator(
              key: refreshkey,
              child: FutureBuilder<List<Article>>(
                future: list_articles,
                builder: (context,snapshot) {
                  if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  else if (snapshot.hasData) {
                    List<Article> articles = snapshot.data;
                    return ListView(
                      shrinkWrap: true,
                      children: articles.map((article) =>

                          Padding(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: ExpansionTile(
                              backgroundColor: Colors.grey,

                              leading:   Column(
                                children: <Widget>[
                                  Container(
                                    width: 40.0,
                                    height: 40.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      image: DecorationImage(
                                          image: NetworkImage(article.urlToImage),
                                          fit: BoxFit.cover
                                      ),
                                    ),
                                  ),
                                  Text('${article.publishedAt}',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 8.0,

                                    ),
                                  ),
                                ],
                              ),
                              title: Column(
                                children: <Widget>[
                                  Text('${article.title}',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 5.0),
                                  Text('${article.description}',
                                    style: TextStyle(
                                        color: Colors.blueGrey,
                                        fontSize: 13.0,
                                        fontStyle: FontStyle.italic

                                    ),
                                  ),

                                ],
                              ) ,
                              children: <Widget>[
                                Container(
                                    width: MediaQuery.of(context).size.width,

                                    child: GestureDetector(
                                        child:  Text('${article.url}',
                                          style: TextStyle(
                                              color: Colors.redAccent,fontSize: 15.0),
                                          textDirection: TextDirection.rtl,),
                                        onTap:(){
                                          _launchUrl('${article.url}');
                                        }

                                    )

                                ),
                                // Text('${article.content}'),
                              ],
                            ),
                          ),

//                       Card(
//                         elevation: 1.0,
//                         color: Colors.white,
//                         margin: const EdgeInsets.symmetric(vertical: 8.0 , horizontal: 8.0),
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: <Widget>[
////                             Expanded(
////
////                                 child: Container(
////                              margin: const EdgeInsets.symmetric(vertical: 4.0 , horizontal: 4.0),
////                             //height: MediaQuery.of(context).size.height/2,
////                             //width: MediaQuery.of(context).size.width/2,
////
////                               child: article.urlToImage != null ? Image.network(article.urlToImage,  fit: BoxFit.cover,): Image.asset('assets/ind.png',),
////
////                             ))
////                             ,
////                            ExpansionTile(
////                              title: Text('${article.title}',
////                                style: TextStyle(
////                                color: Colors.black,
////                                  fontSize: 16.0,
////                                  fontWeight: FontWeight.bold,
////                              ),
////                              ),
////                              children: <Widget>[
////                                Text('${article.content}')
////                              ],
////
////                            ),
//
//                          //  ),
////                          Expanded(
////                              child: Container(
////                                child: Column(
////                                  crossAxisAlignment: CrossAxisAlignment.start,
////                                  children: <Widget>[
////                                    Row(
////                                      children: <Widget>[
////                                        Expanded(
////                                            child: Container(
////
////                                              margin: const EdgeInsets.only(left: 8.0 , top: 20.0 , bottom: 10.0),
////                                              child: Text(
////                                                  '${article.title}',
////                                                style: TextStyle(
////                                                  fontSize: 16.0,
////                                                  fontWeight: FontWeight.bold,
////
////                                                ),
////                                              ),
////
////                                            ))
////                                      ],
////                                    ),
////                                    Container(
////                                      margin: const EdgeInsets.only(left: 8.0),
////                                      child: Text(
////                                        '${article.description}',
////                                        style: TextStyle(
////                                          fontSize: 12.0,
////                                          color: Colors.grey,
////                                          fontWeight: FontWeight.bold,
////                                        ),
////
////                                      ),
////                                    ),
////                                    Container(
////                                      margin: const EdgeInsets.only(left: 8.0 , top: 10.0 , bottom: 10.0),
////                                      child: Text(
////                                        'Published At : ${article.publishedAt}',
////                                        style: TextStyle(
////                                          fontSize: 12.0,
////                                          color: Colors.red,
////                                          fontWeight: FontWeight.bold,
////                                        ),
////
////                                      ),
////                                    ),
////
////                                  ],
////                                ),
////                              ),
////                           ),
//
//
//
//
//
//
//
//
//
//
////                           FittedBox(
////                             fit: BoxFit.fill,
////                             child: Row(
////                               children: <Widget>[
////                                 Container(
////                                   width: 150.0,
////                                   height: 250.0,
////                                   decoration: BoxDecoration(
////                                     image: DecorationImage(
////                                       image: NetworkImage(article.urlToImage),
////                                       fit: BoxFit.cover
////                                     ),
////                                   ),
////                                 ),
////                                 Container(
////                                   height: 250.0,
////                                   width: MediaQuery.of(context).size.width - 170.0,
////                                   child:  Text('${article.title}'),
////
////                                 ),
////                               ],
////                             ),
////                           ),
//
//                           ],
//                         ),
//                       ) ,
                      ).toList(),
                    );
                  }
                  return CircularProgressIndicator();
                },
              ),
              onRefresh: refreshListArticle),
        ),
      ),
    );
  }
  _launchUrl(String url) async{
    if (await canLaunch(url)){
      await launch(url);
    } else {
      throw ('couldn\'t launch ${url}');
    }
  }

}


