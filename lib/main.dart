import 'package:flutter/material.dart';

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

  @override
  void initState() {

    images = [
      'assets/images/chat1.jpeg',
      'assets/images/chat2.jpeg',
      'assets/images/chat3.jpeg',
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter demo POI Flip'),
      ),
      body: Center(
        child: Stack(
          children: <Widget>[
            for(var image in images) Image(image: AssetImage(image))
          ],
        ),
      ),
    );
  }
}
