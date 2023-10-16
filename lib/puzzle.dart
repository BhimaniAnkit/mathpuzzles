import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mathpuzzles/main.dart';
import 'package:mathpuzzles/win_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import 'Data.dart';

class puzzle extends StatefulWidget {

  int index;
  int ? index1;
  puzzle(this.index,[this.index1]);

  @override
  State<puzzle> createState() => _puzzleState();
}

class _puzzleState extends State<puzzle> {

  TextEditingController t1 = TextEditingController();
  bool temp = false;

  get() async {
    mathpuzzles.prefs = await SharedPreferences.getInstance();
    if (widget.index1 != null) {
      widget.index = widget.index1!;
    } else {
      widget.index = mathpuzzles.prefs!.getInt("lvl") ?? 0;
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    get();
  }

  fun(String s) {
    t1.text = t1.text + s;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Are You Sure To Exit"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("No")),
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) {
                          return mathpuzzles();
                        },
                      ));
                    },
                    child: Text("Yes"))
              ],
            );
          },
        );
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.brown.shade400,
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("pic/gameplaybackground.jpg"),
                    fit: BoxFit.fill)),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        if (mathpuzzles.prefs!.getString("skip_time") != null) {
                          DateTime dt = DateTime.now();
                          String past_time =
                              mathpuzzles.prefs!.getString("skip_time") ?? "";
                          DateTime dt1 = DateTime.parse(past_time);
                          int sec = dt.difference(dt1).inSeconds;
                          if (sec >= 30) {
                            String skip_time = DateTime.now().toString();
                            mathpuzzles.prefs!
                                .setString("skip_time", skip_time);
                            mathpuzzles.prefs!
                                .setString("lvl${widget.index}", "skip");
                            setState(() {
                              widget.index++;
                            });
                            (widget.index1 == null)
                                ? mathpuzzles.prefs!.setInt("lvl", widget.index)
                                : 0;
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return CupertinoAlertDialog(
                                  title: Text(
                                      "You Have Skip This Level After ${30 - sec} Seconds"),
                                  actions: [
                                    CupertinoButton(
                                      child: Text("OK"),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    )
                                  ],
                                );
                              },
                            );
                          }
                        } else {
                          String skip_time = DateTime.now().toString();
                          mathpuzzles.prefs!.setString("skip_time", skip_time);
                          mathpuzzles.prefs!.setString("lvl${widget.index}", "skip");
                          setState(() {
                            widget.index++;
                          });
                          (widget.index1 == null)
                              ? mathpuzzles.prefs!.setInt("lvl", widget.index)
                              : 0;
                        }
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("pic/skip.png"))),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: 200,
                      child: Text(
                        "Puzzle ${widget.index + 1}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            fontSize: 20,
                            color: Colors.black87),
                      ),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage("pic/level_board.png"),
                          )),
                    ),
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return CupertinoAlertDialog(
                              title: Text("Enter ${Data.hint[widget.index]}"),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("OK"))
                              ],
                            );
                          },
                        );
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("pic/hint.png")
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image:
                          AssetImage("${Data.puzzle_img[widget.index]}"))),
                ),
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Container(
                          height: 150,
                          color: Colors.black,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          // borderRadius:
                                          // BorderRadius.circular(15),
                                          color: Colors.white,
                                        ),
                                        child: TextField(
                                            controller: t1,
                                            decoration: InputDecoration(
                                              border: GradientOutlineInputBorder(
                                                gradient: LinearGradient(colors: [Colors.orange,Colors.pink,Colors.purpleAccent]),
                                                width: 3.0,
                                              ),
                                                // border: OutlineInputBorder(
                                                //     borderRadius:
                                                //     BorderRadius.circular(
                                                //         15))
                                            )),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      onTap: () {
                                        if (t1.text.length != 0) {
                                          t1.text = t1.text.substring(0, t1.text.length - 1);
                                        }
                                        setState(() {});
                                      },
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage("pic/delete.png")
                                                // image: AssetImage("assets/Images/delete.png")
                                            )),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTapDown: (details) {
                                      temp = true;
                                      setState(() {});
                                    },
                                    onTapUp: (details) {
                                      temp = false;
                                      setState(() {});
                                    },
                                    onTapCancel: () {
                                      temp = false;
                                      setState(() {});
                                    },
                                    child: OutlinedButton(
                                        style: ButtonStyle(
                                            side: (temp == true)
                                                ? MaterialStatePropertyAll(
                                                BorderSide(
                                                    width: 5,
                                                    color: Colors.white))
                                                : null),
                                        onPressed: () {
                                          if (t1.text == Data.Ans[widget.index]) {
                                            mathpuzzles.prefs!.setString("lvl${widget.index}", "yes");
                                            if (widget.index1 == null) {
                                              widget.index++;
                                              mathpuzzles.prefs!.setInt("lvl", widget.index);
                                              Navigator.push(context,MaterialPageRoute(builder: (context) {
                                                return win_page(widget.index);
                                                // return window(widget.index);
                                              },
                                              ));
                                            }
                                            else {
                                              Navigator.push(context,MaterialPageRoute(builder: (context) {
                                                return win_page(widget.index + 1);
                                              },
                                              ));
                                            }
                                            if (widget.index1 == null) {
                                              widget.index = mathpuzzles.prefs!.getInt("lvl") ?? 0;
                                              mathpuzzles.prefs!.setInt("lvl", widget.index);
                                            }
                                            t1.text = "";
                                          } else {
                                            AnimatedSnackBar.rectangle(
                                              "Not Success",
                                              "Wrong Answer",
                                              type: AnimatedSnackBarType.success,
                                              brightness: Brightness.light,
                                              mobileSnackBarPosition: MobileSnackBarPosition.bottom,
                                            ).show(context);
                                            t1.text = "";
                                            // ScaffoldMessenger.of(context)
                                            //     .showSnackBar(SnackBar(
                                            //     content:
                                            //     Text("Wrong Ans!!")));
                                          }
                                          widget.index1 = null;
                                          setState(() {});
                                        },
                                      child: GradientText("SUBMIT",style: TextStyle(fontSize: 25), colors: [Colors.blue,Colors.red,Colors.teal]),
                                        // child: Text(
                                        //   "SUBMIT",
                                        //   style: TextStyle(color: Colors.white),
                                        // )
                                    ),
                                  )
                                ],
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () => fun("1"),
                                        child: Text("1")
                                            .animate()
                                            .fadeIn(duration: 600.ms)
                                            .scale(delay: 300.ms)
                                            .move(delay: 300.ms,duration: 600.ms)
                                            .then(duration: 600.ms,delay: 300.ms,curve: Cubic(10.0, 10.0, 10.0, 10.0)),
                                        style: ButtonStyle(
                                          backgroundColor:
                                            MaterialStatePropertyAll(HexColor("999999")),
                                          // MaterialStatePropertyAll(
                                          //     Colors.grey),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () => fun("2"),
                                        child: Text("2")
                                            .animate()
                                            .fadeIn(duration: 600.ms)
                                            .scale(delay: 300.ms)
                                            .move(delay: 300.ms,duration: 600.ms)
                                            .then(duration: 600.ms,delay: 300.ms,curve: Cubic(10.0, 10.0, 10.0, 10.0)),
                                        style: ButtonStyle(
                                          backgroundColor:
                                          MaterialStatePropertyAll(
                                              HexColor("999999")),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () => fun("3"),
                                        child: Text("3")
                                            .animate()
                                            .fadeIn(duration: 600.ms)
                                            .scale(delay: 300.ms)
                                            .move(delay: 300.ms,duration: 600.ms)
                                            .then(duration: 600.ms,delay: 300.ms,curve: Cubic(10.0, 10.0, 10.0, 10.0)),
                                        style: ButtonStyle(
                                          backgroundColor:
                                          MaterialStatePropertyAll(
                                              HexColor("999999")),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () => fun("4"),
                                        child: Text("4")
                                            .animate()
                                            .fadeIn(duration: 600.ms)
                                            .scale(delay: 300.ms)
                                            .move(delay: 300.ms,duration: 600.ms)
                                            .then(duration: 600.ms,delay: 300.ms,curve: Cubic(10.0, 10.0, 10.0, 10.0)),
                                        style: ButtonStyle(
                                          backgroundColor:
                                          MaterialStatePropertyAll(
                                              HexColor("999999")),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () => fun("5"),
                                        child: Text("5")
                                            .animate()
                                            .fadeIn(duration: 600.ms)
                                            .scale(delay: 300.ms)
                                            .move(delay: 300.ms,duration: 600.ms)
                                            .then(duration: 600.ms,delay: 300.ms,curve: Cubic(10.0, 10.0, 10.0, 10.0)),
                                        style: ButtonStyle(
                                          backgroundColor:
                                          MaterialStatePropertyAll(
                                              HexColor("999999")),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () => fun("6"),
                                        child: Text("6",)
                                            .animate()
                                            .fadeIn(duration: 600.ms)
                                            .scale(delay: 300.ms)
                                            .move(delay: 300.ms,duration: 600.ms)
                                            .then(duration: 600.ms,delay: 300.ms,curve: Cubic(10.0, 10.0, 10.0, 10.0)),
                                            // .blurXY(),
                                        style: ButtonStyle(
                                          backgroundColor:
                                          MaterialStatePropertyAll(
                                              HexColor("999999")),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () => fun("7"),
                                        child: Text("7")
                                            .animate()
                                            .fadeIn(duration: 600.ms)
                                            .scale(delay: 300.ms)
                                            .move(delay: 300.ms,duration: 600.ms)
                                            .then(duration: 600.ms,delay: 300.ms,curve: Cubic(10.0, 10.0, 10.0, 10.0)),
                                        style: ButtonStyle(
                                          backgroundColor:
                                          MaterialStatePropertyAll(
                                              HexColor("999999")),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () => fun("8"),
                                        child: Text("8")
                                            .animate()
                                            .fadeIn(duration: 600.ms)
                                            .scale(delay: 300.ms)
                                            .move(delay: 300.ms,duration: 600.ms)
                                            .then(duration: 600.ms,delay: 300.ms,curve: Cubic(10.0, 10.0, 10.0, 10.0)),
                                        style: ButtonStyle(
                                          backgroundColor:
                                          MaterialStatePropertyAll(
                                              HexColor("999999")),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () => fun("9"),
                                        child: Text("9")
                                            .animate()
                                            .fadeIn(duration: 600.ms)
                                            .scale(delay: 300.ms)
                                            .move(delay: 300.ms,duration: 600.ms)
                                            .then(duration: 600.ms,delay: 300.ms,curve: Cubic(10.0, 10.0, 10.0, 10.0)),
                                        style: ButtonStyle(
                                          backgroundColor:
                                          MaterialStatePropertyAll(
                                              HexColor("999999")),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () => fun("0"),
                                        child: Text("0")
                                            .animate()
                                            .fadeIn(duration: 600.ms)
                                            .scale(delay: 300.ms)
                                            .move(delay: 300.ms,duration: 600.ms)
                                            .then(duration: 600.ms,delay: 300.ms,curve: Cubic(10.0, 10.0, 10.0, 10.0)),
                                        style: ButtonStyle(
                                          backgroundColor:
                                          MaterialStatePropertyAll(
                                              HexColor("999999")),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),
                    )
                  ],
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
