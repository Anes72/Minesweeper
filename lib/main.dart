import 'package:Minesweeper/game.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 41, 42, 42),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: const BoxDecoration(
         image: DecorationImage(
          image: AssetImage("assets/background.jpg"),
          fit: BoxFit.cover, 
         ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 100),
            const Text(
                "WELCOME TO MINESWEEPER!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(255, 252, 252, 252),
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
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
                  Navigator.of(context).push(animation(Game()));
                },
                child: const Text(
                  "NEW GAME",
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
                  // Navigator.pushReplacement(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => const MyHomePage()),
                  // );
                },
                child: const Text(
                  "LAST GAME",
                  style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 5),
              Text("Currently unavailable.", style: TextStyle(fontSize: 6, fontWeight: FontWeight.bold,color: const Color.fromARGB(197, 183, 164, 40), fontFamily: "Rubik")),
              SizedBox(height: 70),
              Text(
                "CREATOR :",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(255, 252, 252, 252),
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "ANES LOUBAR",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(255, 252, 252, 252),
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
      ),
    );
  }
  Route animation(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      final tween = Tween(begin: begin, end: end)
          .chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
}

