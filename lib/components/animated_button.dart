import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimal/pages/quiz_page.dart';

class AnimatedButton extends StatefulWidget {
  final double height;
  final double width;
  final String buttonText;
  final Color color;
  late double fontSize;
  final VoidCallback onTap;

  AnimatedButton(
      {required this.onTap,
      required this.height,
      required this.width,
      required this.buttonText,
      required this.fontSize,
      required this.color});

  @override
  _AnimatedButtonState createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;
  late Color textColor;

  @override
  void initState() {
    super.initState();
    textColor = widget.color;
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    animation = Tween(begin: 0.0, end: widget.height).animate(
      CurvedAnimation(
        curve: Curves.easeIn,
        parent: controller,
      ),
    )..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: widget.height,
        width: widget.width,
        child: Material(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
            side: BorderSide(width: 3.0, color: widget.color),
          ),
          child: InkWell(
              onHover: (value) {
                if (value) {
                  controller.forward();
                  setState(() {
                    textColor = Colors.white;
                  });
                } else {
                  controller.reverse();
                  setState(() {
                    textColor = widget.color;
                  });
                }
              },
              onTap: widget.onTap,
              child: Stack(
                children: <Widget>[
                  Center(
                    child: Container(
                      height: animation.value,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: widget.color,
                      ),
                    ),
                  ),
                  Center(
                    child: AnimatedDefaultTextStyle(
                      child: Text(widget.buttonText),
                      duration: Duration(milliseconds: 200),
                      style: TextStyle(
                        fontSize: widget.fontSize,
                        color: textColor,
                        fontWeight: FontWeight.bold,
                      ),
                      curve: Curves.easeIn,
                    ),
                  )
                ],
              )),
        ));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
