import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mathpuzzles/puzzle.dart';
import 'package:mathpuzzles/puzzles.dart';
import 'package:mathpuzzles/second.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Data.dart';

void main() {
  runApp(
      MaterialApp(
        home: mathpuzzles(),
        debugShowCheckedModeBanner: false,
      )
  );
}

class mathpuzzles extends StatefulWidget {

  int ? index;

  mathpuzzles([this.index]);

  static SharedPreferences ?prefs;

  // const mathpuzzles({Key? key}) : super(key: key);

  @override
  State<mathpuzzles> createState() => _mathpuzzlesState();
}

class _mathpuzzlesState extends State<mathpuzzles> {

  int index = 0;
  bool temp = false,temp1 = false,temp2 = false;
  static List skip = [];

  // List list=[];

  @override
  void initState() {
    skip = List.filled(Data.puzzle_img.length, "No");
    get();
    // list=List.filled(24, "");
  }

  get() async {
    mathpuzzles.prefs = await SharedPreferences.getInstance();
    index = mathpuzzles.prefs!.getInt('lvl') ?? 0;

    for (int i = 0; i < index; i++) {
      skip[i] = mathpuzzles.prefs!.getString("lvl$i");
      // String str = mathpuzzles.prefs!.getString('levelno$i')??"pending";
      // list[i] = str;
    }
    setState(() {});
    // print(list);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showDialog(context: context, builder: (context) {
          return AlertDialog(
            title: Text("Exit Game"),
            actions: [
              TextButton(onPressed: () {
                exit(0);
              }, child: Text("Yes")),
              TextButton(onPressed: () {
                Navigator.pop(context);
              }, child: Text("No")),
            ],
          );
        },);

        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.grey,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("pic/background.jpg"),
                      fit: BoxFit.fill),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 60.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("Math Puzzles", style: TextStyle(fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple.shade800),),
                        ],
                      ),
                    ),
                    Expanded(child: Container(
                      margin: EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("pic/blackboard_main_menu.png"),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTapCancel: () {
                                    temp = false;
                                    setState(() {});
                                  },
                                  onTapUp: (details) {
                                    temp = false;
                                    setState(() {});
                                  },
                                  onTapDown: (details) {
                                    temp = true;
                                    setState(() {});
                                  },
                                  child: OutlinedButton(
                                    style: (temp == true) ?
                                    ButtonStyle(side: MaterialStatePropertyAll(
                                        BorderSide(
                                            color: Colors.white, width: 3.0)))
                                    : null,
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                                        return puzzle(index);
                                      },));
                                    },
                                    child: Text("CONTINUE", style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: "chalk",
                                        color: Colors.white),),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTapCancel: () {
                                    temp1 = false;
                                    setState(() {});
                                  },
                                  onTapUp: (details) {
                                    temp1 = false;
                                    setState(() {});
                                  },
                                  onTapDown: (details) {
                                    temp1 = true;
                                    setState(() {});
                                  },
                                  child: OutlinedButton(
                                    style: (temp1 == true) ?
                                    ButtonStyle(side: MaterialStatePropertyAll(
                                        BorderSide(
                                            color: Colors.white, width: 3.0)))
                                        : null,
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                                        return puzzles(index, skip);
                                      },));
                                    },
                                    child: Text("PUZZLES", style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: "chalk",
                                        color: Colors.white),),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTapCancel: () {
                                    temp2 = false;
                                    setState(() {});
                                  },
                                  onTapUp: (details) {
                                    temp2 = false;
                                    setState(() {});
                                  },
                                  onTapDown: (details) {
                                    temp2 = true;
                                    setState(() {});
                                  },
                                  child: OutlinedButton(onPressed: () {
                                    showDialog(
                                      barrierDismissible: false,
                                      context: context, builder: (context) {
                                      return AlertDialog(
                                        title: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Text("Benefits of Pro Version"),
                                              ],
                                            ),
                                            SizedBox(height: 10,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Text("1.No Ads"),
                                              ],
                                            ),
                                            SizedBox(height: 5,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Text("2.No Wait Time for Hint and Skip"),
                                              ],
                                            ),
                                            SizedBox(height: 5,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Text("3.Hint for Every Level"),
                                              ],
                                            ),
                                            SizedBox(height: 30,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                    child: Text("BUY"),
                                                    alignment: Alignment.center,
                                                    height: 50,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(width: 1.0),
                                                      borderRadius: BorderRadius.circular(15.0),
                                                      gradient: LinearGradient(
                                                        begin: Alignment.topLeft,
                                                          end: Alignment.bottomRight,
                                                          colors: [
                                                            Colors.grey,
                                                            Colors.white,Colors.grey
                                                          ]
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                    child: Text("No Thanks"),
                                                    alignment: Alignment.center,
                                                    height: 50,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(width: 1.0),
                                                      borderRadius: BorderRadius.circular(15.0),
                                                      gradient: LinearGradient(
                                                          begin: Alignment.topLeft,
                                                          end: Alignment.bottomRight,
                                                          colors: [
                                                            Colors.grey,
                                                            Colors.white,Colors.grey
                                                          ]
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    },);
                                  },
                                    child: Text("BUY PRO",style: TextStyle(fontSize: 20,fontFamily: "chalk",color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Text("AD",
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.deepPurple,
                                    fontSize: 15),
                              ),
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(image: AssetImage("pic/ltlicon.png"),),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        border: Border.all(width: 0.5),
                                        borderRadius: BorderRadius.circular(10.0),
                                        gradient: LinearGradient(
                                          begin: Alignment.bottomLeft,
                                          end: Alignment.topRight,
                                          colors: [
                                            Colors.grey,
                                            Colors.white,
                                            Colors.grey,
                                          ],
                                        ),
                                      ),
                                      child: IconButton(onPressed: () {
                                        Share.share('https://play.google.com/store/apps/details?id=com.applabs.puzzle&hl=en_AU');
                                      }, icon: Icon(Icons.share)),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: InkWell(
                                      onTap: () {},
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          border: Border.all(width: 0.5),
                                          borderRadius: BorderRadius.circular(10.0),
                                          gradient: LinearGradient(
                                            begin: Alignment.bottomLeft,
                                            end: Alignment.topRight,
                                            colors: [
                                              Colors.grey,
                                              Colors.white,
                                              Colors.grey,
                                            ],
                                          ),
                                        ),
                                        child: IconButton(onPressed: () {

                                        }, icon: Icon(Icons.email_outlined)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              OutlinedButton(onPressed: () {
                                
                              },
                                child: Text("Privacy Policy",style: TextStyle(color: Colors.black),),
                                style: ButtonStyle(
                                  side: MaterialStatePropertyAll(BorderSide(width: 1.0)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
