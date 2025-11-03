import 'dart:async';
import 'dart:math';

import 'package:Minesweeper/domain/case.dart';
import 'package:Minesweeper/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class Game extends StatefulWidget {
  const Game({super.key});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {

  List <Case> cases = [];

  int seconds = 0;
  Timer? timer;
  var time = "".obs;
  bool xx = true;
  int t = 0;

  var flag = false.obs;
  var dig = true.obs;

  int count = 0;
  var help = 2.obs;
  var br = 25.obs;
  var end = false.obs;

  bool start = true;
  
  @override
  void initState() {
    time.value = "00:00";
    List <Case>? temp = putMines(); 
    cases = env(temp);

    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
     if (xx) {
       seconds++;
  if (seconds==300) {
    showdialog("TIME OUT","PLAY AGAIN","MAIN MENU", Game(), MyHomePage(), false, false);
    
  }

  if (seconds < 60) {
    time.value = "00:${seconds.toString().padLeft(2, '0')}";
  } else {
    int minutes = seconds ~/ 60;
    int secondss = seconds % 60;
    time.value = "${minutes.toString().padLeft(2, '0')}:${secondss.toString().padLeft(2, '0')}";
  }
     }
});


    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    const int cols = 8;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 200, 216, 224),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: const BoxDecoration(
         image: DecorationImage(
          image: AssetImage("assets/background.jpg"),
          fit: BoxFit.cover, 
         ),
        ),
        child: Column(
          children: [
            SizedBox(height: 40,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    showdialog("YOU WANT TO GO BACK?", "YES", "NO", MyHomePage(), Game(), false, true);
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 11),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset('assets/arrow.png'),
                  ),
                ),
                Container(
                 height: 45,
                 width: 120,
                 decoration: BoxDecoration(
                  color: const Color.fromARGB(227, 19, 22, 19),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  border: Border.all(color: const Color.fromARGB(255, 92, 24, 19),width: 2)
                  ),
                 child: Obx(()=> Center(child: Text(time.value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: const Color.fromARGB(255, 183, 50, 40), fontFamily: "Rubik")))) 
                ),
                InkWell(
                  onTap: () {
                    showdialog("PAUSE","CONTINUE","RESTART", MyHomePage(), Game(), true, false);
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 11),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Image.asset('assets/pause.png'),
                  ),
                ),
              ],
            ),
            Text("You have 5 minutes!", style: TextStyle(fontSize: 6, fontWeight: FontWeight.bold,color: const Color.fromARGB(197, 183, 164, 40), fontFamily: "Rubik")),
            
              SizedBox(
                height: 608,
                child: GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: cols),
                          itemCount: cases.length,
                          itemBuilder: (context, index) {
                           return casee(key: UniqueKey(),index: index,casa: cases[index], flag: flag,dialog: ()=> showdialog("GAME OVER!","PLAY AGAIN","MAIN MENU", Game(), MyHomePage(), false, false), counting: counting, end: end,decrement: flags,debut: (int i)=> debut(i),start: start,);
                          },
                        ),
              ),
  
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 40,
                  width: 80,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: const Color.fromARGB(255, 72, 72, 72)
                      
                  ),
                  child: Row(
                    children: [
                      Image.asset('assets/mine.png'),
                      SizedBox(width: 5),
                      Obx(()=> Text("$br", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white))),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      Obx(
                  ()=> InkWell(
                    onTap: () {
                      dig.value = true;
                      flag.value = false;
                    },
                    child: Container(
                      height: 60,
                      width: 60,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                         topLeft: Radius.circular(5),
                         bottomLeft: Radius.circular(5),
                        ),
                        border: Border(
                          left: BorderSide(color: Colors.black, width: 2),
                          right: BorderSide(color: Colors.black, width: 1.3),
                          top: BorderSide(color: Colors.black, width: 2),
                          bottom: BorderSide(color: Colors.black, width: 2)
                        ),
                        color: dig.value? Color.fromARGB(255, 216, 216, 216): Color.fromARGB(255, 139, 139, 139),
                      ),
                      child: Image.asset("assets/shovel.png"),
                    ),
                  ),
                ),
                Obx(
                  ()=> InkWell(
                    onTap: () {
                      flag.value = true;
                      dig.value = false;
                    },
                    child: Container(
                      height: 60,
                      width: 60,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                         topRight: Radius.circular(5),
                         bottomRight: Radius.circular(5),
                        ),
                        border: Border(
                          left: BorderSide(color: Colors.black, width: 1.3),
                          right: BorderSide(color: Colors.black, width: 2),
                          top: BorderSide(color: Colors.black, width: 2),
                          bottom: BorderSide(color: Colors.black, width: 2)
                        ),
                        color: flag.value? Color.fromARGB(255, 216, 216, 216): Color.fromARGB(255, 139, 139, 139),
                      ),
                      child: Image.asset("assets/flag.png"),
                    ),
                  ),
                ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: (){
                    if (help>0) {
                      help--;
                    }
                  },
                  child: Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),          
                    ),
                    child: Stack(
                      children: [
                       Padding(
                        padding: EdgeInsets.all(5),
                         child: Container(
                           height: 50,
                           width: 50,
                           padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: const Color.fromARGB(255, 72, 72, 72)
                            ),
                           child: Image.asset("assets/idea.png"),
                          ),
                        ), 
                      Positioned(
                        right: 4,
                        top: 0,
                        child: Obx(
                          ()=> (help>0)? Container(
                            height: 25,
                            width: 25,
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: const Color.fromARGB(255, 255, 255, 255)
                                
                            ),
                            child: Center(child: Text("$help", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color: const Color.fromARGB(255, 146, 136, 26)))),
                          ): SizedBox.shrink()
                        ),
                      )
                      ]
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void debut(int i) {
    start = false;
    setState(() {

      cases[i].mined = false;
      cases[i].covered = false;
      cases[i].bombsAr = 0;
      if (cases[i].mined) {
        t++;
      }

      if (i<8) {
        if (i>0) {
          if (cases[i-1].mined) {
            cases[i-1].mined = false;
            t++;
          }
          cases[i-1].covered = false;
          cases[i-1].bombsAr = cases[i-1].bombsAr -4;
        }

        if (cases[i+1].mined) {
          cases[i+1].mined = false;
          t++;
        }
        cases[i+1].covered = false;
        cases[i+1].bombsAr = cases[i+1].bombsAr -4;

        if (cases[i+7].mined) {
          cases[i+7].mined = false;
          t++;
        }
        cases[i+7].covered = false;
        cases[i+7].bombsAr = cases[i+7].bombsAr -3;

        if (cases[i+8].mined) {
          cases[i+8].mined = false;
          t++;
        }
        cases[i+8].covered = false;
        cases[i+8].bombsAr = cases[i+8].bombsAr -4;

        if (cases[i+9].mined) {
          cases[i+9].mined = false;
          t++;
        }
        cases[i+9].covered = false;
        cases[i+9].bombsAr = cases[i+9].bombsAr -3;
      }
    
      if (i>7 && i<105) {
        if (cases[i-9].mined) {
          cases[i-9].mined = false;
          t++;
        }
        cases[i-9].covered = false;
        cases[i-9].bombsAr = cases[i-9].bombsAr -3;

        if (cases[i-8].mined) {
          cases[i-8].mined = false;
          t++;
        }
        cases[i-8].covered = false;
        cases[i-8].bombsAr = cases[i-8].bombsAr -4;

        if (cases[i-7].mined) {
          cases[i-7].mined = false;
          t++;
        }
        cases[i-7].covered = false;
        cases[i-7].bombsAr = cases[i-7].bombsAr -3;

        if (cases[i-1].mined) {
          cases[i-1].mined = false;
          t++;
        }
        cases[i-1].covered = false;
        cases[i-1].bombsAr = cases[i-1].bombsAr -4;

        if (cases[i+1].mined) {
          cases[i+1].mined = false;
          t++;
        }
        cases[i+1].covered = false;
        cases[i+1].bombsAr = cases[i+1].bombsAr -4;

        if (cases[i+7].mined) {
          cases[i+7].mined = false;
          t++;
        }
        cases[i+7].covered = false;
        cases[i+7].bombsAr = cases[i+7].bombsAr -3;

        if (cases[i+8].mined) {
          cases[i+8].mined = false;
          t++;
        }
        cases[i+8].covered = false;
        cases[i+8].bombsAr = cases[i+8].bombsAr -4;

        if (cases[i+9].mined) {
          cases[i+9].mined = false;
          t++;
        }
        cases[i+9].covered = false;
        cases[i+9].bombsAr = cases[i+9].bombsAr -3;
      }
      if (i>104) {
        if (cases[i-9].mined) {
          cases[i-9].mined = false;
          t++;
        }
        cases[i-9].covered = false;
        cases[i-9].bombsAr = cases[i-9].bombsAr -3;

        if (cases[i-8].mined) {
          cases[i-8].mined = false;
          t++;
        }
        cases[i-8].covered = false;
        cases[i-8].bombsAr = cases[i-8].bombsAr -4;

        if (cases[i-7].mined) {
          cases[i-7].mined = false;
          t++;
        }
        cases[i-7].covered = false;
        cases[i-7].bombsAr = cases[i-7].bombsAr -3;

        if (cases[i-1].mined) {
          cases[i-1].mined = false;
          t++;
        }
        cases[i-1].covered = false;
        cases[i-1].bombsAr = cases[i-1].bombsAr -4;

        if (i<111) {
          if (cases[i+1].mined) {
            cases[i+1].mined = false;
            t++;
          }
          cases[i+1].covered = false;
          cases[i+1].bombsAr = cases[i-1].bombsAr -4;
        }
      }
      br.value = br.value - t;
      cases = env(cases);
    });
}




  Future<int?> counting(bool x) async {
    if (x) {
      count++;
      print(count);
    }
    if (count == 87+t) {
      end.value = true;
      await Future.delayed(Duration(seconds: 1));
      showdialog("YOU WON!","PLAY AGAIN","MAIN MENU", Game(), MyHomePage(), false, false);
    }
    if (!x) {
      return count;
    }
    return null;
  }

  void flags(bool x){
    if (x && br > 0) {
      br--;
    }
    if (!x) {
      br++;
    }
  }


  List<int> generateMines(int count, int max) {
  final random = Random();
  final numbers = <int>{}; 

  while (numbers.length < count) {
    numbers.add(random.nextInt(max)); 
  }

  return numbers.toList();
}

