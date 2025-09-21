import 'dart:collection';

import 'package:flutter/foundation.dart';

import '../interfaces/path_finding_algorithm.dart';
import '../model/grid.dart';

class BfsAlgorithm extends PathFindingAlgorithm {
  BfsAlgorithm() : super(name: "BFS");
  

  @override
  Future<void>  findShortestPath() async{
    if(grid == null) {
      debugPrint("Grid is null. Call init() first.");
      return;
    }
    // Start
    debugPrint("Starting BFS");
    Queue<Cell> queue = Queue();
    Cell? startCell = grid!.currentStartCell;
    Cell? endCell = grid!.currentEndCell;
    if (startCell == null || endCell == null) return;
    queue.add(startCell);
    startCell.isVisited = true;
    parentMap[startCell] = null;
    while(queue.isNotEmpty) {
      Cell current = queue.removeFirst();
        if (current.isEnd) {
          // Path is found
          debugPrint("Path found!");
          constructPath();
          // exit the loop
          return;
        }
        
        List<Cell> neighbors = getNeighbors(current);
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
    return;
  }

  


  
  @override
  Future<void> constructPath() async{
    Cell? current = grid!.currentEndCell;
    debugPrint("Reconstructing path...");
    while (current != null) {
      current = parentMap[current];
      current?.isPath = true;
      
      // delay every animation
      await Future.delayed(const Duration(milliseconds: 10));
    }
  }
}
