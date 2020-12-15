import 'package:flutter/material.dart';
import './record.dart';
import './saved.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(text: 'Recording',),
                Tab(text: 'Saved Recording',),
              ],
            ),
            title: Text('Audio Recorder'),
          ),
          body: TabBarView(
            children: [
              Record(),
              Saved(),
            ],
          ),
        ),
      ),
    );


  }


}
