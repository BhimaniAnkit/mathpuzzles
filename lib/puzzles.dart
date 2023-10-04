import 'package:flutter/material.dart';
import 'package:mathpuzzles/second.dart';
import 'Data.dart';
import 'main.dart';
import 'puzzle.dart';

class puzzles extends StatefulWidget {

  int index;
  List skip;
  puzzles(this.index,this.skip);

  @override
  State<puzzles> createState() => _puzzlesState();
}

class _puzzlesState extends State<puzzles> {

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showDialog(context: context, builder: (context) {
          return AlertDialog(
            title: Text("Are You Sure to Exit"),
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
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("pic/background.jpg"),
              fit: BoxFit.fill,
            )),
        child: Column(
          children: [
            Expanded(
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          height: double.infinity,
                          width: double.infinity,
                          margin: EdgeInsets.only(
                              left: 5.0, right: 5.0, top: 5.0, bottom: 5.0),
                          child: Text(
                            "Select Puzzle",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.purple.shade800),
                          ),
                        )),
                  ],
                )),
            Expanded(
              flex: 8,
              child: GridView.builder(
                itemCount: Data.puzzle_img.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemBuilder: (context, index) {
                  // print(index);
                  return  InkWell(
                    borderRadius: BorderRadius.circular(25.0),
                    onTap: () {
                      if(widget.skip[index] == "No"){
                      }
                      else{
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return puzzle(widget.index,index);
                          // return second(widget.index,index);
                        },));
                      }
                      // Navigator.push(context, MaterialPageRoute(builder: (context) {
                      //   return second(index);
                      // },));
                      setState(() {

                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      child: (widget.index >= index)?Text("${index+1}",style: TextStyle(fontSize: 20),):null,
                      // child: (index<widget.cur_level)?Text("${index+1}",style: TextStyle(fontSize: 20),):null,
                      margin: EdgeInsets.all(10.0),
                      height: double.infinity,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: (widget.index >= index)?Border.all(width: 3):null,
                          // border: (index<widget.cur_level)?Border.all(width: 3):null,
                          borderRadius: (widget.index >= index) ? BorderRadius.circular(20) : null,
                          image: (widget.index >= index) ? (widget.skip[index] == "yes") ? 
                              DecorationImage(image: AssetImage("pic/tick.png")) : null
                          : DecorationImage(image: AssetImage("pic/lock.png")),
                          // borderRadius: BorderRadius.circular(20),
                          // image: (index < widget.cur_level) ? (
                          //     widget.list[index] == "win") ? DecorationImage(
                          //     image: AssetImage("pic/tick.png"))
                          //     :null
                          //     :DecorationImage(image: AssetImage("pic/lock.png"))
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                          height: double.infinity,
                          width: double.infinity,
                          alignment: Alignment.bottomRight,
                          margin: EdgeInsets.only(right: 20.0),
                          child: Image.asset("pic/next.png"),
                        ))
                  ],
                ))
          ],
        ),
      ),
    ), );
  }
}
