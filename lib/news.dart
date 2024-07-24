import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'config.dart';
import 'newnewspage.dart';

void main() => runApp(MaterialApp(
      home: News(),
      debugShowCheckedModeBanner: false,
    ));


class News extends StatefulWidget {
  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  List<dynamic> newsArticles = [];

  Future<void> fetchNews() async {
    try {
      final response =
          await http.get(Uri.parse(news));

      if (response.statusCode == 200) {
        List<dynamic> fetchedArticles =
            json.decode(response.body)['news']['articles'];

        fetchedArticles.sort((a, b) => DateTime.parse(b['publishedAt'])
            .compareTo(DateTime.parse(a['publishedAt'])));

        setState(() {
          newsArticles = fetchedArticles;
        });
      } else {
        print('Failed to load news: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching news: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('NEWS',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
        ),
        body: ListView.builder(
          itemCount: newsArticles.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        NewsDetailsPage(newsArticle: newsArticles[index]),
                  ),
                );
              },
              child: Card(
                margin: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    if (newsArticles[index]['urlToImage'] != null)
                      Image.network(
                        newsArticles[index]['urlToImage'],
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        newsArticles[index]['title'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
