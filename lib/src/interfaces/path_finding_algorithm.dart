
import 'package:flutter/material.dart';
import 'package:path_finding_visualization/src/controller/visualizer.dart';

import '../model/grid.dart';

abstract class PathFindingAlgorithm {
  Grid? grid;
  final String name;
  PathFindingAlgorithm({required this.name});
  @protected
  List<Cell> visitedCellsInOrder = [];
  @protected
  Map<Cell, Cell?> parentMap = {};
  void init(Grid grid) {
    this.grid = grid;
    visitedCellsInOrder = [];
  }
  Future<void> findShortestPath();
  Future<void>constructPath();

  List<Cell> getNeighbors(Cell cell) {
    try {
    //debugPrint("Getting neighbors for Cell: (${cell.row}, ${cell.col})");
      List<Cell> neighbors = <Cell>[];
      int row = cell.row;
      int col = cell.col;
      //debugPrint("up neighbour: (${row - 1}, $col)");
      if (row > 0 && (!grid!.cells[row - 1][col].isVisited && !grid!.cells[row - 1][col].isWall)) neighbors.add(grid!.cells[row - 1][col]); // Up
      //debugPrint("down neighbour: (${row + 1}, $col)");
      if (row < grid!.rows - 1 && (!grid!.cells[row + 1][col].isVisited && !grid!.cells[row + 1][col].isWall)) neighbors.add(grid!.cells[row + 1][col]); // Down
      //debugPrint("left neighbour: ($row, ${col - 1})");
      if (col > 0 && (!grid!.cells[row][col - 1].isVisited || !grid!.cells[row][col - 1].isWall)) neighbors.add(grid!.cells[row][col - 1]); // Left
      //debugPrint("right neighbour: ($row, ${col + 1})");
      if (col < grid!.cols - 1 && (!grid!.cells[row][col + 1].isVisited || !grid!.cells[row][col + 1].isWall)) neighbors.add(grid!.cells[row][col + 1]); // Right
      
      return neighbors;
    } catch (e) {
      debugPrint("Error getting neighbors: $e");
      return [];
    }
  }
}
