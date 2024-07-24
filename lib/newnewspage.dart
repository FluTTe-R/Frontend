import 'package:flutter/material.dart';

class NewsDetailsPage extends StatelessWidget {
  final dynamic newsArticle;

  const NewsDetailsPage({Key? key, required this.newsArticle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              if (newsArticle['urlToImage'] != null)
                Image.network(
                  newsArticle['urlToImage'],
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              SizedBox(height: 20),
              Text(
                newsArticle['title'],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0,
                ),
              ),
              SizedBox(height: 10),
              Text(
                newsArticle['description'] ?? '',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 10),
              Text(
                newsArticle['content'] ?? '',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 10),
               Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Text(
                       '- by ${newsArticle['author'] ?? ''}',
                                    style: TextStyle(fontSize: 16.0),
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.end,
                                  ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                newsArticle['publishedAt'] ?? '',
                style: TextStyle(fontSize: 16.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

