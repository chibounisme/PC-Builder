import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:timeago/timeago.dart' as timeago;

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  List trendingNews = [
    {
      'title': 'Corsair',
      'date': DateTime.now(),
      'description': 'okay',
      'image':
          'https://firebasestorage.googleapis.com/v0/b/flutter-pc-builder.appspot.com/o/news_2.jpg?alt=media&token=b13f7925-fe7e-451c-913e-0db9055cb0e6'
    }
  ];

  Future<List> getNews() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore.collection("news").get();
    return qn.docs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Latest News", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Material(
        color: Colors.black,
        child: FutureBuilder(
            future: getNews(),
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (_, index) {
                      return ListTile(
                          title: Container(
                            child: Stack(
                              //   AlignmentDirectional is used to place the text whereever we wanted on the image
                              alignment: AlignmentDirectional(0, 1),
                              children: <Widget>[
                                Hero(
                                    tag: snapshot.data[index]['title'],
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image(
                                          fit: BoxFit.fitWidth,
                                          image: NetworkImage(
                                              snapshot.data[index]['image'])),
                                    )),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    snapshot.data[index]['title'],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.w300,
                                      backgroundColor: Colors.black26,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 2.0),
                                child: FlatButton(
                                  splashColor: Colors.grey,
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DetailNews(
                                                snapshot.data[index])));
                                  },
                                  child: Text(
                                    "Read More",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 18.0,
                                        letterSpacing: 0.8),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            print(snapshot.data[index]);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        DetailNews(snapshot.data[index])));
                          });
                    });
              }
              return Center(
                child: SpinKitFadingCircle(
                  color: Colors.pink,
                  size: 50.0,
                ),
              );
            }),
      ),
    );
  }
}

class DetailNews extends StatefulWidget {
  final dynamic news;

  DetailNews(this.news);

  @override
  _DetailNewsState createState() => _DetailNewsState();
}

class _DetailNewsState extends State<DetailNews> {
  @override
  Widget build(BuildContext context) {
    print(widget.news['title']);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.black,
        alignment: Alignment.center,
        child: ListView(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: Stack(
                children: <Widget>[
                  Hero(
                    tag: widget.news['title'],
                    child: FadeInImage.assetNetwork(
                      placeholder: '',
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                      image: widget.news['image'],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5.0),
            // Title
            Container(
              padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
              child: Text(
                "${widget.news['title'] == null ? 'Title Here' : widget.news['title']}",
                style: TextStyle(color: Colors.white, fontSize: 21),
              ),
            ),
            Divider(color: Colors.grey),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
              child: Row(
                children: <Widget>[
                  Text(
                    "Added ",
                    style: TextStyle(color: Colors.white),
                  ),
                  Expanded(
                    child: Text(
                      "${timeago.format(widget.news["date"].toDate())}",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10.0),
            ),
            Divider(color: Colors.grey),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 5.0),
              child: Text(
                widget.news['description'].replaceAll("\n\n", "\n"),
                style: TextStyle(color: Colors.white),
              ),
            ),
            Divider(color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
