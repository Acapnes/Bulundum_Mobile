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
  Timer _timer;
  Timer _ampTimer;
  Amplitude _amplitude;
  String RecordString = "Başlat";
  bool isPlaying = false;

  AltEsyaNew altesya = AltEsyaNew();
  var soundsArray = [];
  List<AltEsyaNew> AltArray = [];

  final _audioPlayer = ap.AudioPlayer();
  StreamSubscription<ap.PlayerState> _playerStateChangedSubscription;
  StreamSubscription<Duration> _durationChangedSubscription;
  StreamSubscription<Duration> _positionChangedSubscription;
  static const double _controlSize = 56;
  static const double _deleteBtnSize = 24;

  Duration _duration = new Duration();
  Duration _position = new Duration();

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

    super.initState();
  }

  @override
  void disopse() {
    _timer.cancel();
    _ampTimer.cancel();
    _audioRecorder.dispose();
    super.dispose();
  }

  AltEsyaEkle() {
    setState(() {
      AltArray.add(new AltEsyaNew());
      soundsArray.add([]);
    });
  }

  // ******* Timer Codes *********
  Widget _buildTimer() {
    final String minutes = _formatNumber(_recordDuration ~/ 60);
    final String seconds = _formatNumber(_recordDuration % 60);

    return Text(
      '$minutes : $seconds',
      style: TextStyle(color: Colors.red),
    );
  }

  String _formatNumber(int number) {
    String numberStr = number.toString();
    if (number < 10) {
      numberStr = '0' + numberStr;
    }

    return numberStr;
  }

  void _startTimer() {
    _timer?.cancel();
    _ampTimer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() => _recordDuration++);
    });

    _ampTimer =
        Timer.periodic(const Duration(milliseconds: 200), (Timer t) async {
      _amplitude = await _audioRecorder.getAmplitude();
      setState(() {});
    });
  }

  // ****** Record Codes ********
  Widget _buildRecordStopControl(int pathIndex) {
    Icon icon;
    Color color;

    if (_isRecording || _isPaused) {
      icon = Icon(Icons.stop, color: Colors.red, size: 30);
      color = Colors.red.withOpacity(0.1);
    } else {
      final theme = Theme.of(context);
      icon = Icon(Icons.mic, color: theme.primaryColor, size: 30);
      color = theme.primaryColor.withOpacity(0.1);
    }

    return ClipOval(
      child: Material(
        color: color,
        child: InkWell(
          child: SizedBox(width: 56, height: 56, child: icon),
          onTap: () {
            _isRecording ? stopRecord(pathIndex) : startRecord();
          },
        ),
      ),
    );
  }

  Widget _buildPauseResumeControl() {
    if (!_isRecording && !_isPaused) {
      return const SizedBox.shrink();
    }

    Icon icon;
    Color color;

    if (!_isPaused) {
      icon = Icon(Icons.pause, color: Colors.red, size: 30);
      color = Colors.red.withOpacity(0.1);
    } else {
      final theme = Theme.of(context);
      icon = Icon(Icons.play_arrow, color: Colors.red, size: 30);
      color = theme.primaryColor.withOpacity(0.1);
    }

    return ClipOval(
      child: Material(
        color: color,
        child: InkWell(
          child: SizedBox(width: 56, height: 56, child: icon),
          onTap: () {
            _isPaused ? resumeRecord() : pauseRecord();
          },
        ),
      ),
    );
  }

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
        _startTimer();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> stopRecord(int pathIndex) async {
    _timer.cancel();
    _ampTimer.cancel();
    final path = await _audioRecorder.stop();

    soundsArray[_pathIndex].add(path);
    _audioPlayer.setUrl(path);

    setState(() => _isRecording = false);
  }

  Future<void> pauseRecord() async {
    _timer?.cancel();
    _ampTimer?.cancel();
    await _audioRecorder.pause();

    setState(() => _isPaused = true);
  }

  Future<void> resumeRecord() async {
    _startTimer();
    await _audioRecorder.resume();

    setState(() => _isPaused = false);
  }

