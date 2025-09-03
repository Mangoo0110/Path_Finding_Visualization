import '../model/grid.dart';

class Visualizer {
  final List<Cell> visitedCellsInOrder;
  final List<Cell> shortestPathCellsInOrder;

  Visualizer({required this.visitedCellsInOrder, required this.shortestPathCellsInOrder});

  void visualize() {
    // Visualization logic here
    for (var cell in visitedCellsInOrder) {
      // e.g., change cell color to indicate it has been visited
      cell.visualizeVisited = true;
    }
    for (var cell in shortestPathCellsInOrder) {
      // e.g., change cell color to indicate it is part of the shortest path
      cell.visualizePath = true;
    }
  }
}