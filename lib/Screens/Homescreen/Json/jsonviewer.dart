import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:convert';

import 'Widget/jsonview.dart';

class TreeNode {
  String? key;
  dynamic value;
  bool isExpanded;
  List<TreeNode>? children;

  TreeNode({
     this.key,
    required this.value,
    this.isExpanded = true,
    this.children,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> jsonMap = {'key': key, 'value': value, 'isExpanded': isExpanded};
    if (children != null) {
      jsonMap['children'] = children!.map((child) => child.toJson()).toList();
    }
    return jsonMap;
  }
}



class JsonPage extends StatefulWidget {
  @override
  _JsonPageState createState() => _JsonPageState();
}

class _JsonPageState extends State<JsonPage> with AutomaticKeepAliveClientMixin  {
  final TextEditingController _jsonController = TextEditingController();
  TreeNode? _jsonTree;
  bool loading = false;
  String error = " ";

  @override
  bool get wantKeepAlive => true;

  void _parseJson() {
    try {
      final jsonString = _jsonController.text;
      final parsedJson = jsonDecode(jsonString);
      setState(() {
        _jsonTree = _buildJsonTree(parsedJson);
      });
    } catch (e) {
      // Handle invalid JSON format
      log("Invalid JSON format: $e");
      setState(() {
        error = e.toString();
        _jsonTree = null;
      });
    }
  }

  TreeNode _buildJsonTree(dynamic json, [String key = ""]) {
    if (json is Map) {
      List<TreeNode> children = [];
      json.forEach((k, v) {
        children.add(_buildJsonTree(v, k));
      });
      return TreeNode(key: key, value: json, children: children);
    } else if (json is List) {
      List<TreeNode> children = [];
      for (int i = 0; i < json.length; i++) {
        children.add(_buildJsonTree(json[i], i.toString()));
      }
      return TreeNode(key: key, value: json, children: children);
    } else {
      return TreeNode(key: key, value: json);
    }
  }


  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("JSON Viewer"),
      // ),
      body: Row(
        children: [
          // First Column: Raw JSON Input
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: _jsonController,
                minLines: 70,
                maxLines: null, // Allow multiline input
                decoration: const InputDecoration(
                  hintText: "Paste Raw JSON Here",
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    _parseJson();
                  });
                }, // Automatically parse when editing is complete
              ),
            ),
          ),

          // Second Column: Expanded JSON Output
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: _jsonTree != null
                    ? loading
                    ? const Center(
                  child: CircularProgressIndicator(),
                )
               : JsonViewer(jsonDecode(_jsonController.text) as Map<String, dynamic>)

                    : loading
                    ? const Center(
                  child: CircularProgressIndicator(),
                )
                    : Text("Invalid JSON Format: $error"),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            loading = true;
          });
          _parseJson();
          setState(() {
            loading = false;
          });
        },
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