// ******** Play Codes ********
  Widget _buildControl() {
    Icon icon;
    Color color;

    if (_audioPlayer.playerState.playing) {
      icon = Icon(Icons.pause, color: Colors.red, size: 30);
      color = Colors.red.withOpacity(0.1);
    } else {
      final theme = Theme.of(context);
      icon = Icon(Icons.play_arrow, color: theme.primaryColor, size: 30);
      color = theme.primaryColor.withOpacity(0.1);
    }

    return ClipOval(
      child: Material(
        color: color,
        child: InkWell(
          child:
              SizedBox(width: _controlSize, height: _controlSize, child: icon),
          onTap: () {
            //print(_audioPlayer.playerState);
            if (_audioPlayer.playerState.playing) {
              pause();
            } else {
              play();
            }
          },
        ),
      ),
    );
  }

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
          bool mpesachecked = false;
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter mystate
                  /*You can rename this!*/) {
            return Container(
                height: 150,
                child: Stack(children: <Widget>[
                  Container(
                    child: Center(
                      child: ElevatedButton(
                        child: Text(RecordString),
                        onPressed: () {
                          mystate(() {
                            if (_isRecording || _isPaused) {
                              RecordString = "Başlat";
                            } else {
                              RecordString = "Durdur";
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

  Widget slider() {
    return Slider(
      activeColor: Colors.black,
      inactiveColor: Colors.pink,
      value: _position.inSeconds.toDouble(),
      min: 0.0,
      max: _duration.inSeconds.toDouble(),
      onChanged: (double value) {
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: InkWell(
          child: Icon(Icons.mic),
          onTap: () {
            setState(() {

            });
            AltEsyaEkle();
            //showRecordMenu(context);
          },
        ),
      ),
      appBar: AppBar(
        title: Text("Ses Kaydı İle Buluntu Ekle"),
        centerTitle: true,
      ),
      drawer: mainDrawer(),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 20),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 3,
                  child: Card(
                    child: Stack(
                      children: [
                        Container(
                          child: soundsArray[0].isEmpty
                              ? GestureDetector(
                                  child: Center(
                                      child: Text(
                                    "Ses Kaydedilmedi",
                                    style: TextStyle(fontSize: 25),
                                  )),
                                )
                              : Column(
                                  children: <Widget>[
                                    Text("Sesli kayıt var"),
                                  ],
                                ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: ElevatedButton(
                              child: Icon(Icons.mic),
                              onPressed: () {
                                setState(() {
                                  _pathIndex = 0;
                                });
                                showRecordMenu(context);
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 50),
                child: ListView.builder(
                    itemExtent: 500,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: AltArray.length == null ? 0 : AltArray.length,
                    itemBuilder: (context, index) {
                      return Container(
                        child: Card(
                          child: Stack(
                            children: <Widget>[
                              SingleChildScrollView(
                                child: Center(
                                  child: soundsArray[index].isEmpty
                                      ? Text("Ses Eklenmedi")
                                      : Container(
                                        child: ListView.builder(
                                            physics: NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: soundsArray[index].length == null ? 0 : soundsArray[index].length,
                                            itemBuilder: (context, i) {
                                              bool _flag = true;
                                              return Container(
                                                child: ExpansionTile(
                                                  title: Text((index + 1).toString() +". Alt eşyanın "+(i+1).toString()+". ses kaydı"),
                                                  children: <Widget>[
                                                    Container(
                                                      margin: EdgeInsets.all(20),
                                                      color: Colors.blueGrey,
                                                      child: Column(
                                                        children: <Widget>[
                                                          Container(
                                                            height: 65,
                                                            margin: EdgeInsets.only(bottom: 10),
                                                            color: Colors.red,
                                                            child: Text(soundsArray[index][i].toString())),
                                                          Container(
                                                            child: Row(
                                                              //_audioPlayer.setUrl(soundsArray[index][i]);
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment.spaceAround,
                                                              children: <Widget>[
                                                                ElevatedButton(
                                                                  child: Icon(Icons.play_arrow),
                                                                  onPressed: () {
                                                                    setState(() {
                                                                      isPlaying = !isPlaying;
                                                                    });
                                                                    play();
                                                                    if (_audioPlayer.playerState.playing) {

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
                                                                    print(index);
                                                                    print(i);
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
                                              );
                                            }),
                                      ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: ElevatedButton(
                                    child: Icon(Icons.mic),
                                    onPressed: () {
                                      setState(() {
                                        _pathIndex = index;
                                      });
                                      showRecordMenu(context);
                                    },
                                  ),
                                ),
                              )
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
