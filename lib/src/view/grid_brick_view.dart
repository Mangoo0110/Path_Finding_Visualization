import 'package:flutter/material.dart';
import 'package:path_finding_visualization/src/controller/grid_brick_view_controller.dart';
import 'package:path_finding_visualization/src/interfaces/path_finding_algorithm.dart';
import '../model/grid.dart';

class GridBrickView extends StatefulWidget {
  const GridBrickView({super.key});

  @override
  State<GridBrickView> createState() => _GridBrickViewState();
}

class _GridBrickViewState extends State<GridBrickView> {
  final GridBrickViewController _gridBrickViewController = GridBrickViewController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Path Finding Visualization'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Controls
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownButton<PathFindingAlgorithmBase>(
                    hint: Text(_gridBrickViewController.selectedAlgorithm?.name ?? 'Select Algorithm'),
                    value: _gridBrickViewController.selectedAlgorithm,
                    items: _gridBrickViewController.algorithms.map((PathFindingAlgorithmBase algorithm) {
                      return DropdownMenuItem<PathFindingAlgorithmBase>(
                        value: algorithm,
                        
                        child: Text(algorithm.name.toUpperCase()),
                      );
                    }).toList(),
                    onChanged: (PathFindingAlgorithmBase? newValue) {
                      // Handle algorithm change
                      if (newValue != null) {
                        _gridBrickViewController.selectedAlgorithm = newValue;
                      }
                    },
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Handle randomize walls
                      _gridBrickViewController.randomizeWalls();
                    },
                    child: const Text('Randomize Walls'),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // set walls
                  ElevatedButton(
                    onPressed: () {
                      // Handle set walls
                     // _gridBrickViewController?.setWallsMode();
                    },
                    child: const Text('Set Walls'),
                  ),
                ],
              ),
            ],
          ),
          
          // Grid
          Flexible(child: TheGridWidget(viewController: _gridBrickViewController,)),
        ],
      ),
    );
  }
}

class TheGridWidget extends StatelessWidget {
  final GridBrickViewController viewController;
  const TheGridWidget({super.key, required this.viewController});

  @override
  Widget build(BuildContext context) {
    
    return LayoutBuilder(
      builder: (context, constraints) {
        debugPrint('Constraints: $constraints');
        final int rows = constraints.maxHeight ~/ 20;
        final int cols = constraints.maxWidth ~/ 20;
        viewController.init(rows: rows, cols: cols);
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < viewController.grid.rows; i++)
              Row(
                children: [
                  for (int j = 0; j < viewController.grid.cols; j++)
                    CellWidget(
                      cell: viewController.grid.cells[i][j],
                      height: 20,
                      width: 20,
                      onTap: () {
                        viewController.onTapOfCell(viewController.grid.cells[i][j]);
                      },
                    ),
                ],
              ),
          ],
        );
      },
    );
  }
}

extension CellExt on Cell{
  Color get color {
    if (isStart) return Colors.green;
    if (isEnd) return Colors.red;
    if (isWall) return Colors.black;
    if (isPath) return Colors.yellow;
    if (isVisited) return Colors.blue;
    return Colors.white;
  }
}

class CellWidget extends StatefulWidget {
  final Cell cell;
  final double height;
  final double width;
  final VoidCallback onTap;
  const CellWidget({super.key, required this.cell, required this.height, required this.width, required this.onTap});

  @override
  State<CellWidget> createState() => _CellWidgetState();
}

class _CellWidgetState extends State<CellWidget> {

  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onPanDown: (details) {
        
      },
      onPanEnd: (details) {
        
      },
      child: ListenableBuilder(
        listenable: widget.cell,
        builder:(context, child) {
          return AnimatedContainer(
            duration: Duration(milliseconds: 250),
            height: widget.height,
            width: widget.width,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12),
              color: widget.cell.color,
            ),
            child: Column(
              children: [
                (widget.cell.isStart)
                    ? const Icon(Icons.arrow_forward_ios_outlined, size: 16, color: Colors.white)
                    : (widget.cell.isEnd)
                        ? const Icon(Icons.radio_button_checked, size: 16, color: Colors.white)
                        : Container(),
              ],
            ),
          );
        
        }
      ),
    );
  }
}