import 'dart:async';
import 'package:bulundum_mobile/Drawer/mainDrawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart' as ap;
import 'package:record/record.dart';
import 'package:permission_handler/permission_handler.dart';

class MainSes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SesBuluntu(),
      ),
    );
  }
}

class SesBuluntu extends StatefulWidget {
  @override
  _SesBuluntuState createState() => _SesBuluntuState();
}

class _SesBuluntuState extends State<SesBuluntu> {
  bool _isRecording = false;
  bool _isPaused = false;
  final _audioRecorder = Record();
  bool isRecording = false;
  int _recordDuration = 0, _pathIndex = 0;
  String RecordString = "Ses Kaydını Başlat",mesaj;
  bool isPlaying = false,mainInsert=true;

  Icon elIcon = Icon(Icons.mic);
  Color elColor = Colors.blueAccent;

  AltEsyaNew altesya = AltEsyaNew();
  var soundsArray = [];
  List<AltEsyaNew> AltArray = [];

  double itemExtend = 0;

  final _audioPlayer = ap.AudioPlayer();
  StreamSubscription<ap.PlayerState> _playerStateChangedSubscription;
  StreamSubscription<Duration> _durationChangedSubscription;
  StreamSubscription<Duration> _positionChangedSubscription;


  ScrollController _bodyScrollController = ScrollController();

  @override
  void initState() {
    soundsArray.add([]);
    _isRecording = false;
    super.initState();

    _playerStateChangedSubscription =
        _audioPlayer.playerStateStream.listen((state) async {
      if (state.processingState == ap.ProcessingState.completed) {
        await stop();
      }
      setState(() {});
    });
    _positionChangedSubscription =
        _audioPlayer.positionStream.listen((position) => setState(() {}));
    _durationChangedSubscription =
        _audioPlayer.durationStream.listen((duration) => setState(() {}));

  }

  @override
  void disopse() {
    _audioRecorder.dispose();
    super.dispose();
  }

  AltEsyaEkle() {
    setState(() {
      AltArray.add(new AltEsyaNew());
      soundsArray.add([]);
    });
  }

  // ****** Record Codes ********

