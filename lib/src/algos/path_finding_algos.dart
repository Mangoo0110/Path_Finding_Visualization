
import 'dart:collection';

import 'package:flutter/widgets.dart';
import 'package:path_finding_visualization/src/controller/visualizer.dart';

import '../interfaces/path_finding_algorithm.dart';
import '../model/grid.dart';

class BfsAlgorithm extends PathFindingAlgorithmBase {
  BfsAlgorithm() : super(name: "BFS");
  

  @override
  Future<Visualizer> findPath() async{
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
    while(queue.isNotEmpty) {
      Cell current = queue.removeFirst();
        if (current == endCell) {
          // Path is found
          debugPrint("Path found!");
          _reconstructPath(parentMap, endCell);
          // exit the loop
          return Visualizer(visitedCellsInOrder: visitedCellsInOrder, shortestPathCellsInOrder: []);
        }
        current.isVisited = true;
        debugPrint("Visiting Cell: (${current.row}, ${current.col})");
        // delay every animation
        await Future.delayed(const Duration(microseconds: 0));
        visitedCellsInOrder.add(current);
        
        List<Cell> neighbors = _getNeighbors(current);
        for (var neighbor in neighbors) {
          if (!neighbor.isVisited && !neighbor.isWall) {
            queue.add(neighbor);
            parentMap[neighbor] = current;
          }
        }
    }
    return Visualizer(visitedCellsInOrder: visitedCellsInOrder, shortestPathCellsInOrder: []);
  }

  _getNeighbors(Cell cell) {
    List<Cell> neighbors = [];
    int row = cell.row;
    int col = cell.col;
    if (row > 0) neighbors.add(grid!.cells[row - 1][col]); // Up
    if (row < grid!.rows - 1) neighbors.add(grid!.cells[row + 1][col]); // Down
    if (col > 0) neighbors.add(grid!.cells[row][col - 1]); // Left
    if (col < grid!.cols - 1) neighbors.add(grid!.cells[row][col + 1]); // Right
    return neighbors;
  }
  
  void _reconstructPath(Map<Cell, Cell?> parentMap, Cell endCell) async{
    Cell? current = endCell;
    while (current != null) {
      current.isPath = true;
      current = parentMap[current];
      // delay every animation
      await Future.delayed(const Duration(milliseconds: 25));
    }
  }
}


class DfsAlgorithm extends PathFindingAlgorithmBase {
  DfsAlgorithm():super(name: "DFS");

  // DFS algorithm implementation
  @override
  Future<Visualizer> findPath() async{
    // Start
    return Visualizer(visitedCellsInOrder: [], shortestPathCellsInOrder: []);
  }
}

class DijkstraAlgorithm extends PathFindingAlgorithmBase {
  DijkstraAlgorithm():super(name: "Dijkstra");

  // Dijkstra's algorithm implementation
  @override
  Future<Visualizer> findPath() async{
    // Start
    return Visualizer(visitedCellsInOrder: [], shortestPathCellsInOrder: []);
  }
}

class AStarAlgorithm extends PathFindingAlgorithmBase {
  AStarAlgorithm():super(name: "A*");

  // A* algorithm implementation
  @override
  Future<Visualizer> findPath() async{
    // Start
    return Visualizer(visitedCellsInOrder: [], shortestPathCellsInOrder: []);
  }
}