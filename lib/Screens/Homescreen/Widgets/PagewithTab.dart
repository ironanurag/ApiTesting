import 'package:flutter/material.dart';

import '../API/Apiresponse.dart';
import '../API/Loadtest.dart';
import '../Json compare/jsoncompare.dart';
import '../Json/jsonviewer.dart';
import '../Text/textcompare.dart';

class PageWithTabBar extends StatelessWidget {
  final Widget pageContent;

  PageWithTabBar({super.key, required this.pageContent});
  final List<String> featureTitles = [
    "Json Viewer",
    "Json Compare",
    "Load Testing",
    "Api Response",
    "Text Compare",
    "Api Compare",
    "Api status checker",
    "New Feature 2",
    "New Feature 3",
    "New Feature 4",
  ];
  final List<Widget> featurePages = [
    JsonPage(),
    const JsonCompare(),
    LoadTestPage(),
    const ApiResponsePage(),
    const TextComparePage(),
    const Placeholder(),
    const Placeholder(),
    const Placeholder(),
    const Placeholder(),
    const Placeholder(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: featureTitles.length, // The number of tabs
      child: Builder(builder: (BuildContext context) {
        final TabController tabController = DefaultTabController.of(context);
        return Scaffold(
          appBar: AppBar(
            title: AnimatedBuilder(
              animation: tabController,
              builder: (BuildContext context, Widget? child) {
                return Text(featureTitles[tabController.index]);
              },
            ),
            centerTitle: true,
            bottom: TabBar(
              isScrollable: true,
              tabs: List<Widget>.generate(
                featureTitles.length,
                    (int index) {
                  return Tab(text: featureTitles[index]);
                },
              ),
            ),
          ),
          body: TabBarView(
            children: featurePages,
          ),
        );
      }),
    );
  }
}