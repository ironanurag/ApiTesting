import 'package:apitesting/Screens/Homescreen/Text/widget/enum.dart';
import 'package:apitesting/Screens/Homescreen/Text/widget/getdiff.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextComparePage extends StatefulWidget {
  const TextComparePage({super.key});



  @override
  _TextCompareState createState() => _TextCompareState();
}

class _TextCompareState extends State<TextComparePage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  late final TextEditingController _oldTextEditingController;
  late final TextEditingController _newTextEditingController;
  late final TextEditingController _diffTimeoutEditingController;
  late final TextEditingController _editCostEditingController;
  DiffCleanupType? _diffCleanupType = DiffCleanupType.SEMANTIC;

  @override
  void initState() {
    _oldTextEditingController = TextEditingController();
    _newTextEditingController = TextEditingController();
    _diffTimeoutEditingController = TextEditingController();
    _editCostEditingController = TextEditingController();
    _oldTextEditingController.text = "";
    _newTextEditingController.text =
    "";
    _diffTimeoutEditingController.text = "1.0";
    _editCostEditingController.text = "4";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Text compare"),
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
                      controller: _oldTextEditingController,
                      maxLines: 15,
                      onChanged: (string) {
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        labelText: "Old Text",
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
                      controller: _newTextEditingController,
                      maxLines: 15,
                      onChanged: (string) {
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        labelText: "New Text",
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
                      Center(
                        child: PrettyDiffText(
                          textAlign: TextAlign.center,
                          oldText: _oldTextEditingController.text,
                          newText: _newTextEditingController.text,
                          diffCleanupType: DiffCleanupType.SEMANTIC,
                          diffTimeout: double.parse(_diffTimeoutEditingController.text),
                          diffEditCost: int.parse(_editCostEditingController.text),
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


}