import 'dart:math';
import 'dart:async';
import 'package:myWebsite/widget/game_of_life/game_of_life_painter.dart';
import 'package:myWebsite/widget/game_of_life/patterns.dart';
import 'package:flutter/material.dart';

class GameOfLife extends StatefulWidget {
  final int rows;
  final int columns;
  final int cellSize;

  const GameOfLife({
    super.key,
    required this.rows,
    required this.columns,
    required this.cellSize,
  });

  @override
  State<GameOfLife> createState() => _GameOfLifeState();
}

class _GameOfLifeState extends State<GameOfLife> {
  late int rows;
  late int columns;
  late int cellSize;
  late List<List<bool>> grid;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    rows = widget.rows;
    columns = widget.columns;
    cellSize = widget.cellSize;
    grid = List.generate(rows, (_) => List.generate(columns, (_) => false));
    _initializeRandomPattern();
    _startGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onPanUpdate: (details) {
          Offset localPosition = details.localPosition;
          int row = (localPosition.dy / cellSize).floor();
          int col = (localPosition.dx / cellSize).floor();

          if (row >= 0 && row < rows && col >= 0 && col < columns) {
            _toggleCell(row, col);
          }
        },
        child: CustomPaint(
          size: Size(cellSize * columns.toDouble(), cellSize * rows.toDouble()),
          painter: GameOfLifePainter(grid: grid, cellSize: cellSize),
        ),
      ),
    );
  }

  void _initializeRandomPattern() {
    List<List<List<int>> Function()> patterns = [
      placePulsar,
      placeAcorn,
      placeEternity,
      placePentadecathlon,
      placeDiehard
    ];
    final random = Random();
    int patternIndex = random.nextInt(patterns.length);
    for (int i = 0; i < 10; i++) {
      int row = random.nextInt(rows - 20);
      int col = random.nextInt(columns - 36);
      _placePattern(row, col, patterns[patternIndex]());
    }
  }

  void _placePattern(int row, int col, List<List<int>> pattern) {
    for (int i = 0; i < pattern.length; i++) {
      for (int j = 0; j < pattern[i].length; j++) {
        if (row + i < rows && col + j < columns) {
          grid[row + i][col + j] = pattern[i][j] == 1;
        }
      }
    }
    setState(() {});
  }

  void _startGame() {
    _timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      setState(() {
        _updateGrid();
      });
    });
  }

  void _updateGrid() {
    List<List<bool>> newGrid =
        List.generate(rows, (_) => List.generate(columns, (_) => false));

    for (int row = 0; row < rows; row++) {
      for (int col = 0; col < columns; col++) {
        int livingNeighbors = _countLivingNeighbors(row, col);

        if (grid[row][col] && (livingNeighbors == 2 || livingNeighbors == 3)) {
          newGrid[row][col] = true;
        } else if (!grid[row][col] && livingNeighbors == 3) {
          newGrid[row][col] = true;
        }
      }
    }

    grid = newGrid;
  }

  int _countLivingNeighbors(int row, int col) {
    int count = 0;

    for (int i = -1; i <= 1; i++) {
      for (int j = -1; j <= 1; j++) {
        if (i == 0 && j == 0) continue;

        int newRow = row + i;
        int newCol = col + j;

        if (newRow >= 0 &&
            newRow < rows &&
            newCol >= 0 &&
            newCol < columns &&
            grid[newRow][newCol]) {
          count++;
        }
      }
    }

    return count;
  }

  void _toggleCell(int row, int col) {
    setState(() {
      grid[row][col] = true;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
