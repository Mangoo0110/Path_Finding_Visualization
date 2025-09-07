
import 'package:flutter/material.dart';

part 'cell.dart';

class Grid{
  final int rows;
  final int cols;
  late List<List<Cell>> cells;

  Cell? _currentStartCell;
  Cell? get currentStartCell => _currentStartCell;
  Cell? _currentEndCell;
  Cell? get currentEndCell => _currentEndCell;

  Grid({required this.rows, required this.cols}) {
    assert(rows > 0 && cols > 0, "Rows and Columns must be greater than 0");
    cells = List.generate(rows, (row) {
      return List.generate(cols, (col) => Cell(row: row, col: col));
    });
  }

  // set start cell
  void setStart(int row, int col) {
    if(row < 0 || row >= rows || col < 0 || col >= cols) {
      throw Exception("Invalid cell position");
    }
    if (_currentStartCell != null) {
      _currentStartCell!.isStart = false;
    }
    cells[row][col].isStart = true;
    _currentStartCell = cells[row][col];
    reset();
  }

  // set end cell
  void setEnd(int row, int col) {
    if(row < 0 || row >= rows || col < 0 || col >= cols) {
      throw Exception("Invalid cell position");
    }
    if (_currentEndCell != null) {
      _currentEndCell!.isEnd = false;
    }
    cells[row][col].isEnd = true;
    _currentEndCell = cells[row][col];
    reset();
  }

  // reset grid
  void reset({bool keepWalls = false}) {
    for (var row in cells) {
      for (var cell in row) {
        cell._reset();
      }
    }
  }
}