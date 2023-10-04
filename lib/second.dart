
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mathpuzzles/Data.dart';
// import 'package:mathpuzzles/main.dart';
import 'package:mathpuzzles/win_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';

class second extends StatefulWidget {

  int index;
  int? index1;
  second(this.index,[this.index1]);

  @override
  State<second> createState() => _secondState();
}

class _secondState extends State<second> {
  // SharedPreferences ?prefs;
  List<int> num = [1,2,3,4,5,6,7,8,9,0];
  TextEditingController t1 = TextEditingController();
  List img=["p1.png","p2.png","p3.png","p4.png","p5.png","p6.png","p7.png","p8.png","p9.png","p10.png"];
  String ans="";


  @override
  void initState() {
    super.initState();
    get();
  }
  get()
  async {
    mathpuzzles.prefs = await SharedPreferences.getInstance();
    if(widget.index1 != null){
      widget.index = widget.index1!;
    }
    else{
      widget.index = mathpuzzles.prefs!.getInt("lvl") ?? 0;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double status = MediaQuery.of(context).padding.top;
    double app_bar = kToolbarHeight;

    double total_h = height - status - app_bar;

    return WillPopScope(
      onWillPop: () async {
        showDialog(context: context, builder: (context) {
          return AlertDialog(
            title: Text("Are You Want To Exit"),
            actions: [
              TextButton(onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                  return mathpuzzles();
                },));
              }, child: Text("Yes")),
              TextButton(onPressed: () {
                Navigator.pop(context);
              }, child: Text("No"))
            ],
          );
        },);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(),
          body: Container(
            height: total_h,
            width: width,
            // height: double.infinity,
            // width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("pic/gameplaybackground.jpg"),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        if(mathpuzzles.prefs!.getString("skip_time") != null){
                          DateTime dt = DateTime.now();
                          String past_time = mathpuzzles.prefs!.getString("skip_time") ?? "";
                          DateTime dt1 = DateTime.parse(past_time);
                          int sec = dt.difference(dt1).inSeconds;
                          if(sec >= 30){
                            String skip_time = DateTime.now().toString();
                            mathpuzzles.prefs!.setString("skip_time", skip_time);
                            mathpuzzles.prefs!.setString("lvl${widget.index}", "skip");
                            setState(() {
                              widget.index++;
                            });
                            (widget.index1 == null) ? mathpuzzles.prefs!.setInt("lvl", widget.index) : 0;
                          }
                          else{
                            showDialog(context: context, builder: (context) {
                              return CupertinoAlertDialog(
                                title: Text("You Have Skip this level After ${30 - sec} Seconds"),
                                actions: [
                                  CupertinoButton(child: Text("Ok"), onPressed: () {
                                    Navigator.pop(context);
                                  },)
                                ],
                              );
                            },);
                          }
                        }
                        else{
                          String skip_time = DateTime.now().toString();
                          mathpuzzles.prefs!.setString("skip_time", skip_time);
                          mathpuzzles.prefs!.setString("lvl${widget.index}", "skip");
                          setState(() {
                            widget.index++;
                          });
                          (widget.index1 == null) ? mathpuzzles.prefs!.setInt("lvl", widget.index) : 0;
                        }
                      },
                      child: Container(
                            height: 40,
                            width: 40,
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(left: 10),
                            child: Image.asset("pic/skip.png"),
                          ),
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 10.0,bottom: 10.0),
                      height: 50,
                      width: 200,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("pic/level_board.png",),
                              fit: BoxFit.fill
                          )
                      ),
                      child: Text("Puzzle ${widget.index + 1}",
                        style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,color: Colors.black),),
                    ),
                    InkWell(
                      onTap: () {
                        showDialog(context: context, builder: (context) {
                          return CupertinoAlertDialog(
                            title:  Text("Enter ${Data.hint[widget.index]}"),
                            actions: [
                              TextButton(onPressed: () {
                                Navigator.pop(context);
                              }, child: Text("Ok"))
                            ],
                          );
                        },);
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        alignment: Alignment.centerRight,
                        margin: EdgeInsets.only(right: 10),
                        child: Image.asset("pic/hint.png"),
                      ),
                    ),
                  ],
                ),
                Expanded(flex: 3,child: Row(
                  children: [
                    Expanded(child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("${Data.puzzle_img[widget.index]}"),
                            // image: AssetImage("pic/${Data.puzzle_img[widget.index]}"),
                            fit: BoxFit.fill,
                          )
                      ),
                      // child: Image.asset("pic/p1.png"),
                    ))
                  ],
                )),
                Expanded(flex: 2,child: Row(
                  children: [
                    Expanded(child: Container(
                      height: double.infinity,
                      width: double.infinity,
                    ))
                  ],
                )),
                Expanded(child: Row(
                  children: [
                    Expanded(child: Column(
                      children: [
                        Expanded(child: Row(
                          children: [
                            Expanded(child: Container(
                              height: double.infinity,
                              width: double.infinity,
                              color: Colors.black,
                              child: Column(
                                children: [
                                  Expanded(child: Row(
                                    children: [
                                      // Expanded(flex: 2,child: Container(
                                      //   height: 30,
                                      //   alignment: Alignment.centerLeft,
                                      //   width: 70,
                                      //   decoration: BoxDecoration(
                                      //     color: Colors.white,
                                      //     borderRadius: BorderRadius.circular(5.0),
                                      //   ),
                                      //   child: Text("${ans}",style: TextStyle(fontSize: 20,color: Colors.black),),
                                      //   // decoration: BoxDecoration(
                                      //   //   border: Border.all(width: 0.5)
                                      //   // ),
                                      // )),
                                      Expanded(child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15.0),
                                            color: Colors.white,
                                          ),
                                          child: TextField(
                                            controller: t1,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(15.0),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )),
                                      Expanded(child: InkWell(
                                        onTap: () {
                                          if(t1.text.length != 0){
                                            t1.text = t1.text.substring(0,t1.text.length - 1);
                                          }
                                          // (ans.length > 0) ? ans = ans.substring(0,ans.length - 1) : null;
                                          setState(() {});
                                        },
                                        child: Container(
                                          height: 40,
                                          width: 40,
                                          child: Image.asset("pic/delete.png"),
                                        ),
                                      )),
                                      Expanded(child: InkWell(
                                        onTap: () {
                                          // if(num[widget.cur_level]==int.parse(ans))
                                          // if(int.parse(ans) == Data.Ans[widget.index])
                                          // if(num[widget.index] == int.parse(ans))
                                          if(t1.text == num[widget.index])
                                          {
                                            mathpuzzles.prefs!.setString("lvl${widget.index}", "yes");
                                            if(widget.index1 == null){
                                              widget.index++;
                                              mathpuzzles.prefs!.setInt("lvl", widget.index);
                                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                                return win_page(widget.index);
                                              },));
                                            }
                                            else{
                                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                                return win_page(widget.index + 1);
                                              },));
                                            }
                                            if(widget.index1 == null){
                                              widget.index = mathpuzzles.prefs!.getInt("lvl") ?? 0;
                                              mathpuzzles.prefs!.setInt("lvl", widget.index);

                                            }
                                            ans = "";
                                            }
                                            else{
                                             Fluttertoast.showToast(
                                                 msg: "Wrong..!",
                                                 toastLength: Toast.LENGTH_SHORT,
                                                 gravity: ToastGravity.SNACKBAR,
                                                 timeInSecForIosWeb: 1,
                                                 backgroundColor: Colors.red,
                                                 textColor: Colors.white,
                                                 fontSize: 16.0
                                             );
                                              // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Wrong Answer!...")));
                                              ans = "";
                                            }
                                            widget.index1 = null;
                                            setState(() {});
                                          },
                                        // },
                                        child: Container(
                                          height: double.infinity,
                                          width: double.infinity,
                                          alignment: Alignment.center,
                                          child: Text("SUBMIT",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white),),
                                          // child: Image.asset("pic/delete.png"),
                                        ),
                                      ))
                                    ],
                                  )),
                                  Expanded(child: Row(
                                    children: [
                                      Expanded(child: GridView.builder(
                                        itemCount: 10,
                                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 10,
                                          crossAxisSpacing: 3,
                                          mainAxisSpacing: 3,
                                          // mainAxisExtent: 5
                                        ),
                                        // shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () {
                                              // Data.Ans[widget.index] =
                                              ans = ans + num[index].toString();
                                              print("ans := ${ans}");
                                              setState(() {});
                                            },
                                            child: Container(
                                              margin: EdgeInsets.only(left: 3.0,right: 3.0,top: 5.0,bottom: 5.0),
                                              height: 5,
                                              width: 5,
                                              alignment: Alignment.center,
                                              child: Text("${num[index]}",style: TextStyle(color: Colors.white),),
                                              // child: Text("${num[index]}",style: TextStyle(color: Colors.white),),
                                              decoration: BoxDecoration(
                                                // border: Border.all(width: 1.0,color: Colors.white,style: BorderStyle.solid)
                                                  border: Border.all(width: 1.0,color: Colors.white)
                                              ),
                                            ),
                                          );
                                        },))
                                    ],
                                  ))
                                ],
                              ),
                            )),
                          ],
                        )),
                      ],
                    ))
                  ],
                ),
                )
              ],
            )),
          ),
        );
  }
}






