import 'package:flutter/material.dart';
import 'package:poi_flip/transform_test.dart';
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

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  late List<String> images;
  late int currentIndex;

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    currentIndex = 0;
    images = [
      'assets/images/chat1.jpeg',
      'assets/images/chat2.jpeg',
      'assets/images/chat3.jpeg',
    ];

    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    final Tween<double> tween = Tween<double>(begin: 0, end: 1);

    _animation = tween.animate(_controller);
    _animation.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter demo POI Flip'),
      ),
      body: Stack(
        children: <Widget>[
          Center(
            child: GestureDetector(
              onHorizontalDragEnd: (details) => flipImage(details),
              child: Stack(children: [
                for (var image in images.reversed)
                  Transform(
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..rotateY(pi * _animation.value),
                        alignment: FractionalOffset.center,
                      child: Visibility(visible: currentIndex == images.indexOf(image), child: Image.asset(image, fit: BoxFit.cover))),
              ]),
            ),
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ChangePageButton(icon: const Icon(Icons.arrow_back_ios), onTap: () => updateImage((currentIndex - 1) % (images.length))),
                ChangePageButton(icon: const Icon(Icons.arrow_forward_ios), onTap: () => updateImage((currentIndex + 1) % (images.length))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void flipImage(DragEndDetails details) {
    if (details.velocity.pixelsPerSecond.dx > 0) {
      updateImage((currentIndex - 1) % (images.length));
    } else if (details.velocity.pixelsPerSecond.dx < 0) {
      updateImage((currentIndex + 1) % (images.length));
    }
  }

  double rotationValue() {
    setState(() {});
    return pi * _animation.value;
  }

  Future<void> updateImage(int newIndex) async {
    await _controller.forward();
    updateIndex(newIndex);
    _controller.reset();
  }

  void updateIndex(int newIndex) {
    currentIndex = newIndex;
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the animation controller
    super.dispose();
  }

  isIndexEven(int index) {
    return index % 2 == 0;
  }
}
