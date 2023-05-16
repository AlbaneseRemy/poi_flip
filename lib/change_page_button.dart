import 'package:flutter/material.dart';

class ChangePageButton extends StatelessWidget {

  final Icon icon;
  final Function() onTap;


  const ChangePageButton({Key? key, required this.icon, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: onTap, icon: icon);
  }
}
