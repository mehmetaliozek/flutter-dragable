import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<String> colorImageName = [
    "circle-color.png",
    "pentagon-color.png",
    "triangle-color.png",
  ];

  List<String> imageName = [
    "circle.png",
    "pentagon.png",
    "triangle.png",
  ];

  List<String> data = [
    "circle",
    "pentagon",
    "triangle",
  ];

  List<bool> drag = [false, false, false];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (var i = 0; i < 3; i++)
                      Draggable(
                        data: data[i],
                        maxSimultaneousDrags: drag[i] == false ? 1 : 0,
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          height: 100,
                          width: 100,
                          child: Image(
                            image: AssetImage(
                              drag[i] == false
                                  ? "images/${colorImageName[i]}"
                                  : "images/${imageName[i]}",
                            ),
                          ),
                        ),
                        feedback: Container(
                          margin: const EdgeInsets.all(10),
                          height: 100,
                          width: 100,
                          child: Image(
                            image: AssetImage("images/${colorImageName[i]}"),
                          ),
                        ),
                        childWhenDragging: Container(
                          margin: const EdgeInsets.all(10),
                          height: 100,
                          width: 100,
                          child: Image(
                            image: AssetImage("images/${imageName[i]}"),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (var i = 0; i < 3; i++)
                      DragTarget(
                        builder: (context, candidateData, rejectedData) {
                          if (drag[i]) {
                            return Container(
                              margin: const EdgeInsets.all(10),
                              height: 100,
                              width: 100,
                              child: Image(
                                image:
                                    AssetImage("images/${colorImageName[i]}"),
                              ),
                            );
                          } else {
                            return Container(
                              margin: const EdgeInsets.all(10),
                              height: 100,
                              width: 100,
                              child: Image(
                                image: AssetImage("images/${imageName[i]}"),
                              ),
                            );
                          }
                        },
                        onWillAccept: (dragData) {
                          if (dragData == data[i]) {
                            return true;
                          } else {
                            return false;
                          }
                        },
                        onAccept: (dragData) {
                          setState(() {
                            drag[i] = true;
                          });
                        },
                      ),
                  ],
                ),
              ),
              Expanded(
                flex: 0,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      for (var i = 0; i < 3; i++) {
                        drag[i] = false;
                      }
                    });
                  },
                  child: const Text("Sıfırla"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
