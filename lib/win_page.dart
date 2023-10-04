import 'dart:io';
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mathpuzzles/Data.dart';
import 'package:mathpuzzles/main.dart';
import 'package:mathpuzzles/puzzle.dart';
import 'package:share_plus/share_plus.dart';

class win_page extends StatefulWidget {

  int index;
  win_page(this.index);

  @override
  State<win_page> createState() => _win_pageState();
}

class _win_pageState extends State<win_page> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showDialog(context: context, builder: (context) {
          return AlertDialog(
            title: Text("Are You Sure To Exit"),
            actions: [
              TextButton(onPressed: () {
                Navigator.pop(context);
              }, child: Text("No")),
              TextButton(onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                  return puzzle(mathpuzzles.prefs!.getInt("lvl") ?? 0);
                },));
              }, child: Text("Yes")),
            ],
          );
        },);
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.grey,
        body: SafeArea(
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("pic/background.jpg"),
                    fit: BoxFit.fill,
                  )
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "PUZZLE ${widget.index} COMPLETED",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.w900,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Container(
                              height: 400,
                              width: 400,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("pic/trophy.png"),
                                  )
                              ),
                            ),
                          ),
                        ],
                  )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 50,
                                width: 200,
                                decoration: BoxDecoration(
                                  border: Border.all(width: 1.0),
                                  borderRadius: BorderRadius.circular(15.0),
                                  gradient: LinearGradient(colors: [
                                    Colors.grey,
                                    Colors.white,
                                    Colors.grey,
                                  ]),
                                ),
                                child: Text("CONTINUE",style: TextStyle(fontWeight: FontWeight.bold),),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                                  return mathpuzzles();
                                },));
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 50,
                                width: 200,
                                decoration: BoxDecoration(
                                  border: Border.all(width: 1.0),
                                  borderRadius: BorderRadius.circular(15.0),
                                  gradient: LinearGradient(colors: [
                                    Colors.grey,
                                    Colors.white,
                                    Colors.grey,
                                  ]),
                                ),
                                child: Text("MAIN MENU",style: TextStyle(fontWeight: FontWeight.bold),),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                                  return mathpuzzles();
                                },));
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 50,
                                width: 200,
                                decoration: BoxDecoration(
                                  border: Border.all(width: 1.0),
                                  borderRadius: BorderRadius.circular(15.0),
                                  gradient: LinearGradient(colors: [
                                    Colors.grey,
                                    Colors.white,
                                    Colors.grey,
                                  ]),
                                ),
                                child: Text("BUY PRO",style: TextStyle(fontWeight: FontWeight.bold),),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Expanded(child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(
                            "SHARE THIS PUZZLE",
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.deepPurple,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                border: Border.all(width: 1.0),
                                borderRadius: BorderRadius.circular(15.0),
                                gradient: LinearGradient(colors: [
                                  Colors.grey,
                                  Colors.white,
                                  Colors.grey,
                                ]),
                              ),
                              child: IconButton(
                                  onPressed: () async {
                                    final byteData = await rootBundle.load(
                                        '${Data.sharepuzzle[widget.index - 1]}');
                                    var path = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS);
                                    Directory dir = Directory(path);
                                    if(!await dir.exists()){
                                      dir.create();
                                    }
                                    File file = await File('${dir.path}/${Data.sharepuzzle[widget.index - 1]}')
                                    .create(recursive: true);
                                    await file.writeAsBytes(byteData.buffer
                                        .asUint8List(byteData.offsetInBytes,
                                        byteData.lengthInBytes));
                                    Share.shareXFiles([XFile(file.path)]);

                                  }, icon: Icon(Icons.share)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
                ],
              ),
            )),
      ),
    );
  }
}
