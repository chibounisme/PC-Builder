import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pcbuilder/models/homegriditem.dart';

// Color Variables
Color color_1 = Color(0xFFBC7C7C7);
Color color_2 = Color(0xFFBB9B9B9);
Color color_3 = Color(0xFFBFE2851);

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
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
                            Text(
                                'Check the latest news about Graphics\n Cards, CPUs and more.',
                                style: TextStyle(
                                    color: Color(0xFFFFFFFFF),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600))
                          ],
                        ),
                        Container(
                            height: 50,
                            child: Image.network(
                              "https://firebasestorage.googleapis.com/v0/b/flutter-pc-builder.appspot.com/o/ssd_1.jpg?alt=media&token=a49f9664-9fff-4944-ae3f-74a00de6cab4",
                              fit: BoxFit.cover,
                            ))
                      ],
                    ),
                  )),
              SizedBox(height: 30),
              HomeScreenGrid(),
            ],
          ),
        ));
  }
}

class HomeScreenGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

List<HomeGridItem> items = [
  HomeGridItem(
      title: 'Create new Setup',
      subtitle:
          'Unleash your creativity and create your wanted gaming configuration.'),
  HomeGridItem(
      title: 'View Setup',
      subtitle: 'View, Modify and Delete your created setups.'),
];
