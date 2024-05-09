import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:diff_match_patch/diff_match_patch.dart';

class JsonViewer extends StatefulWidget {
  final dynamic oldJsonObj;
  final dynamic newJsonObj;

  JsonViewer({Key? key, required this.oldJsonObj, required this.newJsonObj})
      : super(key: key);

  @override
  _JsonViewerState createState() => _JsonViewerState();
}

class _JsonViewerState extends State<JsonViewer> {
  @override
  Widget build(BuildContext context) {
    String oldJsonString = widget.oldJsonObj != null
        ? JsonEncoder.withIndent('  ').convert(widget.oldJsonObj)
        : '';
    String newJsonString = widget.newJsonObj != null
        ? JsonEncoder.withIndent('  ').convert(widget.newJsonObj)
        : '';

    return getContentWidget(oldJsonString, newJsonString);
  }

  getContentWidget(String oldJsonString, String newJsonString) {
    DiffMatchPatch dmp = DiffMatchPatch();
    List<Diff> diffs = dmp.diff(oldJsonString, newJsonString);
    List<TextSpan> textSpans = [];

    for (var diff in diffs) {
      TextStyle textStyle = getTextStyleByDiffOperation(diff);
      textSpans.add(TextSpan(text: diff.text, style: textStyle));
    }

    return RichText(
      text: TextSpan(
        children: textSpans,
      ),
    );
  }

  TextStyle getTextStyleByDiffOperation(Diff diff) {
    switch (diff.operation) {
      case DIFF_INSERT:
        return TextStyle(
          backgroundColor: Colors.green,
          color: Colors.white,
        );
      case DIFF_DELETE:
        return TextStyle(
          backgroundColor: Colors.red,
          color: Colors.white,
        );
      default:
        return TextStyle(color: Colors.black);
    }
  }
}
