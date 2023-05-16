import 'package:flutter/material.dart';
import 'dart:math';

import 'change_page_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
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
  late List<String> images;
  late int currentIndex;

  @override
  void initState() {
    currentIndex = 0;
    images = [
      'assets/images/chat1.jpeg',
      'assets/images/chat2.jpeg',
      //'assets/images/chat3.jpeg',
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter demo POI Flip'),
      ),
      body: GestureDetector(
        onHorizontalDragEnd: (details) => flipImage(details),
        child: Stack(
          children: <Widget>[
            Center(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                transform: Matrix4.identity()..rotateY(pi * currentIndex),
                child: Image.asset(
                  images[currentIndex],
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ChangePageButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onTap: () => updateImage((currentIndex - 1) % (images.length-1))
                  ),
                  ChangePageButton(
                      icon: const Icon(Icons.arrow_forward_ios),
                      onTap: () => updateImage((currentIndex + 1) % (images.length-1))
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void flipImage(DragEndDetails details) {
    if (details.velocity.pixelsPerSecond.dx > 0) {
      updateImage(currentIndex = (currentIndex - 1) % (images.length-1));
    } else if (details.velocity.pixelsPerSecond.dx < 0) {
      updateImage(currentIndex = (currentIndex + 1) % (images.length-1));
    }
  }

  void updateImage(int newIndex) {
    setState(() {
      currentIndex = newIndex;
    });
  }
}
