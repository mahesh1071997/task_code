
import 'package:flutter/material.dart';

enum MoveDirection { left, right }

class SquareAnimation extends StatefulWidget {
  const SquareAnimation({super.key});

  @override
  State<SquareAnimation> createState() => _SquareAnimationState();
}

class _SquareAnimationState extends State<SquareAnimation> {
  static const double _squareSize = 50.0;
  bool _isMoving = true;
  AlignmentGeometry _alignment = Alignment.center;

  // Handle alignment updates and disable buttons during movement
  void _moveSquare(MoveDirection direction) {
    setState(() {
      _isMoving = false;
      _alignment = direction == MoveDirection.right
          ? Alignment.centerRight
          : Alignment.centerLeft;
    });

    // Re-enable buttons after animation duration , set 1 seconds for the animation
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isMoving = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: double.infinity,
          child: AnimatedContainer(
            duration: const Duration(seconds: 1),
            curve: Curves.fastOutSlowIn,
            alignment: _alignment,
            height: _squareSize,
            child: Container(
              width: _squareSize,
              height: _squareSize,
              decoration: BoxDecoration(
                color: Colors.red,
                border: Border.all(),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _isMoving && _alignment != Alignment.centerRight
                  ? () => _moveSquare(MoveDirection.right)
                  : null,
              child: const Text('Right'),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: _isMoving && _alignment != Alignment.centerLeft
                  ? () => _moveSquare(MoveDirection.left)
                  : null,
              child: const Text('Left'),
            ),
          ],
        ),
      ],
    );
  }
}

