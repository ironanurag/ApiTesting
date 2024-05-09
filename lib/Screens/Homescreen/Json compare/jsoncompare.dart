import 'dart:convert';
import 'package:apitesting/Screens/Homescreen/Json%20compare/widgets/widgets.dart';
import 'package:diff_match_patch/diff_match_patch.dart';
import 'package:flutter/material.dart';

class JsonCompare extends StatefulWidget {
  const JsonCompare({Key? key}) : super(key: key);

  @override
  _JsonCompareState createState() => _JsonCompareState();
}

class _JsonCompareState extends State<JsonCompare> with AutomaticKeepAliveClientMixin {
  final TextEditingController _oldJsonController = TextEditingController();
  final TextEditingController _newJsonController = TextEditingController();
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('JSON Compare'),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _oldJsonController,
                      maxLines: 15,
                      onChanged: (string) {
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        labelText: "Old JSON",
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 5,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _newJsonController,
                      maxLines: 15,
                      onChanged: (string) {
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        labelText: "New JSON",
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                margin: const EdgeInsets.only(top: 8),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text(
                            "---  OUTPUT ---",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      (_oldJsonController.text.isEmpty || _newJsonController.text.isEmpty)? Container():Center(
                        // Display the highlighted differences
                        child: JsonHighlight(
                          [
                            jsonDecode(_oldJsonController.text) as Map<String, dynamic>,
                            jsonDecode(_newJsonController.text) as Map<String, dynamic>,
                          ],
                        ),

                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget getDifferenceWidget(String oldText, String newText) {
  //   DiffMatchPatch dmp = DiffMatchPatch();
  //   List<Diff> diffs = dmp.diff(oldText, newText);
  //
  //   List<TextSpan> outputSpans = [];
  //
  //   for (var diff in diffs) {
  //     String diffText = diff.text;
  //     switch (diff.operation) {
  //       case DIFF_INSERT:
  //         diffText = '{"added": $diffText}';
  //         break;
  //       case DIFF_DELETE:
  //         diffText = '{"deleted": $diffText}';
  //         break;
  //       case DIFF_EQUAL:
  //         break;
  //     }
  //     outputSpans.add(TextSpan(text: diffText, style: const TextStyle(color: Colors.red)));
  //   }
  //
  //   return RichText(
  //     text: TextSpan(
  //       children: outputSpans,
  //       style: const TextStyle(color: Colors.black),
  //     ),
  //   );
  // }
}