  Future<void> startRecord() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      print("Mikrofon izni verildi");
    }

    try {
      if (await _audioRecorder.hasPermission()) {
        await _audioRecorder.start();

        bool isRecording = await _audioRecorder.isRecording();
        setState(() {
          _isRecording = isRecording;
          _recordDuration = 0;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> stopRecord(int pathIndex) async {
    final path = await _audioRecorder.stop();

    if(mainInsert==true)
      {
        soundsArray[0].add(path);
      } else if(mainInsert==false){
      soundsArray[_pathIndex+1].add(path);
        }

    _audioPlayer.setUrl(path);

    setState(() => _isRecording = false);
  }

  Future<void> pauseRecord() async {
    await _audioRecorder.pause();

    setState(() => _isPaused = true);
  }

  Future<void> resumeRecord() async {
    await _audioRecorder.resume();

    setState(() => _isPaused = false);
  }

// ******** Play Codes ********

  Future<void> play() {
    return _audioPlayer.play();
  }

  Future<void> pause() {
    return _audioPlayer.pause();
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
    return _audioPlayer.seek(const Duration(milliseconds: 0));
  }

  void showRecordMenu(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter mystate
                  /*You can rename this!*/) {

            return Container(
                height: 100,
                child: Stack(children: <Widget>[
                  Container(
                    child: Center(
                      child: ElevatedButton(
                        child: Container(
                          width: 175,
                          height: 50,
                          child: Row(
                            children: [
                              Icon(elIcon.icon,color: elColor,),
                              Padding(
                                padding: EdgeInsets.only(left: 20),
                                  child: Text(RecordString,style: TextStyle(color: elColor),)),
                            ],
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          elevation: 20,
                            primary: Colors.white70,
                            minimumSize: Size(175,50),
                            side: BorderSide(width: 2.0, color: elColor,)

                        ),
                        onPressed: () {
                          mystate(() {

                            if (_isRecording || _isPaused) {
                              RecordString = "Ses Kaydını Başlat";
                              elIcon = Icon(Icons.mic);
                              elColor = Colors.blueAccent;
                            } else {
                              elColor = Colors.redAccent;
                              elIcon = Icon(Icons.stop);
                              RecordString = "Ses Kaydını Durdur";
                            }
                          });
                          _isRecording ? stopRecord(_pathIndex) : startRecord();
                        },
                      ),
                    ),
                  ),
                ]));
          });
        });
  }

  // ******** Slider Codes ********** //

  // ******* Animation Codes ******** //

  animateToBot() async {
    final double end = _bodyScrollController.position.maxScrollExtent + 600;
    _bodyScrollController.animateTo(end,
        duration: Duration(milliseconds: 800), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          AltEsyaEkle();
          animateToBot();
          setState(() {
            soundsArray;
            print(soundsArray);
          });
        },
      ),
      appBar: AppBar(
        title: Text("Ses Kaydı İle Buluntu Ekle"),
        centerTitle: true,
      ),
      drawer: mainDrawer(),
      body: SingleChildScrollView(
        controller: _bodyScrollController,
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 20),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height - 140,
                  child: Card(
                    child: Stack(
                      children: [
                          Container(
                            child: soundsArray[0].isEmpty
                                ? GestureDetector(
                                    child: Align(
                                      alignment: Alignment.center,
                                        child: Text(
                                      "Ses Kaydedilmedi",
                                      style: TextStyle(fontSize: 25),
                                    )),
                                  )
                                : SingleChildScrollView(
                                  child: Container(
                                    margin: EdgeInsets.only(top: 60),
                              child: ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: soundsArray[0].length == null ? 0 : soundsArray[0].length,
                                    itemBuilder: (context, indexMain) {
                                      bool _flag = true;
                                      return Container(
                                        child: Card(
                                          child: ExpansionTile(
                                            title: Text("Ana Eşyanın "+(indexMain+1).toString()+". ses kaydı"),
                                            children: <Widget>[
                                              Container(
                                                margin: EdgeInsets.all(20),
                                                child: Column(
                                                  children: <Widget>[
                                                    Container(
                                                        height: 65,
                                                        margin: EdgeInsets.only(bottom: 10),
                                                        child: ListTile(
                                                          title: Text("Kayıt Türü"),
                                                          subtitle: Text("M4a"),
                                                        )),
                                                    Container(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.spaceAround,
                                                        children: <Widget>[
                                                          ElevatedButton(
                                                            child: Icon(Icons.play_arrow),
                                                            onPressed: () {
                                                              setState(() {
                                                                isPlaying = !isPlaying;
                                                              });
                                                              _audioPlayer.setFilePath(soundsArray[0][indexMain]);

                                                              if (!_audioPlayer.playerState.playing) {
                                                                play();
                                                              }
                                                            },
                                                          ),
                                                          ElevatedButton(
                                                            child: Icon(
                                                                Icons.pause),
                                                            onPressed: () {
                                                              if (_audioPlayer.playerState.playing) {
                                                                pause();
                                                              }
                                                            },
                                                          ),
                                                          ElevatedButton(
                                                            child: Icon(
                                                                Icons.stop),
                                                            onPressed: () {
                                                              if (_audioPlayer.playerState.playing) {
                                                                stop();
                                                              }
                                                            },
                                                          ),
                                                          ElevatedButton(
                                                            child: Icon(
                                                                Icons.delete),
                                                            onPressed: () {
                                                              soundsArray[0].removeAt(indexMain);
                                                              print(soundsArray);
                                                              setState(() {
                                                                soundsArray;
                                                              });
                                                            },
                                                          ),

                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                            ),
                                ),
                          ),
                        Container(
                          margin: EdgeInsets.only(left: 10,top: 10),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: ElevatedButton(
                              child: Icon(Icons.mic),
                              onPressed: () {
                                setState(() {

                                  mainInsert = true;
                                  _pathIndex = 0;
                                });
                                showRecordMenu(context);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10,bottom: 20),
                child: ListView.builder(
                    //itemExtent: 500,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: AltArray.length == null ? 0 : AltArray.length,
                    itemBuilder: (context, indexAlt) {
                      return Container(
                        height: 600+itemExtend,
                        child: Card(
                          child: Stack(
                            children: <Widget>[
                              SingleChildScrollView(
                                child: Container(
                                  child: soundsArray[indexAlt+1].isEmpty
                                      ? Align(
                                    alignment: Alignment.center,
                                      child: Text("Ses Eklenmedi"))
                                      : Container(
                                    margin: EdgeInsets.only(top: 60),
                                        child: ListView.builder(
                                            physics: NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            //itemExtent: 500,
                                            itemCount: soundsArray[indexAlt+1].length == null ? 0 : soundsArray[indexAlt+1].length,
                                            itemBuilder: (context, i) {
                                              bool _flag = true;
                                              return Container(
                                                child: Card(
                                                  child: ExpansionTile(
                                                    title: Text((indexAlt + 1).toString() +". Alt eşyanın "+(i+1).toString()+". ses kaydı"),
                                                    children: <Widget>[
                                                      Container(
                                                        margin: EdgeInsets.all(20),
                                                        child: Column(
                                                          children: <Widget>[
                                                            Container(
                                                              height: 65,
                                                              margin: EdgeInsets.only(bottom: 10),
                                                              child: ListTile(
                                                                title: Text("Kayıt Türü"),
                                                                subtitle: Text("m4a"),
                                                              )),
                                                            Container(
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment.spaceAround,
                                                                children: <Widget>[
                                                                  ElevatedButton(
                                                                    child: Icon(Icons.play_arrow),
                                                                    onPressed: () {
                                                                      setState(() {
                                                                        isPlaying = !isPlaying;
                                                                      });
                                                                      _audioPlayer.setFilePath(soundsArray[indexAlt+1][i]);
                                                                      play();
                                                                      if (!_audioPlayer.playerState.playing) {
                                                                      }
                                                                    },
                                                                  ),
                                                                  ElevatedButton(
                                                                    child: Icon(
                                                                        Icons.pause),
                                                                    onPressed: () {
                                                                      if (_audioPlayer.playerState.playing) {
                                                                        pause();
                                                                      }
                                                                    },
                                                                  ),

                                                                  ElevatedButton(
                                                                    child: Icon(
                                                                        Icons.stop),
                                                                    onPressed: () {
                                                                      if (_audioPlayer.playerState.playing) {
                                                                        stop();
                                                                      }
                                                                    },
                                                                  ),
                                                                  ElevatedButton(
                                                                    child: Icon(
                                                                        Icons.delete),
                                                                    onPressed: () {
                                                                      soundsArray[indexAlt+1].removeAt(i);
                                                                      setState(() {
                                                                        soundsArray;
                                                                      });
                                                                    },
                                                                  ),

                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }),
                                      ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10,top: 10),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: ElevatedButton(
                                    child: Icon(Icons.mic),
                                    onPressed: () {

                                      setState(() {
                                        mainInsert = false;
                                        _pathIndex = indexAlt;
                                      });
                                      showRecordMenu(context);
                                    },
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 10,top: 10),
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.redAccent
                                    ),
                                    child: Icon(Icons.delete),
                                    onPressed: () {
                                      soundsArray.removeAt(indexAlt+1);
                                      AltArray.removeAt(indexAlt);
                                      setState(() {
                                        soundsArray;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AltEsyaNew {
  String name;
}
