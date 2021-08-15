import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:screenshot/screenshot.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grateful',
      home: Grateful(),
    );
  }
}

class Grateful extends StatefulWidget {
  const Grateful({Key? key}) : super(key: key);

  @override
  _GratefulState createState() => _GratefulState();
}

class _GratefulState extends State<Grateful> {
  ScreenshotController screenshotController = ScreenshotController();
  String currentDate = DateFormat.yMMMMd().format(DateTime.now());

  //Function to screeshot and share
  void share() async {
    final uint8List = await screenshotController.capture();
    String tempPath = (await getTemporaryDirectory()).path;
    File file = File('$tempPath/image.png');
    await file.writeAsBytes(uint8List!);
    await Share.shareFiles([file.path]);
  }

  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: screenshotController,
      child: Scaffold(
        backgroundColor: Colors.amber[200],
        appBar: AppBar(
          title: Text('Grateful'),
          centerTitle: true,
          backgroundColor: Colors.amber,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Text(
                  currentDate,
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 30),
                TextField(
                  cursorColor: Colors.brown,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    border: InputBorder.none,
                    hintText: "What are you grateful today?",
                  ),
                ),
                Spacer(),
                IconButton(
                  onPressed: share,
                  icon: Icon(Icons.share),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
