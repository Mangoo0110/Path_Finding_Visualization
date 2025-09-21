import 'package:flutter/foundation.dart';

import '../interfaces/path_finding_algorithm.dart';
import '../model/grid.dart';


class DijkstraAlgorithm extends PathFindingAlgorithm {
  DijkstraAlgorithm():super(name: "Dijkstra");

  // Dijkstra's algorithm implementation
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