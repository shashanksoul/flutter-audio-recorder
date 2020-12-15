import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;
import 'package:audioplayers/audio_cache.dart';
import './player.dart';

class Saved extends StatefulWidget {
  @override
  _SavedState createState() => _SavedState();
}

class _SavedState extends State<Saved> {
  AudioCache audioCache = new AudioCache();


  List _files = List();

  @override
  void initState() {
    super.initState();
    _listofFiles();
  }

  // Make New Function
  void _listofFiles() async {
    String directory = (await getApplicationDocumentsDirectory()).path;
    setState(() {
      _files = io.Directory("$directory/")
          .listSync()
          .where((element) => element.path.split(".").last == "mp4")
          .toList();
    });
  }

  Future _listItemClick(int index) async {
    showDialog(context: context,builder: (BuildContext context)=>PlayerDialog(item: _files[index].path,));
    /*int result =
        await audioPlayer.play(_files[index].path.toString(), isLocal: true);
    if (result == 1) {
      Fluttertoast.showToast(msg: "success", toastLength: Toast.LENGTH_SHORT);
    }*/
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: _files.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () => _listItemClick(index),
            child: Container(
              padding: EdgeInsets.only(left: 10, right: 10, top: 5),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.blue,
                    radius: 20,
                    child: IconButton(
                      onPressed: null,
                      padding: EdgeInsets.zero,
                      icon: Icon(
                        Icons.mic,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      _files[index].path.split("/").last,
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.normal),
                    ),
                    margin: EdgeInsets.only(left: 10, right: 5),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
