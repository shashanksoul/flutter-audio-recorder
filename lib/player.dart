import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class PlayerDialog extends StatefulWidget {
  final String item;

  PlayerDialog({this.item});

  @override
  _PlayerDialogState createState() => _PlayerDialogState(item: item);
}

class _PlayerDialogState extends State<PlayerDialog> {
  final String item;
  IconData icons = Icons.play_arrow;
  AudioPlayer audioPlayer;
  AudioPlayerState state;

  _PlayerDialogState({this.item});

  @override
  void initState() {
    super.initState();
    audioPlayer = new AudioPlayer();
    audioPlayer.onPlayerStateChanged.listen((AudioPlayerState s) => {
          checkPlayer(s)
          // print('Current player state: $s')
        });
  }

  void checkPlayer(AudioPlayerState s) {
    setState(() {
      state=s;
      if (s == AudioPlayerState.PLAYING) {
        icons = Icons.stop;
      } else if (s == AudioPlayerState.STOPPED || s==AudioPlayerState.PAUSED) {
        icons = Icons.play_arrow;
      }else if(s==AudioPlayerState.COMPLETED){
        icons = Icons.play_arrow;
        
        Navigator.pop(context);
      }
    });
  }

  Future<void> onPlayButtonClick() async {
    if(state==AudioPlayerState.PLAYING){
      await audioPlayer.pause();
    }else {
      int result = await audioPlayer.play(item.toString(), isLocal: true);
    }


  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Center(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.white),
          height: 200,
          width: 300,
          child: dialogContent(context),
        ),
      ),
    );
  }

  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              item.split("/").last,
              style: TextStyle(fontSize: 15),
            ),
            Divider(),
            CircleAvatar(
              backgroundColor: Colors.blue,
              radius: 20,
              child: IconButton(
                onPressed: onPlayButtonClick,
                padding: EdgeInsets.zero,
                icon: Icon(
                  icons,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