// InkWell(
//   onTap: () => showDialog(
//     barrierDismissible: true,
//     context: context,
//     builder: (context) => AlertDialog(
//       title: Text("Skip"),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.all(Radius.circular(15)),
//       ),
//       // shape: Border.all(width: 2.0,style: BorderStyle.solid,color: Colors.black),
//       content: Text("Are you sure you to skip this level?\nYou can play skipped levels later by clicking on PUZZLES menu form main screen."),
//       actions: [
//         TextButton(onPressed: () => Navigator.pop(context,'Cancel'),
//           child: Text('CANCEL'),
//         ),
//         TextButton(onPressed: () {
//           prefs!.setString('levelno${widget.cur_level}', 'skip');
//           widget.cur_level++;
//           ans="";
//           prefs!.setInt('level', widget.cur_level);
//           Navigator.pop(context);
//           setState(() {
//
//           });
//         },
//             child: Text('OK')
//         )
//       ],
//     ),),
//   child: Container(
//     height: 40,
//     width: 40,
//     alignment: Alignment.centerLeft,
//     margin: EdgeInsets.only(left: 10),
//     child: Image.asset("pic/skip.png"),
//   ),
// ),

// Container(
//   height: 40,
//   width: 40,
//   // height: double.infinity,
//   // width: double.infinity,
//   alignment: Alignment.centerLeft,
//   margin: EdgeInsets.only(left: 10),
//   child: Image.asset("pic/skip.png"),
// ),


// prefs!.setString('levelno${widget.cur_level}', 'win');
// widget.cur_level++;
// ans="";
// prefs!.setInt('level', widget.cur_level);
// setState(() {});
// Navigator.push(context, MaterialPageRoute(builder: (context) {
//   return win_page(widget.cur_level);
// },)
// );

// else
// {
//   Fluttertoast.showToast(
//       msg: "Wrong....!",
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.CENTER,
//       timeInSecForIosWeb: 1,
//       backgroundColor: Colors.red,
//       textColor: Colors.white,
//       fontSize: 16.0
//   );
//   ans = "";
//   setState(() {});
// }

