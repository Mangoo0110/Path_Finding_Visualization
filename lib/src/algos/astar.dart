import 'dart:collection';

import 'package:flutter/foundation.dart';

import '../interfaces/path_finding_algorithm.dart';
import '../model/grid.dart';


class AStarAlgorithm extends PathFindingAlgorithm {
  AStarAlgorithm():super(name: "A*");

  // A* algorithm implementation
  @override
  findShortestPath() async{
    // Start
  }
  
  @override
  Future<void> constructPath() {
    // TODO: implement reconstructPath
    throw UnimplementedError();
  }
}