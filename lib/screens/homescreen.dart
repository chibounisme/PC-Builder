import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pcbuilder/models/homegriditem.dart';
import 'package:pcbuilder/screens/ProfileScreen.dart';
import 'package:pcbuilder/screens/newscreen.dart';
import 'package:pcbuilder/screens/pickgraph.dart';
import 'package:pcbuilder/screens/settingsScreen.dart';
import 'package:pcbuilder/utils/utils.dart';

// Color Variables
Color color_1 = Color(0xFFBC7C7C7);
Color color_2 = Color(0xFFBB9B9B9);
Color color_3 = Colors.pink[400];
Color color_4 = Colors.pink[400];

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 50),
              Padding(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  child: Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                      color: Colors.pink,
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
                                    fontWeight: FontWeight.w600)),
                            SizedBox(height: 25),
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
              SizedBox(height: 80),
              HomeScreenGrid(),
              Container(
                  child: GestureDetector(
                onTap: () {
                  logout(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Container(
                    width: 100,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Colors.pink,
                        // border: Border.all(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.circular(50)),
                    child: Center(
                      child: Text(
                        "Logout",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              )),
            ],
          ),
        ));
  }
}

class HomeScreenGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: GridView.count(
            crossAxisCount: 2,
            padding: EdgeInsets.only(left: 16, right: 16),
            crossAxisSpacing: 18,
            mainAxisSpacing: 18,
            children: items.map((el) {
              return GestureDetector(
                onTap: () {
                  if (el.target != null) moveToPage(context, el.target);
                },
                child: Container(
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                      color: Colors.grey[600],
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        el.icon,
                        size: 55,
                        color: Colors.white,
                      ),
                      SizedBox(height: 14),
                      Text(
                        el.title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 14),
                      Text(
                        el.subtitle,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList()));
  }
}

List<HomeGridItem> items = [
  HomeGridItem(
      title: 'Create new Setup',
      icon: Icons.computer,
      subtitle: 'Create your wanted gaming configuration.',
      target: PickGraph()),
  HomeGridItem(
      title: 'Profile',
      icon: Icons.person,
      subtitle: 'View old configurations and Edit your Profile.',
      target: ProfileScreen()),
  HomeGridItem(
      title: 'News',
      icon: Icons.new_releases,
      subtitle: 'More news about the latest in computer gaming.',
      target: NewsScreen()),
  HomeGridItem(
      title: 'Settings',
      icon: Icons.settings,
      subtitle: 'Change the application settings.',
      target: SettingsScreen()),
];
