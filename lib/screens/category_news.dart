import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moonlight/helper/news.dart';

import 'article_news.dart';

class CategoryNews extends StatefulWidget {
  final String newsCategory;
  CategoryNews({this.newsCategory});

  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  var newslist;
  bool _loading = true;

  @override
  void initState() {
    getNews();
    // TODO: implement initState
    super.initState();
  }

  void getNews() async {
    NewsForCategorie news = NewsForCategorie();
    await news.getNewsForCategory(widget.newsCategory);
    newslist = news.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'BIZZBUZZ',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: _loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: ListView.builder(
                    itemCount: newslist.length,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Blog(
                        imageUrl: newslist[index].urlImage,
                        title: newslist[index].title,
                        description: newslist[index].description,
                      );
                    }),
              ),
            ),
    );
  }
}

class Blog extends StatelessWidget {
  final String imageUrl, title, description, url;
  Blog(
      {@required this.imageUrl,
      @required this.title,
      @required this.description,
      @required this.url});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10, left: 10),
      child: Column(
        children: [
          ClipRRect(
            child: Image.network(
              imageUrl,
            ),
            borderRadius: BorderRadius.circular(7),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 3,
          ),
          Text(
            description,
            style: TextStyle(fontSize: 15),
          ),
          SizedBox(
            height: 5,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ArticleNews(
                            Blogurl: url,
                          )));
            },
            child: Row(
              children: [
                Text(
                  'Read More..',
                  style: TextStyle(color: Colors.blue, fontSize: 16),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
