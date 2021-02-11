import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moonlight/helper/news.dart';
import 'package:moonlight/models/ArticleModel.dart';
import 'package:moonlight/models/category_model.dart';
import 'category_news.dart';
import 'settings.dart';
import 'package:moonlight/helper/data.dart';
import 'package:moonlight/screens/article_news.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CategoryModel> categories = new List<CategoryModel>();
  List<ArticleModel> articles = new List<ArticleModel>();
  bool _loading = true;
  @override
  void initState() {
    super.initState();
    categories = getCategories();
    getNews();
  }

  getNews() async {
    News news = News();
    news.getNews();
    articles = news.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'BIZZBUZZ',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.settings),
        onPressed: () {
          Navigator.pushNamed(context, SettingsPage.routeName);
        },
      ),
      body: _loading
          ? Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            )
          : Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 90,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: categories.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return CategoryCard(
                            imageUrl: categories[index].imageUrl,
                            categoryName: categories[index].categoryName,
                          );
                        }),
                  ),
                  Expanded(
                    child: Container(
                      child: ListView.builder(
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: articles.length,
                          itemBuilder: (context, index) {
                            return Blog(
                                imageUrl: articles[index].urlImage,
                                title: articles[index].title,
                                url: articles[index].url,
                                description: articles[index].description);
                          }),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final imageUrl, categoryName;
  CategoryCard({this.imageUrl, this.categoryName});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryNews(
                      newsCategory: categoryName.toLowerCase(),
                    )));
      },
      child: Container(
        margin: EdgeInsets.only(right: 10, left: 10),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(7),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                height: 80,
                width: 140,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: 140,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: Colors.black38,
              ),
              alignment: Alignment.center,
              child: Text(
                categoryName,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
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
