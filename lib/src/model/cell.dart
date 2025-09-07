
part of 'grid.dart';

class Cell extends ChangeNotifier{
  final int row;
  final int col;
  bool _isStart = false;
  bool get isStart => _isStart;
  
  set isStart(bool value) {
    debugPrint('Cell at ($row, $col) isStart changed to $value');
    if (value && _isEnd) {
      // A cell cannot be both start and end
      _isEnd = false;
    }
    _isStart = value;
    _level = 0;
    notifyListeners();
  }

  bool _isEnd = false;
  set isEnd(bool value) {
    debugPrint('Cell at ($row, $col) isEnd changed to $value');
    if (value && _isStart) {
      // A cell cannot be both start and end
      _isStart = false;
    }
    _isEnd = value;
    notifyListeners();
  }
  bool get isEnd => _isEnd;

  bool _isWall = false;
  set isWall(bool value) {
    // Check if can be set as wall
    if (value && (_isStart || _isEnd)) {
      // A cell cannot be a wall if it's start or end
      return;
    }
    _isWall = value;
    notifyListeners();
  }
  bool get isWall => _isWall;

  bool _isVisited = false;
  bool get isVisited => _isVisited;
  set isVisited(bool value) {
    _isVisited = value;
    notifyListeners();
  }
  
  bool _isPath = false;
  set isPath(bool value) {
    _isPath = value;
    notifyListeners();
  }

  int _level = 0;
  int get level => _level;
  set level(int value) {
    _level = value;
    notifyListeners();
  }

  bool get isPath => _isPath;

  Cell({
    required this.row,
    required this.col,
  });

  // reset cell
  void _reset({bool keepWallState = true}) {
    if(!keepWallState) _isWall = false;
    isVisited = false;
    _isPath = false;
    notifyListeners();
  }

  bool _visualizeVisted = false;
  bool get visualizeVisited => _visualizeVisted;
  set visualizeVisited(bool value) {
    _visualizeVisted = value;
    notifyListeners(); 
  }

  bool _visualizePath = false;
  bool get visualizePath => _visualizePath;
  set visualizePath(bool value) {
    _visualizePath = value;
    notifyListeners();
  }


  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! Cell) return false;
    return row == other.row && col == other.col;
  }

  @override
  int get hashCode => Object.hash(row, col);
}