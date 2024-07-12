import 'package:flutter/material.dart';

class GameOfLifePainter extends CustomPainter {
  final List<List<bool>> grid;
  final int cellSize;

  GameOfLifePainter({required this.grid, required this.cellSize});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    for (int row = 0; row < grid.length; row++) {
      for (int col = 0; col < grid[row].length; col++) {
        if (grid[row][col]) {
          canvas.drawRect(
            Rect.fromLTWH(col * cellSize.toDouble(), row * cellSize.toDouble(),
                cellSize.toDouble(), cellSize.toDouble()),
            paint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
