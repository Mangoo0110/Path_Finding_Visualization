

import 'package:flutter/foundation.dart';

import '../interfaces/path_finding_algorithm.dart';
import '../model/grid.dart';

class DfsAlgorithm extends PathFindingAlgorithm {
  DfsAlgorithm():super(name: "DFS");

  // DFS algorithm implementation
  @override
  findShortestPath() async{
    if(grid == null) {
      debugPrint("Grid is null. Call init() first.");
      return;
    }
    if(grid!.currentStartCell == null || grid!.currentEndCell == null) {
      debugPrint("Start or End cell is not set.");
      return;
    }
    // Start
    debugPrint("Starting DFS");
    _dfs(grid!.currentStartCell!);
    return;
  }

  Future<bool> _dfs(Cell cell) async {
    if (cell.isEnd) {
      // Path is found
      debugPrint("Path found!");
      return true;
    }
    
    //visitedCellsInOrder.add(cell);
    await Future.delayed(const Duration(milliseconds: 15));
    List<Cell> neighbors = getNeighbors(cell);
    for (var neighbor in neighbors) {
      if (!neighbor.isVisited && !neighbor.isWall) {
        cell.isVisited = true;
        parentMap[neighbor] = cell;
        bool found = await _dfs(neighbor);
        if (found) {
          cell.isPath = true;
          return true;
        }
      }
    }
    return false;
  }
  
  @override
  Future<void> constructPath() {
    // TODO: implement constructPath
    throw UnimplementedError();
  }
  

  
}
