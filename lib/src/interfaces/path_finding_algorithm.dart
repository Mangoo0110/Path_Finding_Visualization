
import 'package:flutter/material.dart';
import 'package:path_finding_visualization/src/controller/visualizer.dart';

import '../model/grid.dart';

abstract class PathFindingAlgorithmBase {
  Grid? grid;
  final String name;
  PathFindingAlgorithmBase({required this.name});
  @protected
  List<Cell> visitedCellsInOrder = [];
  void init(Grid grid) {
    this.grid = grid;
    visitedCellsInOrder = [];
  }
  findPath();
}
