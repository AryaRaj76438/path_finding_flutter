
import 'package:path_finding_algo/pathfinders/node.dart';

import 'base_path_finder.dart';

class AstarPathFinder extends BasePathFinder{
  AstarPathFinder(): super('A* Path Finder');

  @override
  Stream<List<List<Node>>> call(List<List<Node>> graph, Node start, Node end, [Duration delay = const Duration(milliseconds: 10)])
  async*{
    final List<Node> queue = <Node>[start];

    while(queue.isNotEmpty){
      final Node node = getBest(queue);
      if(node == end){
        return;
      }
      node.visited = true;

      final List<Node> neighbors = getNeighbors(graph, node);
      for(final Node neighbor in neighbors){
        if(neighbor.visited){
          continue;
        }
        neighbor
        ..g = node.g+1
        ..h = calculateHuristic(neighbor, end).toDouble()
        ..f = neighbor.g + neighbor.h
        ..visited = true
        ..previous = node;

        queue.add(neighbor);
      }
      await Future<void>.delayed(delay);
      yield graph;
    }
  }

  Node getBest(List<Node> queue) {
    Node best = queue.first;
    for(final Node node in queue){
      if(node.f<best.f){
        best = node;
      }
    }
    queue.remove(best);
    return best;
  }

  double calculateHuristic(Node neighbor, Node end) =>
      (neighbor.position.dx - end.position.dx).abs() +
          (neighbor.position.dy - end.position.dy).abs();// Super


}