List<Case> putMines() {
  List<Case> list = List.generate(112, (_) => Case(covered: true, bombsAr: 0, mined: false));

  List<int> minedCases = generateMines(25, 112);

  for (var i in minedCases) {
    list[i].mined = true;
  }

  return list;
}
  List<Case> env(List<Case> list) {
  const int width = 8;
  const int height = 14; 

  for (int i = 0; i < list.length; i++) {
    int count = 0;

    int x = i % width;
    int y = i ~/ width;

    for (int dx = -1; dx <= 1; dx++) {
      for (int dy = -1; dy <= 1; dy++) {
        if (dx == 0 && dy == 0) continue; 

        int nx = x + dx;
        int ny = y + dy;

        if (nx >= 0 && nx < width && ny >= 0 && ny < height) {
          int neighborIndex = ny * width + nx;
          if (list[neighborIndex].mined) {
            count++;
          }
        }
      }
    }

    list[i].bombsAr = count;
  }

  return list;
}

void uncoverBombs(){

}

void showdialog(String content, String bluebtn, String purplebtn, Widget page1, Widget page2, bool pause, bool pop){
    xx = false;
    showGeneralDialog(
     context: context,
     barrierDismissible: false,
     barrierLabel: content,
     barrierColor: Colors.black.withOpacity(0.85),
     transitionDuration: const Duration(milliseconds: 300),
     pageBuilder: (context, animation, secondaryAnimation) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                content,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(255, 252, 252, 252),
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Cairo"
                ),
              ),
              const SizedBox(height: 300),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(300, 50),
                  backgroundColor: const Color.fromARGB(255, 13, 44, 77),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onPressed: () {
                  if (pause) {
                    Navigator.pop(context);
                    xx = true;
                  }else{
                    Navigator.pop(context);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => page1),
                    );
                  }
                },
                child: Text(
                  bluebtn,
                  style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(300, 50),
                  backgroundColor: const Color.fromARGB(255, 71, 7, 52),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onPressed: () {
                  if (pop) {
                    Navigator.pop(context);
                    xx = true;
                  }else{
                    Navigator.pop(context);
                    Navigator.pushReplacement(
                     context,
                     MaterialPageRoute(builder: (context) => page2),
                    );
                  }
                },
                child: Text(
                  purplebtn,
                  style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
  }
}


