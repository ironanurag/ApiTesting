import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiResponsePage extends StatefulWidget {
  const ApiResponsePage({super.key});

  @override
  _ApiResponseState createState() => _ApiResponseState();
}

class _ApiResponseState extends State<ApiResponsePage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  String api = '';

  String host = ''; // Default host
  int numberOfTests = 1; // Default number of tests
  List<String> testLogs = []; // List to store test logs
  StreamController<String> logController = StreamController<String>();

  @override
  void dispose() {
    logController.close();
    super.dispose();
  }

  Future<void> startLoadTesting() async {
    // Clear previous logs
    setState(() {
      testLogs.clear();
    });

    // Run the tests
    for (int i = 0; i < numberOfTests; i++) {
      await _performTest(api, i);
    }

    // Add a log indicating that all tests are completed
  //  addLog('Load testing completed');
  }

  Future<void> _performTest(String url, int index) async {
    try {
      final response = await http.get(Uri.parse(url));
      // Check the status code and print a message
      if (response.statusCode == 200) {
        addLog('${response.body}');
      } else {
        addLog('Failed with status code ${response.statusCode}');
      }
    } catch (error) {
      // Handle any errors
      addLog('Error $error');
    }
  }

  void addLog(String log) {
    setState(() {
      testLogs.add(log);
      logController.add(log);
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Load Test Page'),
      // ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  api = value;
                  host = Uri.parse(value).host;
                });
              },
              decoration: InputDecoration(
                labelText: 'API',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              onChanged: (value) {
                setState(() {
                  host = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Hostname',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              onChanged: (value) {
                setState(() {
                  numberOfTests = int.parse(value);
                });
              },
              decoration: InputDecoration(
                labelText: 'Number of Tests',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: startLoadTesting,
              child: Text('Start Load Testing'),
            ),
            SizedBox(height: 16.0),
            Text(
              'Output and Logs:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Expanded(
              child: ListView.builder(
                itemCount: testLogs.length,
                itemBuilder: (context, index) {
                  String log = testLogs[index];
                  int testNumber = index + 1;

                  return SelectableText.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Response $testNumber:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            // Add any other styling you want for the highlighted part
                          ),
                        ),
                        TextSpan(
                          text: log.replaceFirst('Test $index', ''),
                          // Add any other styling you want for the rest of the text
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
