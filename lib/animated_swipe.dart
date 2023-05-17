import 'package:flutter/material.dart';
import 'dart:math';

class AnimatedSwipe extends StatefulWidget {
  const AnimatedSwipe({Key? key}) : super(key: key);

  @override
  State<AnimatedSwipe> createState() => _AnimatedSwipeState();
}

class _AnimatedSwipeState extends State<AnimatedSwipe> with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _animation;


  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..repeat(reverse: true);

    final curve = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut, // Choose your desired curve here
    );

    _animation = Tween(begin: -0.05, end: 0.05).animate(curve);


    super.initState();
  }

  @override
  void dispose(){
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return RotationTransition(
          turns: _animation,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.swipe, size: 30,),
            ],
          ),
        );
      },
    );
  }
}
