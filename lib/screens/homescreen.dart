import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pcbuilder/services/firestorage.dart';

// import 'package:pcbuilder/services/auth.dart';

// Color Variables
Color color_1 = Color(0xFFBC7C7C7);
Color color_2 = Color(0xFFBB9B9B9);
Color color_3 = Color(0xFFBFE2851);

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<Widget> _getImage(BuildContext context, String image) async {
    Image m;
    await FireStorageService.loadFromStorage(context, image)
        .then((downloadUrl) {
      print("Download URL is $downloadUrl");
      m = Image.network(
        downloadUrl.toString(),
        fit: BoxFit.scaleDown,
      );
    }).catchError((e) {
      print(e);
    });

    return m;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            SizedBox(height: 50),
            Padding(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('News',
                              style: TextStyle(
                                  color: Color(0xFFFFFFFFF),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(height: 4),
                          Text('Check the hottest', // Gear = equipment
                              style: TextStyle(
                                  color: Color(0xFFFFFFFFF),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600))
                        ],
                      ),
                      FutureBuilder(
                          future: _getImage(context, "news_1.jpeg"),
                          builder: (context, snapshot) {
                            print("come on");
                            print(snapshot.data);
                            if (snapshot.connectionState ==
                                ConnectionState.done)
                              return Container(
                                height: MediaQuery.of(context).size.height / 5,
                                width: MediaQuery.of(context).size.width / 5,
                                child: snapshot.data,
                              );

                            if (snapshot.connectionState ==
                                ConnectionState.waiting)
                              return Container(
                                  height:
                                      MediaQuery.of(context).size.height / 20,
                                  width: MediaQuery.of(context).size.width / 10,
                                  child: CircularProgressIndicator());

                            return Container();
                          })
                    ],
                  ),
                ))
          ],
        ));
  }
}
