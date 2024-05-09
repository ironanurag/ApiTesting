import 'dart:developer';

import 'package:apitesting/Screens/Homescreen/Homescreen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> data = ['Tab 0'];
  int initPosition = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:  HomeScreen(),

        // CustomTabView(
        //   initPosition: initPosition,
        //   itemCount: data.length,
        //   tabBuilder: (context, index) => Tab(
        //     child:
        //   ),
        //   pageBuilder: (context, index) => HomeScreen(
        //   ),
        //   onPositionChange: (index) {
        //     initPosition = index;
        //   },
        //   onScroll: (position) => log('$position'),
        // ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     setState(() {
      //       data.add('Page ${data.length}');
      //       initPosition = data.length - 1;
      //     });
      //   },
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}

// class CustomTabView extends StatefulWidget {
//   final int itemCount;
//   final IndexedWidgetBuilder tabBuilder;
//   final IndexedWidgetBuilder pageBuilder;
//   final Widget? stub;
//   final ValueChanged<int>? onPositionChange;
//   final ValueChanged<double>? onScroll;
//   final int initPosition;
//
//   const CustomTabView({super.key,
//     required this.itemCount,
//     required this.tabBuilder,
//     required this.pageBuilder,
//     this.stub,
//     this.onPositionChange,
//     this.onScroll,
//     required this.initPosition,
//   });
//
//   @override
//   _CustomTabsState createState() => _CustomTabsState();
// }
//
// class _CustomTabsState extends State<CustomTabView> with TickerProviderStateMixin {
//   late TabController controller;
//   late int _currentCount;
//   late int _currentPosition;
//
//   @override
//   void initState() {
//     _currentPosition = widget.initPosition ?? 0;
//     controller = TabController(
//       length: widget.itemCount,
//       vsync: this,
//       initialIndex: _currentPosition,
//     );
//     controller.addListener(onPositionChange);
//     controller.animation?.addListener(onScroll);
//     _currentCount = widget.itemCount;
//     super.initState();
//   }
//
//   @override
//   void didUpdateWidget(CustomTabView oldWidget) {
//     if (_currentCount != widget.itemCount) {
//       controller.animation?.removeListener(onScroll);
//       controller.removeListener(onPositionChange);
//       controller.dispose();
//
//       _currentPosition = widget.initPosition;
//
//       if (_currentPosition > widget.itemCount - 1) {
//         _currentPosition = widget.itemCount - 1;
//         _currentPosition = _currentPosition < 0 ? 0 :
//         _currentPosition;
//         if (widget.onPositionChange is ValueChanged<int>) {
//           WidgetsBinding.instance.addPostFrameCallback((_){
//             if(mounted) {
//               widget.onPositionChange!(_currentPosition);
//             }
//           });
//         }
//       }
//
//       _currentCount = widget.itemCount;
//       setState(() {
//         controller = TabController(
//           length: widget.itemCount,
//           vsync: this,
//           initialIndex: _currentPosition,
//         );
//         controller.addListener(onPositionChange);
//         controller.animation?.addListener(onScroll);
//       });
//     } else {
//       controller.animateTo(widget.initPosition);
//     }
//
//
//     super.didUpdateWidget(oldWidget);
//   }
//
//   @override
//   void dispose() {
//     controller.animation?.removeListener(onScroll);
//     controller.removeListener(onPositionChange);
//     controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (widget.itemCount < 1) return widget.stub ?? Container();
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: <Widget>[
//         Container(
//           alignment: Alignment.center,
//           child: TabBar(
//             isScrollable: true,
//             controller: controller,
//             labelColor: Theme.of(context).primaryColor,
//             unselectedLabelColor: Theme.of(context).hintColor,
//             indicator: BoxDecoration(
//               border: Border(
//                 bottom: BorderSide(
//                   color: Theme.of(context).primaryColor,
//                   width: 2,
//                 ),
//               ),
//             ),
//             tabs: List.generate(
//               widget.itemCount,
//                   (index) => widget.tabBuilder(context, index),
//             ),
//           ),
//         ),
//         Expanded(
//           child: HomeScreen()
//         ),
//       ],
//     );
//   }
//
//   onPositionChange() {
//     if (!controller.indexIsChanging) {
//       _currentPosition = controller.index;
//       if (widget.onPositionChange is ValueChanged<int>) {
//         widget.onPositionChange!(_currentPosition);
//       }
//     }
//   }
//
//   onScroll() {
//     if (widget.onScroll is ValueChanged<double>) {
//       widget.onScroll!(controller.animation!.value);
//     }
//   }
// }