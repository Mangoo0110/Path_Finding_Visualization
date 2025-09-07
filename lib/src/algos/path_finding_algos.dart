
import 'dart:collection';

import 'package:flutter/widgets.dart';
import 'package:path_finding_visualization/src/controller/visualizer.dart';

import '../interfaces/path_finding_algorithm.dart';
import '../model/grid.dart';

class BfsAlgorithm extends PathFindingAlgorithmBase {
  BfsAlgorithm() : super(name: "BFS");
  

  @override
  findPath() async{
    if(grid == null) {
      debugPrint("Grid is null. Call init() first.");
      return Visualizer(visitedCellsInOrder: visitedCellsInOrder, shortestPathCellsInOrder: []);
    }
    // Start
    debugPrint("BFS Algorithm Started");
    Queue<Cell> queue = Queue();
    Cell? startCell = grid!.currentStartCell;
    Cell? endCell = grid!.currentEndCell;
    if (startCell == null || endCell == null) return Visualizer(visitedCellsInOrder: visitedCellsInOrder, shortestPathCellsInOrder: []);
    queue.add(startCell);
    Map<Cell, Cell?> parentMap = {};
    startCell.isVisited = true;
    parentMap[startCell] = null;
    while(queue.isNotEmpty) {
      Cell current = queue.removeFirst();
        if (current.isEnd) {
          // Path is found
          debugPrint("Path found!");
          _reconstructPath(parentMap, endCell);
          // exit the loop
          return Visualizer(visitedCellsInOrder: visitedCellsInOrder, shortestPathCellsInOrder: []);
        }
        
        List<Cell> neighbors = _getNeighbors(current);
        for (var neighbor in neighbors) {
          if (!neighbor.isVisited && !neighbor.isWall) {
            queue.add(neighbor);
            parentMap[neighbor] = current;
            neighbor.isVisited = true;
            await Future.delayed(const Duration(milliseconds: 15));
          }
        }
    }
    debugPrint("Done searching. No path found.");
    return Visualizer(visitedCellsInOrder: visitedCellsInOrder, shortestPathCellsInOrder: []);
  }

  List<Cell> _getNeighbors(Cell cell) {
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


  
  void _reconstructPath(Map<Cell, Cell?> parentMap, Cell endCell) async{
    Cell? current = endCell;
    debugPrint("Reconstructing path...");
    while (current != null) {
      current = parentMap[current];
      current?.isPath = true;
      
      // delay every animation
      await Future.delayed(const Duration(milliseconds: 10));
    }
  }
}


class DfsAlgorithm extends PathFindingAlgorithmBase {
  DfsAlgorithm():super(name: "DFS");

  // DFS algorithm implementation
  @override
  findPath() async{
    // Start
  }
}

class DijkstraAlgorithm extends PathFindingAlgorithmBase {
  DijkstraAlgorithm():super(name: "Dijkstra");

  // Dijkstra's algorithm implementation
  @override
  findPath() async{
    // Start
  }
}

class AStarAlgorithm extends PathFindingAlgorithmBase {
  AStarAlgorithm():super(name: "A*");

  // A* algorithm implementation
  @override
  findPath() async{
    // Start
  }
}