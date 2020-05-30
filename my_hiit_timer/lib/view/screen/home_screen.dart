import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myhiittimer/model/format/format.dart';
import 'package:myhiittimer/model/repositopry/hiit_json_default.dart';
import 'package:myhiittimer/model/repositopry/hiit_repository.dart';
import 'package:myhiittimer/view/components/duration_set_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Hiit _hiit;

  @override
  void loadHiit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      var json = prefs.getString('Hiit');
      _hiit = json != null ? Hiit.fromJson(jsonDecode(json)) : jsonDefault;
    });
  }

  void saveHiit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('Hiit', jsonEncode(_hiit.toJson()));
    });
  }

  void initState() {
    loadHiit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            InkWell(
              child: Container(
                height: 120.0,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  colors: [
                    Colors.grey,
                    Colors.redAccent,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '準備',
                      style: TextStyle(color: Colors.white, fontSize: 30.0),
                    ),
                    Text(
                      formatType(_hiit.statSeconds),
                      style: TextStyle(fontSize: 30.0, color: Colors.white),
                    ),
                  ],
                ),
              ),
              onTap: () {
                showDialog<Duration>(
                    context: context,
                    builder: (BuildContext context) {
                      return DurationSetDialog(
                        text: Text('準備時間を入力してください'),
                        initialDuration: _hiit.statSeconds,
                      );
                    }).then((startSeconds) {
                      if(startSeconds==null)return;
                  setState(() {
                    _hiit.statSeconds = startSeconds;
                    saveHiit();
                  });
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
