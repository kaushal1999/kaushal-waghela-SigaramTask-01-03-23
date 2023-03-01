import 'package:flutter/material.dart';

import 'dart:collection';

class MyMatrix extends StatefulWidget {
  final int rows;
  final int columns;
  // final double size;

  const MyMatrix({super.key, this.rows = 4, this.columns = 4});

  @override
  MyMatrixState createState() => MyMatrixState();
}

class MyMatrixState extends State<MyMatrix> {
  late List<List<Color>> _colors;
  late Queue<int> q;
  @override
  void initState() {
    super.initState();
    q = Queue();
    _colors = List.generate(
        widget.rows, (_) => List.filled(widget.columns, Colors.blue));
  }

  void _changeColor(int row, int col, index) {
    setState(() {
      _colors[row][col] = Colors.red;
      q.add(index);
      if (q.length > 2) {
        int front = q.removeFirst();
        row = front ~/ widget.columns;
        col = front % widget.columns;
        _colors[row][col] = Colors.blue;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.75,
              child: GridView.builder(
                itemCount: widget.rows * widget.columns,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: widget.columns,
                ),
                itemBuilder: (BuildContext context, int index) {
                  int row = index ~/ widget.columns;
                  int col = index % widget.columns;
                  return InkWell(
                    onTap: () {
                      _changeColor(row, col, index);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        color: _colors[row][col],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