class casee extends StatefulWidget {
  const casee({super.key,required this.index, required this.casa, required this.flag, required this.dialog, required this.counting, required this.end, required this.decrement, required this.debut, required this.start});

  final int index;
  final Case casa;
  final RxBool flag;
  final Function dialog;
  final Function counting;
  final Function decrement;
  final void Function(int) debut;
  final RxBool end;
  final bool start;

  @override
  State<casee> createState() => _caseeState();
}

class _caseeState extends State<casee> {

  late bool isThereAbombAround;
  late bool isItMined;
  var isItCovered = true.obs;
  var flaged = false.obs;
  
  @override
  void initState() {
    isThereAbombAround = false;
    isItMined = false;
    if (widget.casa.mined) {
      isItMined = true;
    }
    if (widget.casa.bombsAr > 0 && !isItMined) {
      isThereAbombAround = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int? bombsAround = widget.casa.bombsAr;
    return Obx(
      ()=> InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async {
        if (isItCovered.value == true && !isItMined && widget.flag.value == false && flaged.value == false) {
          isItCovered.value = false;
          if (widget.start) {
            widget.debut(widget.index);
          }else{
            widget.counting(true);
          }
        }
        if (isItMined && widget.flag.value == false) {
          if (widget.start) {
            widget.debut(widget.index);
          }else{
            widget.end.value = true;
            await Future.delayed(Duration(seconds: 1, milliseconds: 500));
            widget.dialog();
            
          }
        }
        if (widget.flag.value && isItCovered.value) {
          flaged.value = !flaged.value;
          if (flaged.value) {
            widget.decrement(true);
          }else{
            widget.decrement(false);
          }
        }
      },
      onLongPress: () {
        flaged.value = !flaged.value;
          if (flaged.value) {
            widget.decrement(true);
          }else{
            widget.decrement(false);
          }
      },
      child: Container(
        height: 40,
        width: 40,
         decoration: BoxDecoration(
         borderRadius: BorderRadius.circular(10),),
         child: (isThereAbombAround && !isItCovered.value)? Container(
              child:  Center(child: Text("$bombsAround", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: const Color.fromARGB(255, 183, 50, 40), fontFamily: "Rubik"))) 
            ):
            (isItMined && !isItCovered.value)? Container(
              child: Image.asset("assets/explode.png",height: 40,width: 40)
            ):
            Opacity(
            opacity: isItCovered.value? 1.0 : 0.0,
            child: (widget.end.value && isItMined)? Image.asset("assets/caseMined.png",height: 40,width: 40):flaged.value? Image.asset("assets/caseFlaged.png",height: 40,width: 40) : Image.asset("assets/case.png",height: 40,width: 40),
           ),
         )
        ),
    );
  }

}

