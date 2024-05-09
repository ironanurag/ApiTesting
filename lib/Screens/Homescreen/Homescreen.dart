import 'package:apitesting/Screens/Homescreen/API/Apiresponse.dart';
import 'package:apitesting/Screens/Homescreen/API/Loadtest.dart';
import 'package:apitesting/Screens/Homescreen/Json%20compare/jsoncompare.dart';
import 'package:apitesting/Screens/Homescreen/Text/textcompare.dart';
import 'package:flutter/material.dart';

import 'Json/jsonviewer.dart';
import 'Widgets/Featurecard.dart';
import 'Widgets/PagewithTab.dart';

class HomeScreen extends StatelessWidget {
  final List<String> featureTitles = [
    "Json Viewer",

    "Load Testing",
    "Api Response",
    "Text Compare",
    "Api Compare",
    "Api status checker",
    "New Feature 2",
    "New Feature 3",
    "New Feature 4",
  ];
  final List<Function> featureNavigationFunctions = [
        (context) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PageWithTabBar(
          pageContent: JsonPage(),
        ),
      ),
    ),
    //     (context) => Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => PageWithTabBar(
    //       pageContent: JsonCompare(),
    //     ),
    //   ),
    // ),
        (context) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PageWithTabBar(
          pageContent: LoadTestPage(),
        ),
      ),
    ),
        (context) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PageWithTabBar(
          pageContent: ApiResponsePage(),
        ),
      ),
    ),
        (context) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PageWithTabBar(
          pageContent: TextComparePage(),
        ),
      ),
    ),
    // Add more functions for other tabs as needed
  ];

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Calculate the number of items in each row based on screen width
    final double screenWidth = MediaQuery.of(context).size.width;
    final int crossAxisCount =
        (screenWidth / 200).floor(); // 200 is the width of each item

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
      ),
      drawer:  Drawer(

        child:
          ListView.builder(
              itemCount: featureTitles.length,
              itemBuilder: (context, index) {
            return ListTile(
              title: Text(' ${featureTitles[index]}'),
              onTap: () {
                if (index < featureNavigationFunctions.length) {
                  featureNavigationFunctions[index](context);
                } else {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Feature not implemented'),
                      content: Text('This feature is not yet implemented.'),
                      actions: <Widget>[
                        ElevatedButton(
                          child: Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  );
                }
              },
            );
          }),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
        ),
        padding: const EdgeInsets.all(8.0),
        itemCount: featureTitles.length,
        itemBuilder: (context, index) {
          return Center(
            child: featureCard(featureTitles[index], () {
              if (index < featureNavigationFunctions.length) {
                featureNavigationFunctions[index](context);
              } else {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Feature not implemented'),
                    content: Text('This feature is not yet implemented.'),
                    actions: <Widget>[
                      ElevatedButton(
                        child: Text('OK'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                );
              }
            }),
          );
        },
      ),
    );
  }
}
