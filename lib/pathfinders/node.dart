import 'package:flutter/material.dart';

class Node{
  Node(this.position);
  final Offset position;

  bool visited = false;
  bool isWall = false;  // check the corr node is wall or not

  Node? previous;

  double f=0, g =0, h=0;

  Node clone() => Node(position)
    ..visited = visited
    ..isWall = isWall
    ..previous = previous
    ..f = f
    ..g = g
    ..h = h;

  static List<List<Node>> cloneList(List<List<Node>> list) {
    final List<List<Node>> newList = <List<Node>>[];

    for (final List<Node> nodes in list) {
      final List<Node> row = <Node>[];
      for (final Node node in nodes) {
        row.add(node.clone());
      }
      newList.add(row);
    }
    return newList;  // Return the newList
  }

}