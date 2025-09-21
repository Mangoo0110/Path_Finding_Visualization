
import 'dart:math';
import 'package:flutter/widgets.dart';
import 'package:path_finding_visualization/src/algos/path_finding_algos.dart';
import '../algos/astar.dart';
import '../algos/bfs.dart';
import '../algos/dfs.dart';
import '../algos/djikstra.dart';
import '../interfaces/path_finding_algorithm.dart';
import '../model/grid.dart';
 

enum UserActionState {
  setStart,
  setEnd,
  setWall,
  none,
}

class GridBrickViewController extends ChangeNotifier {
  PathFindingAlgorithm? _selectedAlgorithm;
  List<PathFindingAlgorithm> get algorithms => [
        BfsAlgorithm(),
        DfsAlgorithm(),
        DijkstraAlgorithm(),
        AStarAlgorithm(),
      ];
  UserActionState _currentUserActionState = UserActionState.none;
  UserActionState get currentUserActionState => _currentUserActionState;
  void onTapOfCell(Cell cell) {
    switch (_currentUserActionState) {
      case UserActionState.setStart:
        if (!cell.isEnd && !cell.isWall) {
          grid.setStart(cell.row, cell.col);
          _currentUserActionState = UserActionState.none;
          notifyListeners();
        }
        break;
      case UserActionState.setEnd:
        if (!cell.isStart && !cell.isWall) {
          grid.setEnd(cell.row, cell.col);
          _currentUserActionState = UserActionState.none;
          notifyListeners();
        }
        break;
      case UserActionState.setWall:
        // do nothin
        break;
      case UserActionState.none:
        if(cell.isStart) {
          _currentUserActionState = UserActionState.setStart;
        } else if(cell.isEnd) {
          _currentUserActionState = UserActionState.setEnd;
        } else if(cell.isWall) {
          cell.isWall = false;
        } else {
          _currentUserActionState = UserActionState.none;
        }
        break;
    }
  }

  late Grid grid;

  GridBrickViewController();

  init({required int rows, required int cols}) {
    grid = Grid(rows: rows, cols: cols);
    // randomize start and end
    final random = Random();
    int startRow = random.nextInt(rows);
    int startCol = random.nextInt(cols);
    int endRow = random.nextInt(rows);
    int endCol = random.nextInt(cols);
    while (startRow == endRow && startCol == endCol) {
      endRow = random.nextInt(rows);
      endCol = random.nextInt(cols);
    }
    grid.setStart(startRow, startCol);
    grid.setEnd(endRow, endCol);
  }

  PathFindingAlgorithm? get selectedAlgorithm => _selectedAlgorithm;
  set selectedAlgorithm(PathFindingAlgorithm? algorithm){
    _selectedAlgorithm = algorithm;
    grid.reset(keepWalls: true);
    Future.delayed(const Duration(milliseconds: 100)).then((_) {
      _findPathAndVisualize();
    });
    
  }

  _findPathAndVisualize() async {
    if (_selectedAlgorithm == null) return;
    grid.reset(keepWalls: true);
    _selectedAlgorithm?.init(grid);
    await _selectedAlgorithm?.findShortestPath().then((_){
      //_selectedAlgorithm?.constructPath();
    });
  }

  void randomizeWalls() {
    const double probability = 0.1; // 10% chance to be a wall
    final random = Random();
    grid.reset();
    for (var row in grid.cells) {
      for (var cell in row) {
        if (random.nextDouble() < probability) {
          cell.isWall = true;
        } else {
          cell.isWall = false;
        }
      }
    }
    notifyListeners();
  }

}
